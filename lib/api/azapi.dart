import 'dart:io';
import 'dart:developer';
import 'package:catscan/constants.dart';
import 'package:catscan/models/response_models.dart';
import 'package:dio/dio.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get_storage/get_storage.dart';
// ignore: depend_on_referenced_packages
import 'package:http_parser/http_parser.dart';

Future<UploadApiResponse> uploadSingleImage(
    File imageFile, String uuid, String productName) async {
  XFile compressedFile = await compressFile(File(imageFile.path));
  Dio dio = Dio();
  dio.options.headers["Content-Type"] = "multipart/form-data";
  FormData formData = FormData.fromMap({
    "img": MultipartFile.fromFileSync(compressedFile.path,
        filename: compressedFile.name, contentType: MediaType("image", "jpg"))
  });

  Response response = await dio.post(
      'https://c56c-14-98-199-186.ngrok.io:7000/api/image/upload',
      data: formData,
      queryParameters: {"userId": uuid, "projectName": productName});
  return UploadApiResponse.fromJson(response.data);
}

Future<UploadUrlsResponse> uploadImages(
    GetStorage box, List<File> images, String productName) async {
  final uuid = box.read(UUID_KEY);
  assert(uuid != null);
  List<UploadApiResponse> responses = await Future.wait(images
      .map((xFile) => uploadSingleImage(xFile, uuid, productName))
      .toList());
  print(UploadUrlsResponse(
    userId: uuid,
    projectName: productName,
    urls: responses.map((res) => res.imageUrl).toList(),
  ));
  return UploadUrlsResponse(
    userId: uuid,
    projectName: productName,
    urls: responses.map((res) => res.imageUrl).toList(),
  );
}

Future<XFile> compressFile(File file) async {
  final filePath = file.absolute.path;

  final lastIndex = filePath.lastIndexOf(RegExp(r'.jp'));
  final splitted = filePath.substring(0, (lastIndex));
  final outPath = "${splitted}_out${filePath.substring(lastIndex)}";
  var result = await FlutterImageCompress.compressAndGetFile(
    file.absolute.path,
    outPath,
    quality: 60,
  );
  log("quality reduction");
  log(file.lengthSync().toString());
  log((await result!.length()).toString());

  return result;
}
