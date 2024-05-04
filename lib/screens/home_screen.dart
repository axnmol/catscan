import 'dart:io';
import 'package:catscan/api/azapi.dart';
import 'package:catscan/api/mlapi.dart';
import 'package:catscan/constants.dart';
import 'package:catscan/helpers.dart';
import 'package:catscan/hero_dialog_route.dart';
import 'package:catscan/media_picker.dart';
import 'package:catscan/screens/preview_screen.dart';
import 'package:catscan/screens/upload_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get_storage/get_storage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<File> images = [];
  List<File> processedImages = [];

  final productNameController = TextEditingController();
  final box = GetStorage();

  void ensureUIDGenerated() {
    final uid = box.read(UUID_KEY);
    if (uid == null) {
      box.write(UUID_KEY, getUniqueId());
    }
  }

  @override
  void initState() {
    super.initState();
    ensureUIDGenerated();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blueGrey,
        title: const Center(
            child: Text('CATSCAN', style: TextStyle(letterSpacing: 10))),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ElevatedButton(
              //   style: ButtonStyle(
              //     backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
              //   ),
              //   onPressed: () async {
              //     if (images.isEmpty) {
              //       ScaffoldMessenger.of(context).showSnackBar(
              //         const SnackBar(
              //           backgroundColor: Colors.blueGrey,
              //           content: Text(
              //             "First upload photo",
              //             style: TextStyle(
              //               letterSpacing: 2,
              //             ),
              //             textAlign: TextAlign.center,
              //           ),
              //         ),
              //       );
              //     } else {
              //       setState(() {
              //         isloading = true;
              //       });
              //       processedImages = await uploadFilesAndExtractZip(images);
              //       setState(() {
              //         isloading = false;
              //       });
              //     }
              //   },
              //   child: isloading
              //       ? const CircularProgressIndicator()
              //       : const Text(
              //           'Analyze',
              //           style: TextStyle(
              //             fontSize: 25,
              //           ),
              //         ),
              // ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: productNameController,
                  decoration: InputDecoration(
                    labelText: 'Enter Product Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    errorText: productNameController.text.isEmpty
                        ? 'Product name cannot be empty'
                        : null,
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.blueGrey),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.blueGrey),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.red, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onChanged: (value) => setState(() {}),
                ),
              ),
              const Divider(color: Colors.blueGrey, thickness: 1),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: images.length + 1,
                    itemBuilder: (context, index) {
                      if (index == images.length) {
                        return InkWell(
                          onTap: () async {
                            List<File> uploadedImages = await showDialog(
                                context: context,
                                builder: (context) => const MediaPicker());
                            if (uploadedImages.isNotEmpty) {
                              setState(() => images.addAll(uploadedImages));
                            }
                          },
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.blueGrey,
                                width: 4,
                              ),
                            ),
                            padding: const EdgeInsets.all(8),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Icon(
                                      Icons.add_a_photo,
                                      color: Colors.blueGrey,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    "Upload Photo",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: Colors.blueGrey,
                                      letterSpacing: 2,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }
                      return Stack(
                        children: [
                          Container(
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.blueGrey,
                                width: 4,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: LayoutBuilder(
                                builder: (_, constraints) =>
                                    ClickableImageWidget(
                                  normalSizeConstraints: constraints,
                                  file: images[index],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: GestureDetector(
                              onTap: () =>
                                  setState(() => images.remove(images[index])),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.blueGrey,
                                    width: 4,
                                  ),
                                ),
                                padding: const EdgeInsets.all(2),
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
              ),
              const Divider(color: Colors.blueGrey, thickness: 1),
              ElevatedButton(
                onPressed: productNameController.text.isEmpty
                    ? null
                    : () {
                        Navigator.of(context)
                            .push(
                          MaterialPageRoute(
                            builder: (context) => PreviewScreen(
                              images: images,
                              productName: productNameController.text,
                            ),
                          ),
                        )
                            .then((value) {
                          productNameController.clear();
                          setState(() {
                            images = [];
                          });
                        });
                      },
                style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey),
                child: const SizedBox(
                  width: double.maxFinite,
                  child: Text(
                    'Proceed',
                    style: TextStyle(
                      fontSize: 25,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
