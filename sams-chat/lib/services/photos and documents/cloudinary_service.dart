import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:convert';

class CloudinaryService {
  Future<String?> uploadFileToCloudinary(File file, String folderName) async {
    const cloudName = 'YOUR_CLOUDINARY_CLOUD_NAME'; // Cloudinary Cloud Name
    const uploadPreset = 'YOUR_UNSIGNED_UPLOAD_PRESET'; // Upload Preset

    final url = Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/upload');

    final request =
        http.MultipartRequest('POST', url)
          ..fields['upload_preset'] = uploadPreset
          ..fields['folder'] = folderName
          ..files.add(
            await http.MultipartFile.fromPath(
              'file',
              file.path,
              contentType: MediaType('application', 'octet-stream'),
            ),
          );

    final response = await request.send();

    if (response.statusCode == 200) {
      final resStream = await response.stream.bytesToString();
      final data = jsonDecode(resStream);
      return data['secure_url']; // 🔥 This is the link you will save in your database
    } else {
      print('Upload failed: ${response.statusCode}');
      return null;
    }
  }
}
