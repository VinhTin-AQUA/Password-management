import 'package:get/get.dart';
import 'package:password_management/core/constants/account_constanst.dart';
import 'package:password_management/core/utils/aes_util.dart';
import 'package:password_management/data/datasources/remote/supabase_manager.dart';
import 'package:password_management/data/models/account_model.dart';
import 'package:password_management/presentation/viewmodels/google_controller.dart';

class HomeController extends GetxController {
  List<AccountModel> originalAccounts = [];
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

    final googleControler = Get.find<GoogleController>();
    String myKey = googleControler.googleUserInfo.uid;
    accounts.assignAll(
      // Dùng assignAll để cập nhật RxList
      (datas as List).map((json) {
        final encryptData = {
          AccountConstanst.appNameCol: AesUtil.decryptData(
            json[AccountConstanst.appNameCol],
            myKey,
          ),
          AccountConstanst.idCol: json[AccountConstanst.idCol],
        };

        print(encryptData);

        return AccountModel.fromJson(encryptData);
      }).toList(),
    );
    originalAccounts = accounts.toList();
    isLoading.value = false;
  }

  void addElement(AccountModel element) {
    accounts.add(element);
    originalAccounts = accounts.toList();
    accounts.refresh();
  }

  void updateElement(String id, dynamic data) {
    final account = accounts.firstWhere((u) => u.id == id);
    account.appName = data[AccountConstanst.appNameCol] ?? '';
    account.userName = data[AccountConstanst.userNameCol] ?? '';
    account.password = data[AccountConstanst.passwordCol] ?? '';
    account.note = data[AccountConstanst.noteCol] ?? '';
    originalAccounts = accounts.toList();

    accounts.refresh();
  }

  Future<bool> deleteElement(String id) async {
    final check = await SupabaseManager.delete(AccountConstanst.tableName, id);
    if (check == false) {
      return check;
    }
    final account = accounts.firstWhere((u) => u.id == id);
    accounts.remove(account);
    originalAccounts = accounts.toList();
    accounts.refresh();
    return true;
  }

  void onSearcChange(String value) {
    if (value == '') {
      accounts.assignAll(originalAccounts);
    } else {
      accounts.assignAll(
        originalAccounts.where(
          (account) =>
              account.appName.toLowerCase().contains(value.toLowerCase()),
        ),
      );
    }
    accounts.refresh();
  }
}
