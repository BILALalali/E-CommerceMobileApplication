import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esra/views/buyers/nav_screen/widgets/home_products.dart';
import 'package:esra/views/buyers/nav_screen/widgets/mian_products_widget.dart';
import 'package:flutter/material.dart';

class CategoryText extends StatefulWidget {
  @override
  State<CategoryText> createState() => _CategoryTextState();
}

class _CategoryTextState extends State<CategoryText> {
  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> categoryStream =
        FirebaseFirestore.instance.collection('categories').snapshots();

    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 15.0, horizontal: 20.0), // تعديل المسافات
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Kategoriler', // تم الترجمة إلى التركية
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple.shade800, // تغيير اللون
              letterSpacing: 1.2, // إضافة تباعد بين الحروف
            ),
          ),
          const SizedBox(height: 10), // إضافة مسافة بين العنوان والقائمة
          StreamBuilder<QuerySnapshot>(
            stream: categoryStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text(
                    'Bir şeyler yanlış gitti', // ترجمة الخطأ إلى التركية
                    style: TextStyle(
                      color: Colors.red.shade700,
                      fontSize: 18,
                    ));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Kategoriler Yükleniyor...", // ترجمة تحميل البيانات
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey.shade700,
                    ),
                  ),
                );
              }

              return Container(
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final categoryData = snapshot.data!.docs[index];
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: ActionChip(
                              backgroundColor: selectedCategory ==
                                      categoryData['categoryName']
                                  ? Colors.deepPurple.shade600
                                  : Colors.deepPurple.shade300,
                              onPressed: () {
                                setState(() {
                                  selectedCategory =
                                      categoryData['categoryName'];
                                });
                                print(selectedCategory);
                              },
                              label: Text(
                                categoryData['categoryName'],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18, // حجم النص مناسب
                                  fontWeight: FontWeight.w600, // وزن الخط
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.deepPurple.shade800, // تغيير اللون
                        size: 20,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 0), // مسافة قبل عرض المنتجات
          if (selectedCategory == null)
            MianProductsWidget()
          else
            HomeproductWidget(categoryName: selectedCategory!),
        ],
      ),
    );
  }
}

////////////////_______________________________-
