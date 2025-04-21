import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:password_management/utils/alert.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => ChangePasswordState();
}

class ChangePasswordState extends State<ChangePassword> {
  final LocalAuthentication _localAuth = LocalAuthentication();

  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool isShowPassword = false;
  bool isShowConfirmPassword = false;

  @override
  void initState() {
    super.initState();
  }

  Future<bool> _checkBiometrics() async {
    try {
      bool canAuthenticate = await _localAuth.canCheckBiometrics;
      if (canAuthenticate) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
  
  Future<void> _savePassword() async {
    if (passwordController.text != confirmPasswordController.text) {
      showErrorDialog(
          context, 'Notification', 'Confirm password is incorrect');
      return;
    }

    bool isCheckBiometrics = await _checkBiometrics();
    if (isCheckBiometrics == false) {
      await _secureStorage.write(
          key: 'password', value: passwordController.text);
      setState(() {
        passwordController.text = '';
        confirmPasswordController.text = '';
      });

      if (mounted) {
        showSuccessDialog(context, 'Notification', 'Successfully');
      }
      return;
    }

    bool isAuthenticated = await _localAuth.authenticate(
      localizedReason: 'Authentication.',
      options: AuthenticationOptions(
        biometricOnly: true, // Chỉ sử dụng sinh trắc học
      ),
    );

    if (isAuthenticated) {
      await _secureStorage.write(
          key: 'password', value: passwordController.text);
      setState(() {
        passwordController.text = '';
        confirmPasswordController.text = '';
      });

      if (mounted) {
        showSuccessDialog(context, 'Notification', 'Successfully');
      }
    } else {
      //
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Password Management',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
        ),
        backgroundColor: Colors.red.shade400,
        elevation: 1, //
        flexibleSpace: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background_app_bar.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              child: Text(
                'Change Password',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.indigo,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            Column(
              children: [
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                      labelText: 'Input new password',
                      prefixIcon: Icon(
                        Icons.https_outlined,
                      ),
                      border: OutlineInputBorder(),
                      alignLabelWithHint: true,
                      suffixIcon: IconButton(
                        icon: Icon(
                          isShowPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            isShowPassword = !isShowPassword;
                          });
                        },
                      )),
                  obscureText: !isShowPassword,
                ),
                SizedBox(height: 10),
                TextField(
                  controller: confirmPasswordController,
                  decoration: InputDecoration(
                      labelText: 'Confirm new password',
                      prefixIcon: Icon(
                        Icons.https_outlined,
                      ),
                      border: OutlineInputBorder(),
                      alignLabelWithHint: true,
                      suffixIcon: IconButton(
                        icon: Icon(
                          isShowConfirmPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            isShowConfirmPassword = !isShowConfirmPassword;
                          });
                        },
                      )),
                  obscureText: !isShowConfirmPassword,
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _savePassword,
                  child: Text('Save'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
