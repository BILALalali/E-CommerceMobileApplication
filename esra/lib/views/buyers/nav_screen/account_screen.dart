
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esra/views/buyers/auth/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    // التأكد من وجود مستخدم مسجل دخول
    if (auth.currentUser == null) {
      // إذا لم يكن هناك مستخدم مسجل دخول، إعادة توجيه إلى شاشة تسجيل الدخول
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Kullanıcı giriş yapmamış"),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: Text("Giriş Yap"),
              ),
            ],
          ),
        ),
      );
    }

    // إذا كان المستخدم مسجل دخول، إظهار بياناته
    CollectionReference users = FirebaseFirestore.instance.collection('buyers');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(auth.currentUser!.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text("Bir şeyler yanlış gitti"));
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return Center(child: Text("Kullanıcı bilgileri bulunamadı"));
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic>? data =
              snapshot.data!.data() as Map<String, dynamic>?;
          if (data == null ||
              data['profileImage'] == null ||
              data['fullName'] == null ||
              data['email'] == null) {
            return Center(child: Text("Eksik kullanıcı bilgileri"));
          }

          return Scaffold(
            backgroundColor: Colors.grey.shade100,
            appBar: AppBar(
              elevation: 4,
              backgroundColor: Colors.deepPurple.shade400,
              title: Text(
                'Hesap',
                style: TextStyle(letterSpacing: 4, fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              actions: [
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Icon(Icons.wb_sunny, size: 30),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.deepPurple.shade400,
                      backgroundImage: NetworkImage(data['profileImage'] ?? ""),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    data['fullName'] ?? "Ad Soyad Yok",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple.shade600,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    data['email'] ?? "E-posta Yok",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  SizedBox(height: 30),
                  Divider(color: Colors.deepPurple.shade100, thickness: 1.5),
                  SizedBox(height: 20),
                  _buildListTile(Icons.settings, 'Ayarlar'),
                  _buildListTile(Icons.phone_iphone, 'Telefon'),
                  _buildListTile(Icons.shopping_cart, 'Sepet'),
                  _buildListTile(Icons.assignment_turned_in, 'Siparişler'),
                  _buildListTile(Icons.logout, 'Çıkış', onTap: () async {
                    await auth.signOut().whenComplete(() {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    });
                  }),
                ],
              ),
            ),
          );
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildListTile(IconData icon, String title, {VoidCallback? onTap}) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        color: Colors.deepPurple.shade400,
        size: 30,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Colors.deepPurple.shade600,
        ),
      ),
    );
  }
}
