import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;

final storageServiceProvider = Provider((ref) => StorageService());

class StorageService {
  // Access instance inside methods to avoid LateInitializationError during lazy initialization
  FirebaseStorage get _storage => FirebaseStorage.instance;

  /// Picks an image from the local computer and uploads it to Firebase Storage.
  /// Returns the download URL if successful, or null if canceled/failed.
  Future<String?> pickAndUploadImage({String folder = 'lessons/images'}) async {
    try {
      // Accessing FirebaseStorage inside the method to ensure Firebase is ready
      final storage = _storage;
      
      // 1. Pick file
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'gif', 'webp'],
        withData: true,
      );

      if (result == null || result.files.isEmpty) {
        debugPrint('Image picking canceled or no files selected.');
        return null;
      }
      
      final file = result.files.first;
      final bytes = file.bytes;
      if (bytes == null) {
        debugPrint('Failed to read file bytes.');
        return null;
      }

      // 2. Prepare upload path
      final fileName = '${DateTime.now().millisecondsSinceEpoch}_${p.basename(file.name)}';
      final storageRef = storage.ref().child('$folder/$fileName');

      // 3. Start Upload
      debugPrint('Uploading image to: $folder/$fileName...');
      final uploadTask = storageRef.putData(
        bytes,
        SettableMetadata(contentType: _getContentType(file.extension)),
      );

      // 4. Return Download URL
      final snapshot = await uploadTask;
      final url = await snapshot.ref.getDownloadURL();
      debugPrint('Upload successful: $url');
      return url;
      
    } catch (e) {
      debugPrint('Storage Service: $e');
      return null;
    }
  }

  String _getContentType(String? ext) {
    switch (ext?.toLowerCase()) {
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'gif':
        return 'image/gif';
      case 'webp':
        return 'image/webp';
      default:
        return 'application/octet-stream';
    }
  }
}
