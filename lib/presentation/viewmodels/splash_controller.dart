import 'dart:io';

import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:media_store_plus/media_store_plus.dart';
import 'package:password_management/core/router/routes.dart';
import 'package:password_management/core/utils/secure_storage_util.dart';
import 'package:password_management/data/helpers/supabase_helper.dart';
import 'package:password_management/data/supabase/base_supabase.dart';

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

  static Future<void> initSupabase() async {
    var supabaseKey = await SecureStorageUtil.getValue(
      SupabaseHelper.supabaseKey,
    );
    var supabaseUrl = await SecureStorageUtil.getValue(
      SupabaseHelper.supabaseUrl,
    );

    if (supabaseUrl == null || supabaseKey == null) {
      Get.offAllNamed(TRoutes.setupSupabaseKey);
      return;
    }

    await SupabaseManager.initSupabase(supabaseUrl, supabaseKey);
  }
}
