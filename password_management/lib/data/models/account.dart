class Account {
  String id = '';
  String userName = '';
  String password = '';
  String note = '';

  Account({
    required this.id,
    required this.userName,
    required this.password,
    required this.note,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: json['id'],
      userName: json['userName'],
      password: json['password'],
      note: json['note'],
    );
  }
}

class AddAccount {
  String userName = '';
  String password = '';
  String note = '';

  AddAccount({
    required this.userName,
    required this.password,
    required this.note,
  });

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'password': password,
      'note': note,
    };
  }
}

