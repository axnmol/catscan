import 'dart:developer';
import 'dart:io';
import 'package:catscan/constants.dart';
import 'package:catscan/models/response_models.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http_parser/http_parser.dart';

class UploadScreen extends StatefulWidget {
  final List<XFile> images;
  final String projectName;

  const UploadScreen(this.images, {Key? key, required this.projectName})
      : super(key: key);

  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  bool loading = true;
  final box = GetStorage();
  String apiResult = "nothing";
  int linkCopyIndex = -1;

  @override
  void initState() {
    super.initState();
  }

  Future<UploadApiResponse> uploadSingleImage(
      XFile imageFile, String uuid) async {
    XFile compressedFile = await compressFile(File(imageFile.path));
    Dio dio = Dio();
    dio.options.headers["Content-Type"] = "multipart/form-data";
    FormData formData = FormData.fromMap({
      "img": MultipartFile.fromFileSync(compressedFile.path,
          filename: compressedFile.name, contentType: MediaType("image", "jpg"))
    });

    Response response = await dio.post(
        'https://a6b2-14-98-199-186.ngrok.io/api/image/upload',
        data: formData,
        queryParameters: {"userId": uuid, "projectName": widget.projectName});
    return UploadApiResponse.fromJson(response.data);
  }

  Future<UploadUrlsResponse> uploadImages() async {
    final uuid = box.read(UUID_KEY);
    assert(uuid != null);
    List<UploadApiResponse> responses = await Future.wait(
        widget.images.map((xFile) => uploadSingleImage(xFile, uuid)).toList());
    return UploadUrlsResponse(
        userId: uuid,
        projectName: widget.projectName,
        urls: responses.map((res) => res.imageUrl).toList());
  }

  Future<XFile> compressFile(File file) async {
    final filePath = file.absolute.path;

    // Create output file path
    // eg:- "Volume/VM/abcd_out.jpeg"
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: FutureBuilder(
          future: uploadImages(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return results(snapshot.data!);
            } else if (snapshot.hasError) {
              log(snapshot.error.toString());
              return const SizedBox(
                  height: double.infinity,
                  child: Center(child: Text("Something went wrong")));
            } else {
              return SizedBox(
                height: double.infinity,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ));
  }

  Widget results(UploadUrlsResponse response) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 8,
        ),
        Text(
          "Generated links",
        ),
        Expanded(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: response.urls.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14),
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(
                        response.urls[index],
                      )),
                    ],
                  ),
                );
              }),
        ),
        shareButton(response.urls)
      ],
    );
  }

  Widget shareButton(List<String> urls) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            log("shared");
          },
          style: ButtonStyle(),
          child: Text(
            "Share",
          ),
        ),
      ),
    );
  }
}
