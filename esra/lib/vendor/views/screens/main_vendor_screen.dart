

import 'package:esra/vendor/views/screens/earnings_screen.dart';
import 'package:esra/vendor/views/screens/edit_product_screen.dart';
import 'package:esra/vendor/views/screens/upload_screen.dart';
import 'package:esra/vendor/views/screens/vendor_logout_screen.dart';
import 'package:esra/vendor/views/screens/vendor_order_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainVendorScreen extends StatefulWidget {
  const MainVendorScreen({super.key});

  @override
  State<MainVendorScreen> createState() => _MainVendorScreenState();
}

class _MainVendorScreenState extends State<MainVendorScreen> {
  int pageIndex = 0;

  List<Widget> pages = [
    EarningsScreen(),
    UploadScreen(),
    EditProductScreen(),
    VendorOrderScreen(),
    VendorLogoutScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mağaza Yönetimi',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w600,
            fontFamily: 'Roboto',
            letterSpacing: 1.5,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF8C64B8), // Darker purple
                Color(0xFFC09BDB), // Lighter purple
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 15,
              spreadRadius: 8,
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: pageIndex,
          onTap: (value) {
            setState(() {
              pageIndex = value;
            });
          },
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: Colors.grey.shade600,
          selectedItemColor: Colors.purple.shade300,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.money_dollar),
              label: 'Kazanç',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.upload_file_rounded),
              label: 'Yükle',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.edit_note),
              label: 'Düzenle',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.cart_fill),
              label: 'Siparişler',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.exit_to_app_rounded),
              label: 'Çıkış',
            ),
          ],
        ),
      ),
      body: pages[pageIndex],
    );
  }
}
