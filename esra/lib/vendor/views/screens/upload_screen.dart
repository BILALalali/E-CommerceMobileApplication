

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esra/provider/product_provider.dart';
import 'package:esra/vendor/views/screens/Upload_tap_screens/attribuutes_tab_screen.dart';
import 'package:esra/vendor/views/screens/Upload_tap_screens/general_screen.dart';
import 'package:esra/vendor/views/screens/Upload_tap_screens/images_tab_screen.dart';
import 'package:esra/vendor/views/screens/Upload_tap_screens/shipping_screen.dart';
import 'package:esra/vendor/views/screens/main_vendor_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class UploadScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final ProductProvider productProvider =
        Provider.of<ProductProvider>(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 44,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Ürün Yükleme',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFBB86FC), // لون ناعم ومريح
                      Color.fromARGB(
                          255, 115, 82, 162), // تدرج لوني أرجواني داكن
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
            elevation: 0,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      // Wrap TabBar and TabBarView with DefaultTabController
                      DefaultTabController(
                        length: 4, // Number of tabs
                        child: Column(
                          children: [
                            TabBar(
                              indicatorColor: Colors.purple,
                              tabs: const [
                                Tab(text: 'Genel Bilgi'),
                                Tab(text: 'Kargo'),
                                Tab(text: 'Özellikler'),
                                Tab(text: 'Görseller'),
                              ],
                            ),
                            Container(
                              height:
                                  999, // You can adjust this height as needed
                              child: TabBarView(
                                children: [
                                  GeneralScreen(),
                                  ShippingScreen(),
                                  AttribuutesTabScreen(),
                                  ImagesTabScreen(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(22),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple, // Corrected parameter name
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(44), // حواف دائرية عصرية
            ),
            padding: const EdgeInsets.symmetric(vertical: 11),
            textStyle:
                const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          onPressed: () async {
            EasyLoading.show(status: 'Please Wait...');
            if (formKey.currentState!.validate()) {
              final productId = Uuid().v4();
              await firestore.collection('products').doc(productId).set({
                'productId': productId,
                'productName': productProvider.productData['productName'],
                'productPrice': productProvider.productData['productPrice'],
                'quantity': productProvider.productData['quantity'],
                'category': productProvider.productData['category'],
                'description': productProvider.productData['description'],
                'imageUrl': productProvider.productData['imageUrlList'],
                'scheduleDate': productProvider.productData['scheduleDate'],
                'chargeShipping': productProvider.productData['chargeShipping'],
                'shippingCharge': productProvider.productData['shippingCharge'],
                'brandName': productProvider.productData['brandName'],
                'sizeList': productProvider.productData['sizeList'],
                'approved': false,
              }).whenComplete(() {
                productProvider.clearData();
                formKey.currentState!.reset();
                EasyLoading.dismiss();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MainVendorScreen()));
              });
            }
          },
          child: const Text(
            'Kaydet',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
