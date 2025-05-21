import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchInputWidget extends StatelessWidget {
  const SearchInputWidget({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              spreadRadius: 3,
              blurRadius: 6,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Ürün Ara',
            hintStyle: TextStyle(color: Colors.grey.shade600),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(50), 
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(14.0),
              child: SvgPicture.asset(
                'assets/icons/search.svg',
                width: 22, 
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class WelcomeText extends StatelessWidget {
  const WelcomeText({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text('Hoş Geldiniz! Ürünleri Keşfedin🔎',
                style: TextStyle(
                  fontSize: 24, 
                  fontWeight: FontWeight.w600, 
                  color: Colors.black87, 
                  height: 1.5,
                )),
          ),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color:
                  Colors.deepPurple.shade100, 
              borderRadius:
                  BorderRadius.circular(16), 
            ),
            child: SvgPicture.asset(
              'assets/icons/cart.svg',
              width: 24, 
              height: 24,
            ),
          ),
        ],
      ),
    );
  }
}
