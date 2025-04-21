import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:password_management/home.dart';
import 'package:password_management/utils/alert.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => AuthState();
}

class AuthState extends State<Auth> {
  final LocalAuthentication _localAuth = LocalAuthentication();
  String _message = "";

  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool _isPasswordSet = false;

  bool isShowPassword = false;
  bool isShowConfirmPassword = false;

  @override
  void initState() {
    super.initState();
    _checkIfPasswordIsSet();
  }

  // Kiểm tra các phương thức xác thực sinh trắc học có sẵn
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

  Future<bool> _authenticateWithBiometrics() async {
    try {
      bool isCheckBiometrics = await _checkBiometrics();

      if (isCheckBiometrics == false) {
        if (mounted) {
          showErrorDialog(
              context, 'Notification', 'Your device doesn\'t support.');
        }
        return false;
      }

      bool isAuthenticated = await _localAuth.authenticate(
        localizedReason: 'Authentication.',
        options: AuthenticationOptions(
          biometricOnly: true, // Chỉ sử dụng sinh trắc học
        ),
      );

      return isAuthenticated;
    } catch (e) {
      return false;
    }
  }

// Kiểm tra xem mật khẩu đã được lưu chưa
  Future<void> _checkIfPasswordIsSet() async {
    String? password = await _secureStorage.read(key: 'password');
    setState(() {
      _isPasswordSet = password != null && password.isNotEmpty;
      _message = password != null ? "Login" : "Set your password";
    });
  }

  // Lưu mật khẩu vào storage
  Future<void> _savePassword() async {
    if (passwordController.text != confirmPasswordController.text) {
      showErrorDialog(
          context, 'Notification', 'Confirm password is incorrect.');
      return;
    }

    bool isCheckBiometrics = await _checkBiometrics();
    if (isCheckBiometrics == false) {
      await _secureStorage.write(
          key: 'password', value: passwordController.text);
      setState(() {
        passwordController.text = '';
        confirmPasswordController.text = '';
        _isPasswordSet = true;
      });
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
        _isPasswordSet = true;
      });
    } else {
      // thông báo lỗi
    }
  }

  // Đăng nhập bằng mật khẩu
  Future<void> _checkPassword() async {
    String? storedPassword = await _secureStorage.read(key: 'password');

    if (storedPassword != passwordController.text) {
      if (mounted) {
        showErrorDialog(context, 'Notification', 'Password is incorrect.');
      }
      return;
    }

    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    }
  }

// Dăng nhập bằng vân tay
  Future<void> _loginWithBiometrics() async {
    try {
      bool check = await _authenticateWithBiometrics();

      if (check == false) {
        return;
      }
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      }
    } catch (e) {
      if (mounted) {
        showErrorDialog(context, 'Error', '$e');
      }
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
                _message,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.indigo,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            _isPasswordSet
                ? Column(
                    children: [
                      TextFormField(
                          controller: passwordController,
                          decoration: InputDecoration(
                              labelText: 'Input password',
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
                          obscureText: !isShowPassword),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: _checkPassword,
                        child: Text('Login'),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      TextField(
                        controller: passwordController,
                        decoration: InputDecoration(
                            labelText: 'Input password',
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
                            labelText: 'Confirm password',
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
                                  isShowConfirmPassword =
                                      !isShowConfirmPassword;
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
            SizedBox(height: 20),
            Container(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: _loginWithBiometrics,
                child: Text('Login with BIOMETRIC'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
