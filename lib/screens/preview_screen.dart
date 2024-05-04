import 'dart:io';
import 'package:catscan/api/mlapi.dart';
import 'package:catscan/hero_dialog_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PreviewScreen extends StatefulWidget {
  final List<File> images;
  final String productName;
  const PreviewScreen(
      {Key? key, required this.images, required this.productName})
      : super(key: key);

  @override
  State<PreviewScreen> createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blueGrey,
        title: Center(child: Text(widget.productName)),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: FutureBuilder<List<File>>(
          future: uploadFilesAndExtractZip(widget.images),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CupertinoActivityIndicator(),
                  const SizedBox(height: 8),
                  const Text(
                    "Please wait!!",
                    style: TextStyle(color: Colors.blueGrey, fontSize: 25),
                  ),
                  Text(
                    "Magic takes time",
                    style: TextStyle(color: Colors.blueGrey.shade300),
                  )
                ],
              ));
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Container(
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
                        builder: (_, constraints) => ClickableImageWidget(
                          normalSizeConstraints: constraints,
                          file: snapshot.data![index],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
