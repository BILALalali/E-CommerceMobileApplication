import 'package:esra/untils/show_snackBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:intl/intl.dart';
import 'package:esra/provider/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ProductDetailScreen extends StatefulWidget {
  final dynamic productData;
  const ProductDetailScreen({super.key, required this.productData});

  @override
  State<ProductDetailScreen> createState() => ProductDetailScreenState();
}

class ProductDetailScreenState extends State<ProductDetailScreen> {
  String formatedDate(date) {
    final outPutDateFormate = DateFormat('dd/MM/yyyy');
    return outPutDateFormate.format(date);
  }

  int imageIndex = 0;
  String? selectedSize;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          widget.productData['productName'],
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            letterSpacing: 3,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Image Gallery Section
            Stack(
              children: [
                Container(
                  height: 300,
                  width: double.infinity,
                  child: PhotoView(
                    imageProvider: NetworkImage(
                      widget.productData['imageUrl'][imageIndex],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.productData['imageUrl'].length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              imageIndex = index;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.purple.shade400,
                                ),
                              ),
                              height: 55,
                              width: 55,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  widget.productData['imageUrl'][index],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),

            // Price Section
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '₺ ' + widget.productData['productPrice'].toStringAsFixed(2),
                style: TextStyle(
                  fontSize: 24,
                  letterSpacing: 5,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple.shade300,
                ),
              ),
            ),

            // Product Name
            Text(
              widget.productData['productName'],
              style: TextStyle(
                fontSize: 22,
                letterSpacing: 4,
                fontWeight: FontWeight.bold,
              ),
            ),

            // Product Description
            ExpansionTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Ürün Açıklaması',
                    style: TextStyle(color: Colors.purple.shade400),
                  ),
                  Text(
                    'Daha Fazla Gör',
                    style: TextStyle(color: Colors.purple.shade300),
                  ),
                ],
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.productData['description'],
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      letterSpacing: 2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),

            // Delivery Date
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Ürün Teslimat Tarihi',
                    style: TextStyle(
                      color: Colors.purple.shade400,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    formatedDate(
                      widget.productData['scheduleDate'].toDate(),
                    ),
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4,
                    ),
                  )
                ],
              ),
            ),

            // Size Selection
            ExpansionTile(
              title: Text(
                'Mevcut Boyutlar',
              ),
              children: [
                Container(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.productData['sizeList'].length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: OutlinedButton(
                          onPressed: () {
                            setState(() {
                              selectedSize =
                                  widget.productData['sizeList'][index];
                            });
                          },
                          style: OutlinedButton.styleFrom(
                            backgroundColor: selectedSize ==
                                    widget.productData['sizeList'][index]
                                ? Colors.purple.shade100
                                : null,
                          ),
                          child: Text(
                            widget.productData['sizeList'][index],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: selectedSize ==
                                      widget.productData['sizeList'][index]
                                  ? Colors.purple.shade700
                                  : Colors.black,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),

            // Similar Products Section
            SimilarProductsSection(
              category: widget.productData['category'],
              currentProductId: widget.productData['productId'],
            ),

            // Extra space at bottom for the bottom sheet
            SizedBox(height: 80),
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(10.0),
        child: InkWell(
          onTap: () {
            final cartProvider =
                Provider.of<CartProvider>(context, listen: false);

            if (selectedSize == null) {
              return showSnak(context, 'Lütfen Bir Boyut Seçin');
            } else {
              cartProvider.addProductToCart(
                widget.productData['productName'],
                widget.productData['productId'],
                widget.productData['imageUrl'],
                1,
                widget.productData['quantity'],
                widget.productData['productPrice'],
                selectedSize ?? '',
                widget.productData['scheduleDate'],
              );
              showSnak(context, 'Ürün Sepete Eklendi');
            }
          },
          child: Container(
            height: 55,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.purple.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    CupertinoIcons.cart,
                    color: Colors.white,
                    size: 26,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Sepete Ekle',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      letterSpacing: 5,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SimilarProductsSection extends StatefulWidget {
  final String category;
  final String currentProductId;

  const SimilarProductsSection({
    Key? key,
    required this.category,
    required this.currentProductId,
  }) : super(key: key);

  @override
  State<SimilarProductsSection> createState() => _SimilarProductsSectionState();
}

class _SimilarProductsSectionState extends State<SimilarProductsSection> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final List _similarProducts = [];

  Future<void> getSimilarProducts() async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('products')
          .where('category', isEqualTo: widget.category)
          .where('productId', isNotEqualTo: widget.currentProductId)
          .limit(10)
          .get();

      if (mounted) {
        setState(() {
          _similarProducts.clear();
          for (var doc in querySnapshot.docs) {
            _similarProducts.add(doc.data());
          }
        });
      }
    } catch (e) {
      print('Error fetching similar products: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getSimilarProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Benzer Ürünler',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 15),
          Container(
            height: 240,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey[200],
            ),
            child: _similarProducts.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _similarProducts.length,
                    itemBuilder: (context, index) {
                      final product = _similarProducts[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ProductDetailScreen(productData: product),
                              ),
                            );
                          },
                          child: Container(
                            width: 180,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 180,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 8,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: CachedNetworkImage(
                                      imageUrl: product['imageUrl'][0],
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => Shimmer(
                                        duration: const Duration(seconds: 2),
                                        interval: const Duration(seconds: 1),
                                        color: Colors.white,
                                        enabled: true,
                                        child: Container(
                                          color: Colors.grey[300],
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error,
                                              color: Colors.red),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  product['productName'],
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  '₺${product['productPrice'].toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}


