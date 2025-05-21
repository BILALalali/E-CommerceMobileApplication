import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BannerWidgets extends StatelessWidget {
  const BannerWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _bannersStream =
        FirebaseFirestore.instance.collection('banners').snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: _bannersStream,
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
          itemBuilder: (context, Index) {
            final BannerData = snapshot.data!.docs[Index];
            return Column(
              children: [
                SizedBox(
                  height: 99,
                  width: 99,
                  child: Image.network(
                    BannerData['image'],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}




// شرح الكود:
// الأسطر 1-2: استيراد الحزم الضرورية مثل `cloud_firestore` و `flutter/material.dart`.
// الأسطر 4-7: تعريف الفئة `BannerWidgets` التي هي عبارة عن ويدجت من نوع `StatelessWidget` لعرض لافتات.
// الأسطر 9-11: تعريف stream من بيانات لافتات `banners` من قاعدة بيانات Firestore.
// الأسطر 13-23: استخدام `StreamBuilder` لربط واجهة المستخدم بـ stream الخاص بـ `banners` وعرض العناصر في الوقت الفعلي.
// الأسطر 15-16: في حال وجود خطأ في تحميل البيانات، يتم عرض رسالة خطأ.
// الأسطر 18-21: في حال كان الاتصال بقاعدة البيانات في حالة انتظار، يتم عرض دائرة تحميل.
// الأسطر 23-30: عند استلام البيانات، يتم عرض شبكة من العناصر باستخدام `GridView.builder` لعرض صورة كل لافتة.
// الأسطر 25-28: لكل لافتة يتم إنشاء عمود يحتوي على صورة لافتة.
// الأسطر 30: إغلاق الدالة `build` و إتمام واجهة المستخدم.