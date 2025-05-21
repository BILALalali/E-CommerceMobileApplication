import 'package:esra_admin/views/screens/side_bar_screens/categories_screen.dart';
import 'package:esra_admin/views/screens/side_bar_screens/dashboard_screen.dart';
import 'package:esra_admin/views/screens/side_bar_screens/orders_screen.dart';
import 'package:esra_admin/views/screens/side_bar_screens/products_screen.dart';
import 'package:esra_admin/views/screens/side_bar_screens/upload_banner_screen.dart';
import 'package:esra_admin/views/screens/side_bar_screens/upload_product_screen.dart';
import 'package:esra_admin/views/screens/side_bar_screens/vendors_screen.dart';
import 'package:esra_admin/views/screens/side_bar_screens/withdraw_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget _selectedItem = DashboardScreen();

  screenSlector(item) {
    switch (item.route) {
      case DashboardScreen.routeName:
        setState(() {
          _selectedItem = DashboardScreen();
        });

        break;
      case VendorsScreen.routeName:
        setState(() {
          _selectedItem = VendorsScreen();
        });

        break; 
      case WithdrawalScreen.routeName:
        setState(() {
          _selectedItem = WithdrawalScreen();
        });

        break;
      case OrdersScreen.routeName:
        setState(() {
          _selectedItem = OrdersScreen();
        });

        break;
      case CategoriesScreen.routeName:
        setState(() {
          _selectedItem = CategoriesScreen();
        });

        break;
      case ProductsScreen.routeName:
        setState(() {
          _selectedItem = ProductsScreen();
        });

        break;
      case UploadBannerScreen.routeName:
        setState(() {
          _selectedItem = UploadBannerScreen();
        });

        break;
      case UploadProductScreen.routeName:
        setState(() {
          _selectedItem = UploadProductScreen();
        });

        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
        backgroundColor: Colors.white,
        sideBar: SideBar(
            items: [
              AdminMenuItem(
                  title: 'Dashboard',
                  icon: Icons.dashboard,
                  route: DashboardScreen.routeName),
              AdminMenuItem(
                  title: 'Vendors',
                  icon: CupertinoIcons.person_3,
                  route: VendorsScreen.routeName),
              AdminMenuItem(
                  title: 'Withdrawal',
                  icon: CupertinoIcons.money_dollar,
                  route: WithdrawalScreen.routeName),
              AdminMenuItem(
                  title: 'Orders',
                  icon: CupertinoIcons.shopping_cart,
                  route: OrdersScreen.routeName),
              AdminMenuItem(
                  title: 'Categories',
                  icon: Icons.category,
                  route: CategoriesScreen.routeName),
              AdminMenuItem(
                  title: 'Products',
                  icon: Icons.shop,
                  route: ProductsScreen.routeName),
              AdminMenuItem(
                  title: 'Upload Product',
                  icon: CupertinoIcons.add,
                  route: UploadProductScreen.routeName),
              AdminMenuItem(
                  title: 'Upload Banners',
                  icon: CupertinoIcons.add,
                  route: UploadBannerScreen.routeName),  ],
            selectedRoute: ' ',
            onSelected: (item) {
              screenSlector(item);
            },
            header: Container(
                height: 50,
                width: double.infinity,
                color: const Color(0xff444444),
                child: const Center(
                    child: Text('ESRA Store Panel',
                        style: TextStyle(color: Colors.white)))),
            footer: Container(
                height: 50,
                width: double.infinity,
                color: const Color(0xff444444),
                child: const Center(
                    child: Text('footer',
                        style: TextStyle(color: Colors.white))))),
        body: _selectedItem);
  }
}



// شرح الكود:
// الأسطر 1-7: استيراد الحزم والشاشات المطلوبة التي تحتوي على محتويات القوائم الجانبية.
// الأسطر 9-13: تعريف `MainScreen` كصفحة تحتوي على شريط جانبي واختيار الشاشة المناسبة بناءً على العناصر التي يتم النقر عليها.
// الأسطر 15-28: دالة `screenSelector` التي تتعامل مع التبديل بين الشاشات بناءً على المسار الذي يتم تحديده من خلال العناصر.
// الأسطر 30-53: تعريف واجهة المستخدم الرئيسية التي تحتوي على شريط جانبي مع عناصر مختلفة مثل "Dashboard" و "Vendors" و "Orders".
// الأسطر 55-63: تخصيص شريط الرأس والتذييل مع ألوان ونصوص ثابتة لعرض عنوان التطبيق في الجزء العلوي والسفلي. 
// الأسطر 65: عرض الشاشة المختارة داخل `AdminScaffold`. 
