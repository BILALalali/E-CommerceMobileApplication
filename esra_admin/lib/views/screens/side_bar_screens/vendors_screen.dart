import 'package:esra_admin/views/screens/side_bar_screens/widgets/vendor_widget.dart';
import 'package:flutter/material.dart';

class VendorsScreen extends StatelessWidget {
  static const String routeName = '\VendorsScreen';

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
                        color: Colors.white, fontWeight: FontWeight.bold)))));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: [
      Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: const Text('Manage Vendors',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 36))),
      Row(children: [
        _rowHeader('LOGO', 1),
        _rowHeader('BUSSINESS NAME', 3),
        _rowHeader('CITY', 2),
        _rowHeader('STATE', 2),
        _rowHeader('ACTION', 1),
        _rowHeader('VIEW MORE', 3),
      ]),
      VendorWidget(),
    ]));
  }
}



/* شرح الكود:
1. الأسطر 1-2: استيراد الحزمة الضرورية `flutter/material.dart`.
2. الأسطر 4-6: تعريف `VendorsScreen` كـ `StatelessWidget` مع تحديد المسار الثابت `routeName`.
3. الأسطر 8-20: تعريف دالة مساعدة `_rowHeader` التي تنشئ صفوف رأسية قابلة للتخصيص باستخدام `Expanded` مع `flex` لتوزيع المساحة.
4. الأسطر 22-38: داخل دالة `build` يتم عرض واجهة المستخدم باستخدام `SingleChildScrollView` للسماح بالتمرير، حيث يتم وضع عنوان "Manage Vendors" في الأعلى.
5. الأسطر 29-34: يتم استخدام `Row` لعرض رؤوس الأعمدة مثل "LOGO"، "BUSINESS NAME"، "CITY"، وغيرها باستخدام دالة `_rowHeader`.
6. الأسطر 36-38: يتم ترتيب الأعمدة في صف واحد باستخدام `Row` وتخصيص حجم كل عمود باستخدام `flex` لتوزيع المساحة المتاحة بشكل متوازن بين الأعمدة.
*/