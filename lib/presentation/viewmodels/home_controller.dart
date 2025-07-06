import 'package:get/get.dart';
import 'package:password_management/data/helpers/secure_storage_helper.dart';
import 'package:password_management/data/helpers/account_helper.dart';
import 'package:password_management/data/helpers/passcode_helper.dart';
import 'package:password_management/data/models/account_model.dart';
import 'package:password_management/data/supabase/account_repo.dart';

class HomeController extends GetxController {
  List<AccountModel> originalAccounts = [];
  var accounts = <AccountModel>[].obs;
  final isLoading = false.obs;
  late AccountRepo accountRepo;

  @override
  void onInit() {
    super.onInit();
    accountRepo = AccountRepo();
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
    var key = await SecureStorageHelper.getValue(PasscodeHelper.passCodeKey);
    if (key == null) {
      return;
    }
    isLoading.value = true;
    final datas = await accountRepo.findManyByQuery({});

    accounts.assignAll(
      // Dùng assignAll để cập nhật RxList
      (datas as List).map((json) {
        AccountModel accountModel = AccountModel(
          id: json[AccountHelper.idCol],
          appName: json[AccountHelper.appNameCol],
          note: json[AccountHelper.noteCol],
          password: json[AccountHelper.passwordCol],
          userId: json[AccountHelper.userId],
          userName: json[AccountHelper.userNameCol],
        );
        accountModel.decrypt(key);
        return accountModel;
      }).toList(),
    );
    isLoading.value = false;
    originalAccounts = accounts.toList();
  }

  void addElement(AccountModel element) {
    accounts.add(element);
    originalAccounts = accounts.toList();
    accounts.refresh();
  }

  void updateElement(String id, dynamic data) {
    final account = accounts.firstWhere((u) => u.id == id);
    account.appName = data[AccountHelper.appNameCol] ?? '';
    account.userName = data[AccountHelper.userNameCol] ?? '';
    account.password = data[AccountHelper.passwordCol] ?? '';
    account.note = data[AccountHelper.noteCol] ?? '';
    originalAccounts = accounts.toList();

    accounts.refresh();
  }

  Future<bool> deleteElement(String id) async {
    final check = await accountRepo.delete(id);
    if (check == false) {
      return check;
    }
    final account = accounts.firstWhere((u) => u.id == id);
    accounts.remove(account);
    originalAccounts = accounts.toList();
    accounts.refresh();
    return true;
  }

  void onSearchChange(String value) {
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

  Future<void> reEncrypt(String key) async {
    for (var ac in originalAccounts) {
      ac.encrypt(key);
    }

    await accountRepo.batchUpdate(
      originalAccounts.map((e) => e.toJson()).toList(),
    );
  }
}
