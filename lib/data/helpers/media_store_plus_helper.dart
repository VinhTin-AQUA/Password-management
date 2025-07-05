import 'dart:io';
import 'package:media_store_plus/media_store_plus.dart';

class MediaStorePlusHelper {
  MediaStorePlusHelper._();

  static Future<bool> saveFileToDownloads(File file) async {
    final mediaStore = MediaStore();
    final r = await mediaStore.saveFile(
      tempFilePath: file.path,
      dirType: DirType.download,
      dirName: DirName.download,
      relativePath: "Password Management",
    );

    if (await file.exists()) {
      await file.delete();
    }

    return true;

    // if (r == null) {
    //   return false;
    // }

    // if (await file.exists()) {
    //   await file.delete();
    // }
    // return r.isSuccessful;
  }
}
