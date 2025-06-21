import 'package:get/get.dart';
import 'package:password_management/core/constants/account_constanst.dart';
import 'package:password_management/data/datasources/remote/supabase_manager.dart';
import 'package:password_management/data/models/account_model.dart';

class HomeController extends GetxController {
  List<AccountModel> accounts = <AccountModel>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  Future<void> loadData() async {
    isLoading.value = true;
    final datas = await SupabaseManager.getAll(AccountConstanst.tableName);
    accounts.assignAll(
      // Dùng assignAll để cập nhật RxList
      (datas as List).map((json) => AccountModel.fromJson(json)).toList(),
    );
    isLoading.value = false;
  }
}
