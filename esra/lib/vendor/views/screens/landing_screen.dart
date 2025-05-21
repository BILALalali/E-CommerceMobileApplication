

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esra/vendor/models/vendor_user_models.dart';
import 'package:esra/vendor/views/auth/vendor_register_screen.dart';
import 'package:esra/vendor/views/screens/main_vendor_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final CollectionReference vendorsStream =
        FirebaseFirestore.instance.collection('vendors');
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
        stream: vendorsStream.doc(auth.currentUser!.uid).snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Bir hata oluştu'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.data!.exists) {
            return VendorRegistrationScreen(); // Yeni kayıt işlemi
          }

          VendorUserModel vendorUserModel = VendorUserModel.fromJson(
              snapshot.data!.data()! as Map<String, dynamic>);

          if (vendorUserModel.approved == true) {
            return const MainVendorScreen(); // Ana ekran
          }
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      vendorUserModel.storeImage.toString(),
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    vendorUserModel.bussinessName.toString(),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.purple,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Başvurunuz mağaza yöneticisine gönderildi.\n'
                    'Yönetici yakında sizinle iletişime geçecektir.',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      await auth.signOut();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple.shade300, // تعديل هنا
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Çıkış Yap',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
