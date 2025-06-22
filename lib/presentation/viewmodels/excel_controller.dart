import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:password_management/core/utils/excel_util.dart';
import 'package:password_management/core/utils/path_provider_util.dart';
import 'package:password_management/data/models/account_model.dart';

class ExcelController extends GetxController {
  Future<bool> exportExcel(List<AccountModel> accounts) async {
    String? outputFile = await PathProviderUtil.getDownloadDirectoryPath();
    if (outputFile == null) {
      return false;
    }

    await ExcelUtil.exportAccountsToExcel(accounts, outputFile);
    return true;
  }
}
