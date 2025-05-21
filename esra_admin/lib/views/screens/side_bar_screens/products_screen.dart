import 'package:flutter/material.dart';
import 'package:esra_admin/views/screens/side_bar_screens/widgets/product_widget.dart';

class ProductsScreen extends StatelessWidget {
  static const String routeName = '\ProductsScreen';
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
                'Products',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 36,
                ),
              )
          ),
          Row(
            children: [
              _rowHeader('IMAGE', 1),
              _rowHeader('NAME', 3),
              _rowHeader('PRICE', 2),
              _rowHeader('QUANTITY', 2),
              _rowHeader('ACTION', 1),
              _rowHeader('VIEW MORE', 1),
            ],
          ),
          const ProductWidget(),
        ],
      ),
    );
  }
}

// شرح الكود:
// الأسطر 1-2: استيراد الحزمة الضرورية `flutter/material.dart`.
// الأسطر 4-10: تعريف دالة مساعدة `_rowHeader` التي تنشئ رؤوس الأعمدة مع تنسيق اللون والخطوط باستخدام الـ `flex` لتوزيع المساحة.
// الأسطر 12-35: في دالة `build`، يتم عرض واجهة المستخدم باستخدام `SingleChildScrollView` للسماح بالتمرير العمودي.
// الأسطر 18-33: يتم ترتيب الأعمدة في صف واحد باستخدام `Row`، مع تخصيص حجم كل عمود باستخدام `flex` لتوزيع المساحة بشكل متوازن.
// الأسطر 26-30: يتم تحديد النصوص في كل رأس عمود مثل "IMAGE"، "NAME"، "PRICE"، "QUANTITY"، "ACTION"، و "VIEW MORE" باستخدام دالة `_rowHeader`.
