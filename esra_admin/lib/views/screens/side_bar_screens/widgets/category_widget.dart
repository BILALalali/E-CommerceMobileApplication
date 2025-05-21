// شرح الكود:
// الأسطر 1-2: استيراد الحزم الضرورية مثل `cloud_firestore` و `flutter/material.dart`.
// الأسطر 4-7: تعريف الفئة `CategoryWidget` التي هي عبارة عن ويدجت من نوع `StatelessWidget` لعرض قائمة بالفئات.
// الأسطر 9-11: تعريف stream من بيانات فئة `categories` من قاعدة بيانات Firestore.
// الأسطر 13-23: استخدام `StreamBuilder` لربط واجهة المستخدم بـ stream الخاص بـ `categories` وعرض العناصر في الوقت الفعلي.
// الأسطر 15-16: في حال وجود خطأ في تحميل البيانات، يتم عرض رسالة خطأ.
// الأسطر 18-21: في حال كان الاتصال بقاعدة البيانات في حالة انتظار، يتم عرض دائرة تحميل.
// الأسطر 23-30: عند استلام البيانات، يتم عرض شبكة من العناصر باستخدام `GridView.builder` لعرض صورة واسم الفئة.
// الأسطر 25-28: لكل فئة يتم إنشاء عمود يحتوي على صورة واسم الفئة.
// الأسطر 30: إغلاق الدالة `build` و إتمام واجهة المستخدم.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _categoriesStream =
        FirebaseFirestore.instance.collection('categories').snapshots();
    return StreamBuilder<QuerySnapshot>(
        stream: _categoriesStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: Colors.cyan),
            );
          }
          return GridView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.size,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7, mainAxisSpacing: 9, crossAxisSpacing: 8),
              itemBuilder: (context, index) {
                final categoryData = snapshot.data!.docs[index];
                return Column(children: [
                  SizedBox(
                    height: 99,
                    width: 99,
                    child: Image.network(
                      categoryData['image'],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.broken_image,
                          size: 99,
                          color: Colors.red,
                        );
                      },
                    ),
                  ),
                  Text(
                    categoryData['categoryName'],
                  )
                ]);
              });
        });
  }
}
