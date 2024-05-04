import 'dart:io';
import 'package:archive/archive_io.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

Future<List<File>> uploadFilesAndExtractZip(List<File> files) async {
  final uri = Uri.parse('https://1ee5-14-98-199-186.ngrok.io/process_images');

  final request = http.MultipartRequest('POST', uri);

  for (File file in files) {
    final stream = http.ByteStream(file.openRead());
    final length = await file.length();

    final multipartFile = http.MultipartFile('image', stream, length,
        filename: file.path.split('/').last);
    request.files.add(multipartFile);
  }

  final response = await request.send();

  if (response.statusCode == 200) {
    final responseBytes = await response.stream.toBytes();
    List<File> files = [];

    final appDir = await getApplicationDocumentsDirectory();
    final outDir = Directory('${appDir.path}/out');
    await outDir.create(recursive: true);

    final archive = ZipDecoder().decodeBytes(responseBytes);
    for (ArchiveFile file in archive) {
      if (file.isFile) {
        final outputFile = File('${outDir.path}/${file.name.split("/").last}');
        await outputFile.writeAsBytes(file.content);
        files.add(outputFile);
      }
    }
    return files;
  }
  return [];
}
