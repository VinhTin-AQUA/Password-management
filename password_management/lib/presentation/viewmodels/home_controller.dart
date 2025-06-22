import 'package:get/get.dart';
import 'package:password_management/core/constants/account_constanst.dart';
import 'package:password_management/data/datasources/remote/supabase_manager.dart';
import 'package:password_management/data/models/account_model.dart';

class HomeController extends GetxController {
  var accounts = <AccountModel>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  // @override
  // void onReady() {
  //   super.onReady();
  //   print(123);
  //   loadData(); // chạy lại mỗi khi quay lại màn hình này
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  Future<void> loadData() async {
    isLoading.value = true;
    final datas = await SupabaseManager.getAll(AccountConstanst.tableName, [
      AccountConstanst.appNameCol,
      AccountConstanst.idCol,
    ]);
    accounts.assignAll(
      // Dùng assignAll để cập nhật RxList
      (datas as List).map((json) => AccountModel.fromJson(json)).toList(),
    );
    isLoading.value = false;
  }

  void addElement(AccountModel element) {
    accounts.add(element);
    accounts.refresh();
  }

  void updateElement(String id, dynamic data) {
    final account = accounts.firstWhere((u) => u.id == id);
    account.appName = data[AccountConstanst.appNameCol] ?? '';
    account.userName = data[AccountConstanst.userNameCol] ?? '';
    account.password = data[AccountConstanst.passwordCol] ?? '';
    account.note = data[AccountConstanst.noteCol] ?? '';
    accounts.refresh();
  }
}
