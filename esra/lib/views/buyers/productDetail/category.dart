// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:shimmer_animation/shimmer_animation.dart';

// class CategoryWidget extends StatefulWidget {
//   const CategoryWidget({super.key});

//   @override
//   State<CategoryWidget> createState() => _CategoryWidgetState();
// }

// class _CategoryWidgetState extends State<CategoryWidget> {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final List _categories = [];

//   getCategories() async {
//     QuerySnapshot querySnapshot =
//         await _firestore.collection('categories').get();
//     setState(() {
//       for (var doc in querySnapshot.docs) {
//         _categories.add({
//           'image': doc['image'],
//         });
//       }
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     getCategories();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(15.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Benzer Ürünler',
//             style: TextStyle(
//               fontSize: 24, // حجم الخط أكبر لجعل النص أكثر بروزاً
//               fontWeight: FontWeight.w700, // استخدام خط عريض
//               color: Colors.black87, // لون عصري للنص
//               letterSpacing: 1.5, // زيادة المسافة بين الحروف لإعطاء تأثير عصري
//             ),
//           ),
//           const SizedBox(height: 15), // مسافة أكبر بين العنوان والصور
//           Container(
//             height: 180, // ارتفاع أكبر للصور
//             width: double.infinity,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(20),
//               color: Colors.grey[200], // خلفية فاتحة للعناصر
//             ),
//             child: _categories.isEmpty
//                 ? const Center(child: CircularProgressIndicator())
//                 : ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: _categories.length,
//                     itemBuilder: (context, index) {
//                       final category = _categories[index];
//                       return Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                         child: Container(
//                           width: 180, // عرض مريح للصورة
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(15),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black26, // ظلال خفيفة
//                                 blurRadius: 8, // تأثير ظل أكبر لجذب الانتباه
//                                 offset: const Offset(0, 4),
//                               ),
//                             ],
//                           ),
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(15),
//                             child: CachedNetworkImage(
//                               imageUrl: category['image'],
//                               fit: BoxFit.cover,
//                               height: 160, // رفع ارتفاع الصور
//                               width: 160, // عرض الصور متناسق
//                               placeholder: (context, url) => Shimmer(
//                                 duration: const Duration(seconds: 2),
//                                 interval: const Duration(seconds: 1),
//                                 color: Colors.white,
//                                 enabled: true,
//                                 child: Container(
//                                   color: Colors
//                                       .grey[300], // لون مناسب أثناء التحميل
//                                   height: 160,
//                                   width: 160,
//                                 ),
//                               ),
//                               errorWidget: (context, url, error) =>
//                                   const Icon(Icons.error, color: Colors.red),
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//           ),
//         ],
//       ),
//     );
//   }
// }



// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:shimmer_animation/shimmer_animation.dart';

// class SimilarProductsWidget extends StatefulWidget {
//   final String currentProductId;
//   final String category;

//   const SimilarProductsWidget({
//     super.key,
//     required this.currentProductId,
//     required this.category,
//   });

//   @override
//   State<SimilarProductsWidget> createState() => _SimilarProductsWidgetState();
// }

// class _SimilarProductsWidgetState extends State<SimilarProductsWidget> {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final List _similarProducts = [];

//   getSimilarProducts() async {
//     // استعلام للحصول على المنتجات من نفس الفئة
//     QuerySnapshot querySnapshot = await _firestore
//         .collection('products')
//         .where('category', isEqualTo: widget.category)
//         .where('productId', isNotEqualTo: widget.currentProductId) // استثناء المنتج الحالي
//         .limit(10) // تحديد عدد المنتجات المشابهة
//         .get();

//     if (mounted) {
//       setState(() {
//         _similarProducts.clear(); // مسح القائمة القديمة
//         for (var doc in querySnapshot.docs) {
//           _similarProducts.add({
//             'image': doc['imageUrl'],
//             'name': doc['productName'],
//             'price': doc['productPrice'],
//             'productId': doc['productId'],
//           });
//         }
//       });
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     getSimilarProducts();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(15.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'منتجات مشابهة',
//             style: TextStyle(
//               fontSize: 24,
//               fontWeight: FontWeight.w700,
//               color: Colors.black87,
//               letterSpacing: 1.5,
//             ),
//           ),
//           const SizedBox(height: 15),
//           Container(
//             height: 240, // زيادة الارتفاع ليشمل اسم المنتج والسعر
//             width: double.infinity,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(20),
//               color: Colors.grey[200],
//             ),
//             child: _similarProducts.isEmpty
//                 ? const Center(child: CircularProgressIndicator())
//                 : ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: _similarProducts.length,
//                     itemBuilder: (context, index) {
//                       final product = _similarProducts[index];
//                       return Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                         child: GestureDetector(
//                           onTap: () {
//                             // يمكنك إضافة التنقل إلى صفحة المنتج هنا
//                             // Navigator.push(...);
//                           },
//                           child: Container(
//                             width: 180,
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Container(
//                                   height: 180,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(15),
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: Colors.black26,
//                                         blurRadius: 8,
//                                         offset: const Offset(0, 4),
//                                       ),
//                                     ],
//                                   ),
//                                   child: ClipRRect(
//                                     borderRadius: BorderRadius.circular(15),
//                                     child: CachedNetworkImage(
//                                       imageUrl: product['image'],
//                                       fit: BoxFit.cover,
//                                       placeholder: (context, url) => Shimmer(
//                                         duration: const Duration(seconds: 2),
//                                         interval: const Duration(seconds: 1),
//                                         color: Colors.white,
//                                         enabled: true,
//                                         child: Container(
//                                           color: Colors.grey[300],
//                                         ),
//                                       ),
//                                       errorWidget: (context, url, error) =>
//                                           const Icon(Icons.error, color: Colors.red),
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(height: 8),
//                                 Text(
//                                   product['name'],
//                                   style: const TextStyle(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                   maxLines: 1,
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                                 Text(
//                                   '${product['price']} TL',
//                                   style: const TextStyle(
//                                     fontSize: 14,
//                                     color: Colors.black87,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//           ),
//         ],
//       ),
//     );
//   }
// }


