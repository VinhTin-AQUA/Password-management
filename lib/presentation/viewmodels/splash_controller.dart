import 'dart:io';

import 'package:media_store_plus/media_store_plus.dart';
import 'package:password_management/core/utils/secure_storage_util.dart';
import 'package:password_management/data/helpers/supabase_helper.dart';

class SplashController {
  static Future<bool> isInit() async {
    String? value = await SecureStorageUtil.getValue(
      SupabaseHelper.supabaseKey,
    );
    return value != null;
  }

  static void initGetXControllers() {}

  static Future<void> initmediaStorePlus() async {
    if (Platform.isAndroid) {
      await MediaStore.ensureInitialized();
      MediaStore.appFolder = "MediaStorePlugin";
    }
  }
}
