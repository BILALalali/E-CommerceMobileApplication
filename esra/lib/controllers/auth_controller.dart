import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  _uploadProfileImageToStorage(Uint8List? image) async {
    Reference ref =
        _storage.ref().child('profilePics').child(_auth.currentUser!.uid);

    UploadTask uploadTask = ref.putData(image!);

    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }

// التالي الان إنشاء وظيفه pickProfileImage...استدعاء لصوره بشاشه تسحيل الدخول
  pickProfileImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: source);

    // بالتالي نتحقق اذا ما كان المستخدم قد اختار الصوره او لا هل ضعط عليها?
    if (_file != null) {
      return await _file.readAsBytes();
    } else {
      print('No Image Selected');
    }
  }

// هنا هذه وظيفه تسجيل قيد للمستخديمن الجدد (signUpUsers))
  Future<String> signUpUsers(String email, String fullName, String phoneNumber,
      String password, Uint8List? Image) async {
    String res = 'Some error occurred';

    try {
      if (email.isNotEmpty &&
          fullName.isNotEmpty &&
          phoneNumber.isNotEmpty &&
          password.isNotEmpty &&
          Image != null) {
        // ignore: unused_local_variable
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        String ProfileImageUrl = await _uploadProfileImageToStorage(Image);

        await _firestore.collection('buyers').doc(cred.user!.uid).set(
          {
            'emal': email,
            'fullName ': fullName,
            'phoneNumber': phoneNumber,
            'buyerId': cred.user!.uid,
            'address': '',
            'profileImage': ProfileImageUrl,
          },
        );

        res = 'User registered successfully';
      } else {
        res = 'Please fill in all fields';
      }
    } catch (e) {}

    return res;
  }

// هنا هذه وظيفه تسجيل الدخول للمستخديمن الحالين (loginUsers))

  loginUsers(String email, String password
      // هنا داحل القواس حددنا الحقول المطلوبه وهي حقل ايميل المستخدم وكلمه المرور
      ) async {
    String res = 'something went wrong';

    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);

        res = 'User registered successfully';
      } else {
        res = 'Please fill in all fields';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}



// شرح الكود:
// الأسطر 1-5: استيراد الحزم اللازمة للتفاعل مع Firebase (المصادقة، تخزين البيانات، وتخزين الملفات).
// الأسطر 7-15: تهيئة الكائنات الخاصة بـ Firebase Auth و Firestore و Firebase Storage.
// الأسطر 17-26: وظيفة لرفع صورة الملف الشخصي إلى Firebase Storage واسترجاع رابط تحميل الصورة.
// الأسطر 28-35: وظيفة لاختيار صورة الملف الشخصي باستخدام مكتبة ImagePicker من المعرض أو الكاميرا.
// الأسطر 37-51: وظيفة لتسجيل مستخدمين جدد والتحقق من صحة المدخلات، ثم رفع صورة الملف الشخصي إلى Firebase Storage وحفظ بيانات المستخدم في Firestore.
// الأسطر 53-64: وظيفة لتسجيل دخول المستخدمين الحاليين باستخدام البريد الإلكتروني وكلمة المرور، مع التحقق من صحة المدخلات.