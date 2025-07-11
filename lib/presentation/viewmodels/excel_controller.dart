import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:password_management/data/helpers/excel_helper.dart';
import 'package:password_management/data/helpers/media_store_plus_helper.dart';
import 'package:password_management/data/models/account_model.dart';

class ExcelController extends GetxController {
  Future<bool> exportExcel(List<AccountModel> accounts) async {
    final file = await ExcelHelper.exportAccountsToExcel(accounts);

    if (file == null) {
      return false;
    }

    final r = await MediaStorePlusHelper.saveFileToDownloads(file);
    return r;
  }
}
