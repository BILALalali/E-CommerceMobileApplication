import 'package:esra/controllers/auth_controller.dart';
import 'package:esra/untils/show_snackBar.dart';
import 'package:esra/views/buyers/main_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthController _authController = AuthController();

  // متغيرAuthController  لتخذين فئه وحده التحكم الفرديه لتسحيل الدخول للمستخدم

  late String email;

  late String password;

  bool _isLoading = false;

  _loginUsers() async {
    setState(() {
      _isLoading = true;
    });
    if (_formKey.currentState!.validate()) {
      await _authController.loginUsers(email, password);
      return Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return MainScreen();
      }));
    } else {
      setState(() {
        _isLoading = false;
      });
      return showSnak(context, 'Please feidls most not be empty');
    }
  }

  //     if (res == ' User registered successfully  ') {
  //       return Navigator.pushReplacement(context,
  //           MaterialPageRoute(builder: (BuildContext context) {
  //         return MainScreen();
  //       }));
  //     } else {
  //       return showSnak(context, res);
  //     }

  //     // return showSnak(context, 'You Are Now Logged In');
  //   } else {
  //     return showSnak(context, 'Please feidls most not be empty');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'Login customer\'s Account', // تعديل علامات الاقتباس
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: TextFormField(
                // obscureText: true, // هذا الاعداد لاخفاء البريد  عند الكتابه
                validator: (value) {
                  if (value!.isEmpty) {
                    email = value;
                    return ' please Email feild most not be empty';
                  } else {
                    return null;
                  }
                },
                onChanged: ((value) {
                  email = value;
                }),
                decoration: InputDecoration(
                  labelText: 'Enter Email Address',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: TextFormField(
                obscureText: true, // هذا الاعداد لاخفاء كلمه المرور عند الكتابه

                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Password most not be empty';
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  password = value;
                },
                decoration: InputDecoration(
                  labelText: 'Enter Password',
                ),
              ),
            ),
            SizedBox(
              height: 21,
            ),
            // نضيف زر تسحيل الدخول onTap
            InkWell(
              onTap: () {
                _loginUsers();
              },
              child: Container(
                width: MediaQuery.of(context).size.width - 40,
                height: 49,
                decoration: BoxDecoration(
                  color: Colors.purple.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: _isLoading
                      ? CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text(
                          'Login',
                          style: TextStyle(
                            letterSpacing: 5,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Need An Account?'),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Register',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

