import 'package:get/get.dart';
import 'package:password_management/core/constants/account_constanst.dart';
import 'package:password_management/data/datasources/remote/supabase_manager.dart';
import 'package:password_management/data/models/account_model.dart';

class HomeController extends GetxController {
  List<AccountModel> accounts = [];

  Future<void> loadData() async {
     final datas = await SupabaseManager.getAll(AccountConstanst.tableName);
    accounts =
        (datas as List).map((json) => AccountModel.fromJson(json)).toList();
  }
}
