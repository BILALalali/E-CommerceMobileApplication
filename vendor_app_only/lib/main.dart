import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:vendor_app_only/vendor/views/auth/vendor_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyBNyFv_FwhCngdvxdH8GiRSKLi501c_3SY",
        appId: "1:819308907949:android:6cb53dcef231cf641fe524",
        messagingSenderId: "819308907949",
        projectId: "esra-aacb1",
        storageBucket: "gs://esra-aacb1.firebasestorage.app",
      ),
    );
  } else {
    await Firebase.initializeApp(); // لنظام iOS أو غيره
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const VendorAuthScreen(),
      builder: EasyLoading.init(),
    );
  }
}
