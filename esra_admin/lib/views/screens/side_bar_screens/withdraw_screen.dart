import 'package:flutter/material.dart';

class WithdrawalScreen extends StatelessWidget {
  static const String routeName = '\WithdrawalScreen';
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
            'Withdrawal',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 36,
            ),
          ),
        ),
        Row(
          children: [
            _rowHeader('NAME', 1),
            _rowHeader('AMOUNT', 3),
            _rowHeader('BANK NAME', 2),
            _rowHeader('BANK ACCOUNT', 2),
            _rowHeader('EMAL', 1),
            _rowHeader('PHONE', 1),
          ],
        )
      ],
    ));
  }
}



// شرح الكود:
// الأسطر 1-2: استيراد الحزمة الضرورية `flutter/material.dart`.
// الأسطر 4-6: تعريف `WithdrawalScreen` كـ `StatelessWidget` مع تحديد المسار الثابت `routeName`.
// الأسطر 8-20: تعريف دالة مساعدة `_rowHeader` التي تنشئ صفوف رأسية قابلة للتخصيص باستخدام `Expanded` مع `flex` لتوزيع المساحة.
// الأسطر 22-38: داخل دالة `build` يتم عرض واجهة المستخدم باستخدام `SingleChildScrollView` للسماح بالتمرير، حيث يتم وضع عنوان "Withdrawal" في الأعلى.
// الأسطر 29-34: يتم استخدام `Row` لعرض رؤوس الأعمدة مثل "NAME"، "AMOUNT"، "BANK NAME"، وغيرها باستخدام دالة `_rowHeader`.
// الأسطر 36-38: يتم ترتيب الأعمدة في صف واحد باستخدام `Row` وتخصيص حجم كل عمود باستخدام `flex` لتوزيع المساحة المتاحة بشكل متوازن.