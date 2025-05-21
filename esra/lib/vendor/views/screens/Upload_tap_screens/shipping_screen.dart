


import 'package:esra/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShippingScreen extends StatefulWidget {
  @override
  State<ShippingScreen> createState() => _ShippingScreenState();
}

class _ShippingScreenState extends State<ShippingScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  bool? chargeShipping = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ProductProvider productProvider =
        Provider.of<ProductProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Checkbox ListTile
          CheckboxListTile(
            title: Text(
              'Charge Shipping',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.5,
                color: Colors.black87,
              ),
            ),
            value: chargeShipping,
            onChanged: (value) {
              setState(() {
                chargeShipping = value;
                productProvider.getFormData(chargeShipping: chargeShipping);
              });
            },
            activeColor: Colors.deepPurple,
            checkColor: Colors.white,
            controlAffinity: ListTileControlAffinity.leading,
          ),
          if (chargeShipping == true)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter Shipping Charge';
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  productProvider.getFormData(shippingCharge: int.parse(value));
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Shipping Charge',
                  labelStyle: TextStyle(
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple, width: 2.0),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 20.0),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

