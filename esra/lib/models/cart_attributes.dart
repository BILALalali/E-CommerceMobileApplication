import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CartAttr with ChangeNotifier {
  final String productName;
  final String productId;
  final List imageUrl;
  int quantity;
  int productQuantity;
  final double price;
  final String productSize;
  Timestamp scheduleDate;

  CartAttr({
    required this.productName,
    required this.productId,
    required this.imageUrl,
    required this.quantity,
    required this.productQuantity,
    required this.price,
    required this.productSize,
    required this.scheduleDate,
  });

  void increase() {
    quantity++;
  }

  void decrease() {
    quantity--;
  }
}


// class CartAttr with ChangeNotifier {
//   final String productName;
//   final String productId;
//   final List imageUrl;
//   int quanitity;
//   int productQuantity;
//   final double price;
//   final String vendorId;
//   final String productSize;
//   Timestamp scheduleDate;

//   CartAttr(
//       {required this.productName,
//       required this.productId,
//       required this.imageUrl,
//       required this.quanitity,
//       required this.productQuantity,
//       required this.price,
//       required this.vendorId,
//       required this.productSize,
//       required this.scheduleDate});

//   void increase() {
//     quanitity++;
//   }

//   void decrease() {
//     quanitity--;
//   }
// }

