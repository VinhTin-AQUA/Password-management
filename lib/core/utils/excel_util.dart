import 'dart:io';
import 'package:excel/excel.dart';
import 'package:password_management/data/models/account_model.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:path_provider/path_provider.dart';

class ExcelUtil {
  ExcelUtil._();

  static Future<void> exportAccountsToExcel(
    List<AccountModel> accounts,
    String outputFile,
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

    final dir = await getApplicationDocumentsDirectory();
    final filePath = '${dir.path}/accounts.xlsx';
     File(filePath)
          ..createSync(recursive: true)
          ..writeAsBytesSync(excel.encode()!);

    // final file =
    //     File(filePath)
    //       ..createSync(recursive: true)
    //       ..writeAsBytesSync(excel.encode()!);
  }
}
