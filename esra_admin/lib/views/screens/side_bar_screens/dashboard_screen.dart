import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  static const String routeName = '\DashboardScreen';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.all(10),
        child: const Text(
          'Dashboard',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 36,
          ),
        ),
      ),
    );
  }
}




// شرح الكود:
// - السطر 1: استيراد مكتبة `flutter/material.dart` لاستخدام عناصر واجهة المستخدم في Flutter.
// - السطر 3-5: تعريف `DashboardScreen` كـ StatelessWidget، مع تعريف `routeName` كاسم مسار للتنقل.
// - الأسطر 8-19: دالة `build` تنشئ `SingleChildScrollView` يحتوي على `Container`،
//   بحيث يحتوي على نص "Dashboard" بمحاذاة أعلى اليسار، وبأسلوب تصميم يجعل النص بخط ثقيل وحجم 36.