import 'dart:io';
import 'package:excel/excel.dart';
import 'package:password_management/data/models/account_model.dart';
import 'package:path_provider/path_provider.dart';

class ExcelUtil {
  ExcelUtil._();

  static Future<File?> exportAccountsToExcel(
    List<AccountModel> accounts,
  ) async {
    final excel = Excel.createExcel();
    final Sheet sheet = excel['Accounts'];

    sheet.appendRow([
      TextCellValue("Id"),
      TextCellValue("App Name"),
      TextCellValue("UserName"),
      TextCellValue("Password"),
      TextCellValue("Note"),
      TextCellValue("UserId"),
    ]);

    for (var account in accounts) {
      sheet.appendRow([
        TextCellValue(account.id),
        TextCellValue(account.appName),
        TextCellValue(account.userName),
        TextCellValue(account.password),
        TextCellValue(account.note),
        TextCellValue(account.userId),
      ]);
    }
    // Lấy dữ liệu nhị phân từ excel
    final List<int>? bytes = excel.encode();

    if (bytes == null) {
      return null;
    }

    // Lưu tạm file vào bộ nhớ trong (temporary directory)
    final tempDir = await getTemporaryDirectory();
    final tempFile = File('${tempDir.path}/accounts.xlsx');
    await tempFile.writeAsBytes(bytes, flush: true);
    return tempFile;
  }
}
