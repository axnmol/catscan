import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:share_plus/share_plus.dart';

class HeroDialogRoute<T> extends PageRoute<T> {
  HeroDialogRoute({required this.builder}) : super();

  final WidgetBuilder builder;

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 200);

  @override
  bool get maintainState => true;

  @override
  Color get barrierColor => Colors.black54;

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
        opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
        child: child);
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return builder(context);
  }

  @override
  String? get barrierLabel => null;
}

class ClickableImageWidget extends StatelessWidget {
  final File file;
  final BoxConstraints normalSizeConstraints;
  final BoxConstraints? enlargedSizeConstraints;

  const ClickableImageWidget(
      {Key? key,
      required this.normalSizeConstraints,
      this.enlargedSizeConstraints,
      required this.file})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          HeroDialogRoute(
            builder: (BuildContext context) {
              return Dialog(
                child: ConstrainedBox(
                  constraints: enlargedSizeConstraints ??
                      BoxConstraints.tight(const Size(320, 480)),
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Hero(
                        tag: file.path,
                        child: Image.file(file),
                      ),
                      Positioned(
                        bottom: 10,
                        child: Row(
                          children: [
                            Container(
                              width: 125,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: ElevatedButton(
                                onPressed: () {
                                  Share.shareXFiles([XFile(file.path)]);
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blueGrey),
                                child: const Text("Share"),
                              ),
                            ),
                            Container(
                              width: 125,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: ElevatedButton(
                                onPressed: () async {
                                  await FlutterDownloader.enqueue(
                                    url: file.path,
                                    savedDir:
                                        "/storage/emulated/0/Download", // Change this to your desired download directory
                                    fileName:
                                        "image.png", // Change the filename as needed
                                    showNotification: true,
                                    openFileFromNotification: true,
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blueGrey),
                                child: const Text("Download"),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
      child: ConstrainedBox(
        constraints: normalSizeConstraints,
        child: Hero(
          tag: file.path,
          child: Image.file(file),
        ),
      ),
    );
  }
}
