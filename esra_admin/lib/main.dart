import 'dart:io';

import 'package:esra_admin/views/screens/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // التأكد من تهيئة الـ Flutter قبل بدء التطبيق

  // تهيئة Firebase باستخدام الخيارات المناسبة بناءً على النظام الأساسي
  await Firebase.initializeApp(
      options: kIsWeb || Platform.isAndroid // استخدام الخيارات المناسبة للنظام
          ? FirebaseOptions(
              apiKey: "AIzaSyBHe_rf-XBkzjfYRdER6veeOBlS0WcDojQ", // مفتاح API
              appId:
                  "1:819308907949:web:ed5e5d10c3badf751fe524", // معرف التطبيق
              messagingSenderId: "819308907949", // معرف مرسل الرسائل
              projectId: "esra-aacb1", // معرف المشروع
              storageBucket:
                  "esra-aacb1.firebasestorage.app", // مكان تخزين البيانات
            )
          : null); // إذا لم يكن النظام هو الويب أو أندرويد، لا نستخدم Firebase
  runApp(const MyApp()); // تشغيل التطبيق
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo', // عنوان التطبيق
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple), // تحديد ألوان التطبيق
        useMaterial3: true, // استخدام واجهة مادة 3
      ),
      home: MainScreen(), // الشاشة الرئيسية التي سيتم عرضها عند تشغيل التطبيق
      builder: EasyLoading.init(), // تهيئة شاشة التحميل السهل
    );
  }
}

// شرح الكود:
// الأسطر 1-3: استيراد الحزم الضرورية للتطبيق مثل `firebase_core` و `flutter_easyloading`.
// الأسطر 5-14: تهيئة Firebase باستخدام الخيارات المناسبة بناءً على النظام الأساسي (ويب أو أندرويد).
// الأسطر 16-20: إنشاء تطبيق Flutter باستخدام `MaterialApp` مع تخصيص السمات وشاشة البداية.
// الأسطر 22-29: تعريف شاشة `MyApp` الرئيسية التي تحتوي على تكوين التطبيق وتخصيصه.
