import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vendor_app_only/vendor/models/vendor_user_models.dart';
import 'package:vendor_app_only/vendor/views/auth/vendor_register_screen.dart';
import 'package:vendor_app_only/vendor/views/screens/main_vendor_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final CollectionReference vendorsStream =
        FirebaseFirestore.instance.collection('vendors');

    // تحقق من UID الخاص بالمستخدم
    final String? userId = auth.currentUser?.uid;
    // ignore: avoid_print
    print('User UID: $userId'); // سيتم طباعة UID في Debug Console

    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
        stream: vendorsStream.doc(userId).snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }

          if (!snapshot.data!.exists) {
            return const VendorRegistrationScreen();
          }

          VendorUserModel vendorUserModel = VendorUserModel.fromJson(
              snapshot.data!.data()! as Map<String, dynamic>);

          if (vendorUserModel.approved == true) {
            return const MainVendorScreen();
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                    vendorUserModel.storeImage.toString(),
                    width: 90,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  vendorUserModel.bussinessName.toString(),
                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Your application has been sent to the shop admin.\n'
                  'The admin will get back to you soon.',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w300,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 9),
                TextButton(
                  onPressed: () async {
                    await auth.signOut();
                  },
                  child: const Text('Signout'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
