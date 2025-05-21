

import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BannerWidget extends StatefulWidget {
  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final List _bannerImage = [];

  // جلب البيانات من Firestore
  getBanners() {
    return _firestore
        .collection('banners')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          _bannerImage.add(doc['image']);
        });
      });
    });
  }

  @override
  void initState() {
    getBanners();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        height: 149, // زيادة ارتفاع الصورة لجعلها بارزة أكثر
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.blueGrey.shade50, // تغيير اللون إلى ألوان محايدة
          borderRadius: BorderRadius.circular(15), // جعل الحواف أكثر نعومة
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 4),
              blurRadius: 6,
            ),
          ], // إضافة تأثير الظل لتوفير عمق
        ),
        child: _bannerImage.isEmpty
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: [
                  PageView.builder(
                    itemCount: _bannerImage.length,
                    itemBuilder: (context, index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: CachedNetworkImage(
                          imageUrl: _bannerImage[index],
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.white,
                            child: Container(
                              color: Colors.grey.shade300,
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error, color: Colors.red),
                        ),
                      );
                    },
                  ),
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: Row(
                      children: [
                        Icon(
                          Icons.circle,
                          size: 10,
                          color: Color.fromRGBO(255, 255, 255,
                              0.7), // تعديل لاستخدام Color.fromRGBO
                        ),
                        Icon(
                          Icons.circle,
                          size: 10,
                          color: Color.fromRGBO(255, 255, 255,
                              0.7), // تعديل لاستخدام Color.fromRGBO
                        ),
                        Icon(
                          Icons.circle,
                          size: 10,
                          color: Color.fromRGBO(255, 255, 255,
                              0.7), // تعديل لاستخدام Color.fromRGBO
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
