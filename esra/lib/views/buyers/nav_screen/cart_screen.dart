import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:esra/provider/cart_provider.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final CartProvider cartProvider = Provider.of<CartProvider>(
      context,
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade400,
        elevation: 0,
        title: Text(
          'Sepetim',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 3,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              cartProvider.removeAllItem();
            },
            icon: Icon(
              CupertinoIcons.delete,
            ),
          ),
        ],
      ),
      body: cartProvider.getCartItem.isEmpty
          ? Center(
              child: Text(
                'Sepetiniz boş!',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black54,
                ),
              ),
            )
          : ListView.builder(
              shrinkWrap: true,
              itemCount: cartProvider.getCartItem.length,
              itemBuilder: (
                context,
                index,
              ) {
                final cartData =
                    cartProvider.getCartItem.values.toList()[index];
                return Card(
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      12,
                    ),
                  ),
                  child: SizedBox(
                    height: 170,
                    child: Row(
                      children: [
                        SizedBox(
                          height: 99,
                          width: 99,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                              8,
                            ),
                            child: Image.network(cartData.imageUrl[0],
                                fit: BoxFit.cover),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(
                            14.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cartData.productName,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.5,
                                ),
                              ),
                              Text(
                                '₺ ${cartData.price.toStringAsFixed(
                                  2,
                                )}',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurple.shade400,
                                ),
                              ),
                              OutlinedButton(
                                onPressed: null,
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                    color: Colors.deepPurple.shade200,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      8,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  cartData.productSize,
                                  style: TextStyle(
                                    color: Colors.deepPurple.shade400,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 40,
                                    width: 115,
                                    decoration: BoxDecoration(
                                      color: Colors.deepPurple.shade100,
                                      borderRadius: BorderRadius.circular(
                                        8,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        IconButton(
                                          onPressed: cartData.quantity == 1
                                              ? null
                                              : () {
                                                  cartProvider.decreaMent(
                                                    cartData,
                                                  );
                                                },
                                          icon: Icon(
                                            CupertinoIcons.minus,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          cartData.quantity.toString(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        IconButton(
                                          onPressed: cartData.productQuantity ==
                                                  cartData.quantity
                                              ? null
                                              : () {
                                                  cartProvider
                                                      .increament(cartData);
                                                },
                                          icon: Icon(
                                            CupertinoIcons.plus,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      cartProvider.removeItem(
                                        cartData.productId,
                                      );
                                    },
                                    icon: Icon(
                                      CupertinoIcons.cart_badge_minus,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(
          8.0,
        ),
        child: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade400,
            borderRadius: BorderRadius.circular(
              12,
            ),
          ),
          child: Center(
            child: Text(
              "₺ ${cartProvider.totalPrice.toStringAsFixed(
                2,
              )}  ÖDEME",
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 4,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
