import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:password_management/core/utils/excel_util.dart';
import 'package:password_management/core/utils/media_store_plus_util.dart';
import 'package:password_management/data/models/account_model.dart';

class ExcelController extends GetxController {
  Future<bool> exportExcel(List<AccountModel> accounts) async {
    final file = await ExcelUtil.exportAccountsToExcel(accounts);

    if (file == null) {
      return false;
    }

    final r = await MediaStorePlusUtil.saveFileToDownloads(file);
    return r;
  }
}
