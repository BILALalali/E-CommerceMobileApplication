import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  static const String routeName = '\OrdersScreen';
  Widget _rowHeader(String text, int flex) {
    return Expanded(
        flex: flex,
        child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade700),
              color: Colors.purple.shade200,
            ),
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(text,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    )))));
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: const Text(
            'Orders',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 36),
          ),
        ),
        Row(
          children: [
            _rowHeader('Image', 2),
            _rowHeader('Full Name ', 3),
            _rowHeader('CITY', 2),
            _rowHeader('STATE', 2),
            _rowHeader('ACTION', 1),
            _rowHeader('VIEW MORE', 1),
          ],
        )
      ],
    ));
  }
}



// شرح الكود:
// - الأسطر 1-2: استيراد الحزمة `flutter/material.dart` لاستخدام مكونات واجهة Flutter.
// - الأسطر 4-6: تعريف اسم مسار الشاشة للاستخدام مع نظام التنقل.
// - الأسطر 8-16: دالة `_rowHeader` تنشئ وتنسق رأس كل عمود في الجدول حسب النص وحجم `flex`.
// - الأسطر 19-36: في `build` يتم استخدام `SingleChildScrollView` مع `Column` للسماح بالتمرير وعرض الشاشة عمودياً.
// - الأسطر 23-26: إضافة عنوان للشاشة لعرض النص "Orders" كعنوان رئيسي.
// - الأسطر 28-34: إنشاء صف من الأعمدة باستخدام دالة `_rowHeader` لتحديد الأعمدة ومرونتها.