class StringHelper {
  static bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(r'^(\s*|[\w-\.]+@([\w-]+\.)+[\w-]{2,4})$');
    return emailRegex.hasMatch(email);
  }
}
