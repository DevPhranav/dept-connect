import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class FileStorage {
  static Future<String> getExternalDocumentPath() async {
    // Check whether permission is given for this app or not.
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      // If not, request permission
      await Permission.storage.request();
    }

    Directory _directory;
    if (Platform.isAndroid) {
      // Redirects to the download folder in Android
      _directory = Directory("/storage/emulated/0/Download");
    } else {
      _directory = await getApplicationDocumentsDirectory();
    }

    final exPath = _directory.path;
    print("Saved Path: $exPath");
    await Directory(exPath).create(recursive: true);
    return exPath;
  }

  static Future<String> get _localPath async {
    // Get the external path of the device's download folder
    final String directory = await getExternalDocumentPath();
    return directory;
  }

  static Future<File> writeCounter(String bytes, String name) async {
    final path = await _localPath;
    // Create a file with the given path and name
    File file = File('$path/$name');
    print("Save file");
    // Write the data to the created file
    return file.writeAsString(bytes);
  }
}

Future<String> downloadFile(String downloadUrl, String fileName,String id) async {
  final response = await http.get(Uri.parse(downloadUrl));
  final bytes = response.bodyBytes;

  // Get the external storage directory
  final directory = await getExternalStorageDirectory();

  // Create a new directory named 'id' inside the external storage directory
  final newDirectory = Directory('${directory?.path}/$id');
  await newDirectory.create(recursive: true);

  // Create the file inside the new directory
  final file = File('${newDirectory.path}/$fileName');
  await file.writeAsBytes(bytes);

  print("File downloaded to: ${file.path}");
  return file.path;
}
