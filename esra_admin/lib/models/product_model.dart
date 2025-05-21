import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id;
  final String productName;
  final double price;
  final int quantity;
  final String description;
  final String category;
  final String imageUrl;
  final DateTime createdAt;

  Product({
    required this.id,
    required this.productName,
    required this.price,
    required this.quantity,
    required this.description,
    required this.category,
    required this.imageUrl,
    required this.createdAt,
  });

  // Factory constructor to create a Product from a Firestore document
  factory Product.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Product(
      id: doc.id,
      productName: data['productName'] ?? '',
      price: (data['price'] ?? 0.0).toDouble(),
      quantity: (data['quantity'] ?? 0).toInt(),
      description: data['description'] ?? '',
      category: data['category'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  // Convert product to a Map for Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'productName': productName,
      'price': price,
      'quantity': quantity,
      'description': description,
      'category': category,
      'imageUrl': imageUrl,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
} 