import 'package:flutter/material.dart';
import 'package:password_management/dtos/add_account.dto.dart';
import 'package:password_management/services/firebase_database.service.dart';
import 'package:password_management/utils/alert.dart';
import 'package:password_management/utils/loading.dart';

class AddAccount extends StatelessWidget {
  const AddAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Add Account',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_rounded,
                color: Colors.white), 
            onPressed: () {
              Navigator.pop(context); 
            },
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
        body: FormScreen());
  }
}

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _appNameController = TextEditingController(text: '');
  final _userNameController = TextEditingController(text: '');
  final _passwordController = TextEditingController(text: '');
  final _confirmPasswordController = TextEditingController(text: '');
  final _noteController = TextEditingController(text: '');

  bool _isLoading = false;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void dispose() {
    _appNameController.dispose();
    _userNameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> onSubmit() async {
    if (_formKey.currentState!.validate() == false) {
      return;
    }

    AddAccountDto model = AddAccountDto(
        appName: _appNameController.value.text,
        userName: _userNameController.value.text,
        password: _passwordController.value.text,
        note: _noteController.value.text);

    setState(() {
      _isLoading = true;
    });
    bool check = await FirebaseDatabaseService.addData(model);

    setState(() {
      _isLoading = false;
    });

    if (check == true) {
      if (mounted) {
        Navigator.pop(context);
      }
    } else {
      if (mounted) {
        showErrorDialog(
            context, 'Notification', 'Try again.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _appNameController,
                      decoration: const InputDecoration(
                        labelText: 'App Name',
                        hintText: 'Enter your app name',
                        prefixIcon: Icon(Icons.apps_outlined),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'App Name cannot be empty';
                        }
                        return null;
                      },
                    ),
                    _gap(),
                    TextFormField(
                      controller: _userNameController,
                      decoration: const InputDecoration(
                        labelText: 'User Name',
                        hintText: 'Enter your user name',
                        prefixIcon: Icon(Icons.person_outlined),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'User Name cannot be empty';
                        }
                        return null;
                      },
                    ),
                    _gap(),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter your password',
                        prefixIcon: Icon(Icons.lock_outlined),
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                      obscureText: !_isPasswordVisible,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password cannot be empty';
                        }
                        return null;
                      },
                    ),
                    _gap(),
                    TextFormField(
                      controller: _confirmPasswordController,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        hintText: 'Enter your confirm password',
                        prefixIcon: Icon(Icons.lock_outlined),
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isConfirmPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                            });
                          },
                        ),
                      ),
                      obscureText: !_isConfirmPasswordVisible,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Confirm Password cannot be empty';
                        }
                        if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    _gap(),
                    TextFormField(
                      controller: _noteController,
                      decoration: const InputDecoration(
                          labelText: 'Note',
                          hintText: 'Enter your note',
                          prefixIcon: Icon(
                            Icons.note_alt_outlined,
                          ),
                          border: OutlineInputBorder(),
                          alignLabelWithHint: true),
                      maxLines: 6,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: onSubmit,
                      child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            'Add',
                            textAlign: TextAlign.center,
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ),
          LoadingWidget(isLoading: _isLoading),
        ],
      ),
    );
  }

  Widget _gap() => const SizedBox(height: 16);
}
