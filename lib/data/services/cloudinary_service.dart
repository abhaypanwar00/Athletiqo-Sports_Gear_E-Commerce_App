import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart' as path;

class CloudinaryService {
  final String cloudName = 'ddacowjwz';
  final String uploadPreset = 'unsigned_upload_preset';

  Future<String> uploadImage({
    required File imageFile,
    required String productId,
    required String colorName,
  }) async {
    final folderPath = 'products/$productId/$colorName';

    final url = Uri.parse(
      'https://api.cloudinary.com/v1_1/$cloudName/image/upload',
    );

    final mimeType = lookupMimeType(imageFile.path) ?? 'image/jpeg';

    // print('Uploading image to Cloudinary...');
    // print('File path: ${imageFile.path}');
    // print('MIME type: $mimeType');
    // print('Upload URL: $url');
    // print('Upload preset: $uploadPreset');
    // print('Folder: $folderPath');

    final request =
        http.MultipartRequest('POST', url)
          ..fields['upload_preset'] = uploadPreset
          ..fields['folder'] = folderPath
          ..files.add(
            await http.MultipartFile.fromPath(
              'file',
              imageFile.path,
              contentType: MediaType.parse(mimeType),
              filename: path.basename(imageFile.path),
            ),
          );

    // print('Request fields: ${request.fields}');
    // print('Request files: ${request.files.map((f) => f.filename).toList()}');

    final response = await request.send();
    final responseData = await response.stream.bytesToString();

    // print('Response status code: ${response.statusCode}');
    // print('Response body: $responseData');

    if (response.statusCode == 200) {
      final decodedData = jsonDecode(responseData);
      // print('Image uploaded successfully: ${decodedData['secure_url']}');
      return decodedData['secure_url'];
    } else {
      throw Exception('Failed to upload image: $responseData');
    }
  }

  Future<List<String>> uploadMultipleImages({
    required List<File> images,
    required String productId,
    required String colorName,
  }) async {
    List<String> uploadedUrls = [];

    for (var image in images) {
      try {
        final url = await uploadImage(
          imageFile: image,
          productId: productId,
          colorName: colorName,
        );
        uploadedUrls.add(url);
      } catch (e) {
        throw Exception('Failed to upload images.');
        // print('Failed to upload one of the images: $e');
      }
    }

    return uploadedUrls;
  }
}
