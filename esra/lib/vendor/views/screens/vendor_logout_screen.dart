import 'package:esra/vendor/views/screens/landing_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:esra/views/buyers/auth/login_screen.dart'; // تأكد من استيراد شاشة تسجيل الدخول

// class VendorLogoutScreen extends StatelessWidget {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//         child: TextButton(
//             onPressed: () async {
//               _auth.signOut();
//             },
//             child: Text('Signout')));
//   }
// }

//-------------------------------------------------------

// class VendorLogoutScreen extends StatelessWidget {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: TextButton(
//         onPressed: () async {
//           // عملية تسجيل الخروج
//           await _auth.signOut();

//           // إعادة توجيه المستخدم إلى شاشة تسجيل الدخول

//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => LoginScreen()),  // تأكد من أنك تستورد LoginScreen بشكل صحيح
//           );
//         },
//         child: Text('Signout'),
//       ),
//     );
//   }
// }

class VendorLogoutScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () async {
          try {
            // تسجيل الخروج
            await _auth.signOut();

            // التحقق من تسجيل الخروج بنجاح
            if (_auth.currentUser == null) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LandingScreen(),
                ),
              );
            } else {
              print("User is still logged in");
            }
          } catch (e) {
            print("Error during signout: $e");
          }
        },
        child: Text('Signout'),
      ),
    );
  }
}
