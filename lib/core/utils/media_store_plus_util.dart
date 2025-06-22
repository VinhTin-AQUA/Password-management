import 'dart:io';
import 'package:media_store_plus/media_store_plus.dart';

class MediaStorePlusUtil {
  MediaStorePlusUtil._();

  static Future<bool> saveFileToDownloads(File file) async {
    try {
      final mediaStore = MediaStore();
      final r = await mediaStore.saveFile(
        tempFilePath: file.path,
        dirType: DirType.download,
        dirName: DirName.download,
        relativePath: "Password Management",
      );

      if (r == null) {
        return false;
      }

      if (await file.exists()) {
        await file.delete();
      }
      return r.isSuccessful;
    } catch (ex) {
      return false;
    }
  }
}
