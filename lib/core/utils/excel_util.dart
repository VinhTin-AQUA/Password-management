import 'dart:io';
import 'package:excel/excel.dart';
import 'package:password_management/core/utils/secure_storage_util.dart';
import 'package:password_management/data/helpers/passcode_helper.dart';
import 'package:password_management/data/helpers/supabase_helper.dart';
import 'package:password_management/data/models/account_model.dart';
import 'package:path_provider/path_provider.dart';

class ExcelUtil {
  ExcelUtil._();

  static Future<File?> exportAccountsToExcel(
    List<AccountModel> accounts,
  ) async {
    final excel = Excel.createExcel();
    final Sheet accountSheet = excel['Accounts'];
    final Sheet sheetPascode = excel['Passcode'];

    accountSheets(accountSheet, accounts);
    await passcodeSheet(sheetPascode);

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

  static void accountSheets(Sheet accountSheet, List<AccountModel> accounts) {
    accountSheet.appendRow([
      TextCellValue("Id"),
      TextCellValue("App Name"),
      TextCellValue("UserName"),
      TextCellValue("Password"),
      TextCellValue("Note"),
      TextCellValue("UserId"),
    ]);

    for (var account in accounts) {
      accountSheet.appendRow([
        TextCellValue(account.id),
        TextCellValue(account.appName),
        TextCellValue(account.userName),
        TextCellValue(account.password),
        TextCellValue(account.note),
        TextCellValue(account.userId),
      ]);
    }
  }

  static Future<void> passcodeSheet(Sheet passcodeSheet) async {
    var key = await SecureStorageUtil.getValue(PasscodeHelper.passCodeKey);
    var supabaseKey = await SecureStorageUtil.getValue(
      SupabaseHelper.supabaseKey,
    );
    var supabaseUrl = await SecureStorageUtil.getValue(
      SupabaseHelper.supabaseUrl,
    );
    passcodeSheet.appendRow([
      TextCellValue("Passcode"),
      TextCellValue("Supabase Key"),
      TextCellValue("Supabase Url"),
    ]);
    passcodeSheet.appendRow([
      TextCellValue(key ?? ""),
      TextCellValue(supabaseKey ?? ""),
      TextCellValue(supabaseUrl ?? ""),
    ]);

    passcodeSheet.setColumnWidth(1, 20);
    passcodeSheet.setColumnWidth(2, 20);
  }
}
