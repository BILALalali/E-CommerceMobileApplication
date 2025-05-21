import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:esra/models/cart_attributes.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartAttr> cartItems = {};

  Map<String, CartAttr> get getCartItem {
    return cartItems;
  }

  double get totalPrice {
    var total = 0.00;

    cartItems.forEach((key, value) {
      total += value.price * value.quantity;
    });

    return total;
  }

  // void addProductToCart(
  //     String productName,
  //     String productId,
  //     List imageUrl,
  //     int quantity,
  //     int productQuantity,
  //     double price,
  //     String vendorId,
  //     String productSize,
  //     Timestamp scheduleDate) {
  //   if (cartItems.containsKey(productId)) {
  //     cartItems.update(
  //         productId,
  //         (exitingCart) => CartAttr(
  //             productName: exitingCart.productName,
  //             productId: exitingCart.productId,
  //             imageUrl: exitingCart.imageUrl,
  //             quantity: exitingCart.quantity + 1,
  //             productQuantity: exitingCart.productQuantity,
  //             price: exitingCart.price,
  //             //  vendorId: exitingCart.vendorId,
  //             productSize: exitingCart.productSize,
  //             scheduleDate: exitingCart.scheduleDate));

  //     notifyListeners();
  //   } else {
  //     cartItems.putIfAbsent(
  //         productId,
  //         () => CartAttr(
  //             productName: productName,
  //             productId: productId,
  //             imageUrl: imageUrl,
  //             quantity: quantity,
  //             productQuantity: productQuantity,
  //             price: price,
  //             //     vendorId: vendorId,
  //             productSize: productSize,
  //             scheduleDate: scheduleDate));

  //     notifyListeners();
  //   }
  // }
  void addProductToCart(
    String productName,
    String productId,
    List imageUrl,
    int quantity,
    int productQuantity,
    double price,
    String productSize,
    Timestamp scheduleDate,
  ) {
    if (cartItems.containsKey(productId)) {
      cartItems.update(
        productId,
        (existingCart) => CartAttr(
          productName: existingCart.productName,
          productId: existingCart.productId,
          imageUrl: existingCart.imageUrl,
          quantity: existingCart.quantity + 1,
          productQuantity: existingCart.productQuantity,
          price: existingCart.price,
          productSize: existingCart.productSize,
          scheduleDate: existingCart.scheduleDate,
        ),
      );
      notifyListeners();
    } else {
      cartItems.putIfAbsent(
        productId,
        () => CartAttr(
          productName: productName,
          productId: productId,
          imageUrl: imageUrl,
          quantity: quantity,
          productQuantity: productQuantity,
          price: price,
          productSize: productSize,
          scheduleDate: scheduleDate,
        ),
      );
      notifyListeners();
    }
  }

/////////// 77 7//////

  void increament(CartAttr cartAttr) {
    cartAttr.increase();

    notifyListeners();
  }

  void decreaMent(CartAttr cartAttr) {
    cartAttr.decrease();

    notifyListeners();
  }

  removeItem(productId) {
    cartItems.remove(productId);

    notifyListeners();
  }

  removeAllItem() {
    cartItems.clear();

    notifyListeners();
  }
}
