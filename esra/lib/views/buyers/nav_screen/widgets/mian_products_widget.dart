import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:esra/views/buyers/productDetail/product_detail_screen.dart';


class MianProductsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> mainProductsStream =
        FirebaseFirestore.instance.collection('products').snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: mainProductsStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        return ListView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            final productData = snapshot.data!.docs[index];

            return ListTile(
            
              leading: Image.network(productData['imageUrl'][0]),
              title: Text(productData['productName']),
              subtitle: Text('Price: ${productData['productPrice']}'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailScreen(
                      productData: productData,
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
