import 'package:esra/views/buyers/nav_screen/account_screen.dart';
import 'package:esra/views/buyers/nav_screen/cart_screen.dart';
import 'package:esra/views/buyers/nav_screen/category_screen.dart';
import 'package:esra/views/buyers/nav_screen/home_screen.dart';
import 'package:esra/views/buyers/nav_screen/search_screen.dart';
import 'package:esra/views/buyers/nav_screen/store_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:esra/chatbot/chatbot_home.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _pageIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    CategoryScreen(),
    StoreScreen(),
    CartScreen(),
    SearchScreen(),
    AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Makes content extend behind AppBar
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF673AB7).withAlpha(
                    230), // Adjusted opacity for color (instead of withOpacity)
                Color(0xFF9C27B0).withAlpha(
                    178), // Adjusted opacity for color (instead of withOpacity)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: SafeArea(
            child: AppBar(
              centerTitle: true,
              title: Text(
                'Esra Market',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  color: Colors.white,
                ),
              ),
              actions: [
                Container(
                  margin: EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(51),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: IconButton(
                    icon: Icon(
                      CupertinoIcons.chat_bubble_fill,
                      size: 26,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ChatbotHome()),
                      );
                    },
                  ),
                ),
              ],
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
          ),
        ),
      ),
      body: _pages[_pageIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 15,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _pageIndex,
            onTap: (value) {
              setState(() {
                _pageIndex = value;
              });
            },
            selectedItemColor: Colors.deepPurple,
            unselectedItemColor: Colors.grey.shade500,
            selectedLabelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            unselectedLabelStyle: TextStyle(
              fontSize: 11,
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            items: [
              _buildNavItem(CupertinoIcons.home, 'ANA SAYFA'),
              _buildNavItem(CupertinoIcons.square_grid_2x2, 'KATEGORİLER'),
              _buildNavItem(CupertinoIcons.shopping_cart, 'STORE'),
              _buildNavItem(CupertinoIcons.bag, 'SEPET'),
              _buildNavItem(CupertinoIcons.search, 'ARA'),
              _buildNavItem(CupertinoIcons.person, 'HESAP'),
            ],
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(IconData icon, String label) {
    return BottomNavigationBarItem(
      icon: Container(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Icon(icon, size: 24),
      ),
      label: label,
    );
  }
}
