import os
import torch
import torch.nn.functional as F
from torch.utils.data import DataLoader
from torchvision import transforms
import skimage.io as io
import cv2
import numpy as np
from PIL import Image
import glob
from pathlib import Path
from flask import Flask, request, jsonify, send_file

from data_loader import RescaleT, ToTensorLab, SalObjDataset
from model import U2NET


def normPRED(d):
    ma = torch.max(d)
    mi = torch.min(d)
    dn = (d - mi) / (ma - mi)
    return dn


def get_image_path(image_name, directory):
    img_name = Path(image_name).stem
    return directory / f"{img_name}.png"


def save_output(image_name, pred, prediction_dir):
    predict = pred.squeeze()
    predict_np = predict.cpu().data.numpy()
    im = Image.fromarray(predict_np * 255).convert("RGB")
    image = io.imread(image_name)
    imo = im.resize((image.shape[1], image.shape[0]), resample=Image.BILINEAR)
    image_path = get_image_path(image_name, prediction_dir)
    imo.save(image_path)
    return image_path


def save_file(image_name, img, o_dir):
    imo = Image.fromarray(img)
    image_path = get_image_path(image_name, o_dir)
    imo.save(image_path)


def process_images():
    image_dir = Path("input")
    prediction_dir = Path("pred")
    output_dir = Path("output")
    model_dir = Path("u2net.pth")

    img_name_list = glob.glob(str(image_dir / "*"))

    test_salobj_dataset = SalObjDataset(
        img_name_list=img_name_list,
        lbl_name_list=[],
        transform=transforms.Compose([RescaleT(320), ToTensorLab(flag=0)]),
    )
    test_salobj_dataloader = DataLoader(
        test_salobj_dataset, batch_size=1, shuffle=False, num_workers=1
    )

    device = torch.device("cuda:0" if torch.cuda.is_available() else "cpu")
    net = U2NET(3, 1).to(device)
    net.load_state_dict(torch.load(model_dir, map_location=device))
    net.eval()

    for i_test, data_test in enumerate(test_salobj_dataloader):
        print("inferencing:", Path(img_name_list[i_test]).stem)
        inputs_test = data_test["image"].type(torch.FloatTensor).to(device)
        with torch.no_grad():
            d1, _, _, _, _, _, _ = net(inputs_test)

            # normalization
            pred = d1[:, 0, :, :]
            pred = normPRED(pred)

            # save results to prediction_dir folder
            prediction_dir.mkdir(parents=True, exist_ok=True)
            image_path = save_output(img_name_list[i_test], pred, prediction_dir)

            u2netresult = cv2.imread(str(image_path))
            original = cv2.imread(img_name_list[i_test])
            img_gray = cv2.cvtColor(u2netresult, cv2.COLOR_BGR2GRAY)
            _, mask = cv2.threshold(
                img_gray, 0, 255, cv2.THRESH_BINARY + cv2.THRESH_OTSU
            )

            contours, _ = cv2.findContours(mask, cv2.RETR_TREE, cv2.CHAIN_APPROX_NONE)
            biggest_area = -1
            biggest = None
            for contour in contours:
                area = cv2.contourArea(contour)
                if biggest_area < area:
                    biggest_area = area
                    biggest = contour

            mask_filled = np.zeros_like(mask)
            cv2.drawContours(mask_filled, [biggest], -1, 255, -1)
            mask_filled_rgb = cv2.cvtColor(mask_filled, cv2.COLOR_GRAY2RGB)

            save_file(img_name_list[i_test], mask_filled_rgb, prediction_dir)

            original_rgba = cv2.cvtColor(original, cv2.COLOR_BGR2BGRA)
            mask_gray = cv2.cvtColor(mask_filled_rgb, cv2.COLOR_BGR2GRAY)
            _, mask_binary = cv2.threshold(mask_gray, 1, 255, cv2.THRESH_BINARY)
            original_rgba[:, :, 3] = cv2.bitwise_and(
                original_rgba[:, :, 3], mask_binary
            )

            output_path = get_image_path(img_name_list[i_test], output_dir)
            cv2.imwrite(str(output_path), original_rgba)

            del d1
    return


app = Flask(__name__)


@app.route("/process_images", methods=["POST"])
def process_images_endpoint():
    for filename in os.listdir(Path("input")):
        file_path = os.path.join(Path("input"), filename)
        if os.path.isfile(file_path):
            os.remove(file_path)

    for filename in os.listdir(Path("output")):
        file_path = os.path.join(Path("output"), filename)
        if os.path.isfile(file_path):
            os.remove(file_path)

    for filename in os.listdir(Path("pred")):
        file_path = os.path.join(Path("pred"), filename)
        if os.path.isfile(file_path):
            os.remove(file_path)

    zip_path = "processed_images.zip"

    if os.path.exists(zip_path):
        os.remove(zip_path)

    print("API CALLED")
    if request.method == "POST":
        processed_images = []
        for img in request.files.getlist("image"):
            img_path = Path("input") / img.filename
            img.save(img_path)
            process_images()

        for file_path in Path("output").iterdir():
            if file_path.is_file():
                processed_images.append(file_path)

        output_zip_path = create_zip(processed_images)
        return send_file(output_zip_path, as_attachment=True)


def create_zip(file_paths):
    import zipfile

    output_zip_path = "processed_images.zip"
    with zipfile.ZipFile(output_zip_path, "w") as zipf:
        for path in file_paths:
            zipf.write(path)

    return output_zip_path


if __name__ == "__main__":
    port = int(os.environ.get("PORT", 5000))
    app.run(debug=True, host="0.0.0.0", port=port)
