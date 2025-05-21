import 'package:flutter/material.dart'; // استيراد مكتبة Flutter لواجهة المستخدم

// تعريف دالة لعرض Snackbar مع رسالة
showSnak(context, String title) {
  ScaffoldMessenger.of(context).showSnackBar(
    // استخدام ScaffoldMessenger لعرض Snackbar
    SnackBar(
      backgroundColor: Colors.purple.shade500, // تعيين اللون الخلفي لـ SnackBar
      content: Text(
        title, // محتوى SnackBar هو النص الذي يتم تمريره كـ title
        style: TextStyle(
          fontWeight: FontWeight.bold, // تعيين الخط ليكون عريضًا
        ),
      ),
    ),
  );
}



// التعليقات:
// 1-8: **تعريف دالة `showSnak`**: تقوم الدالة بعرض Snackbar في واجهة المستخدم.
//    - **الأسطر 1-2**: استيراد مكتبة `flutter/material.dart` التي تحتوي على العناصر الأساسية لبناء واجهات المستخدم.
//    - **الأسطر 4-8**: تستخدم `ScaffoldMessenger.of(context).showSnackBar` لعرض رسالة على شكل Snackbar.
//      - **الأسطر 6-7**: تخصيص اللون الخلفي لـ Snackbar ليكون باللون البنفسجي (purple).
//      - **الأسطر 8-9**: تنسيق النص داخل الـ Snackbar ليكون بالخط العريض (bold).
