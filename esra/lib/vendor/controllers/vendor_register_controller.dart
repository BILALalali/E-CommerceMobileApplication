import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';

class VendorController {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // دالة لرفع الصورة إلى Firebase Storage
  Future<String> _uploadVendorImageToStorage(Uint8List? image) async {
    Reference ref =
        _storage.ref().child('storeImage').child(_auth.currentUser!.uid);

    UploadTask uploadTask = ref.putData(image!);

    TaskSnapshot snapshot = await uploadTask;

    String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }

  // دالة لاختيار صورة من المعرض أو الكاميرا
  Future<Uint8List?> pickStoreImage(ImageSource source) async {
    final ImagePicker imagePicker = ImagePicker(); // تمت إزالة العلامة السفلية
    XFile? file = await imagePicker.pickImage(
        source: source); // تمت إزالة العلامة السفلية

    if (file != null) {
      return await file.readAsBytes();
    } else {
      debugPrint(
          'لم يتم اختيار صورة'); // تم استبدال print بـ debugPrint    // الخطا احمر  The method 'debugPrint' isn't defined for the type 'VendorController'. Try correcting the name to the name of an existing method, or defining a method named 'debugPrint'.

      return null;
    }
  }

// FUNCTION TO PICK STORE IMAGE ENDS HERE

// FUNCTION TO SAVE VENDOR DATA
  Future<String> registerVendor(
    String bussinessName,
    String email,
    String phoneNumber,
    String countryValue,
    String stateValue,
    String cityValue,
    String taxRegistered,
    String taxNumber,
    Uint8List? image,
  ) async {
    String res = ' some wrror occured ';
    try {
      String storeImage = await _uploadVendorImageToStorage(image);
      // SAVE DATA TO CLOUD FIRESTORE

      await _firestore.collection('vendors').doc(_auth.currentUser!.uid).set({
        'bussinessName': bussinessName,
        'email': email,
        'phoneNumber': phoneNumber,
        'countryValue': countryValue,
        'stateValue': stateValue,
        'cityValue': cityValue,
        'taxRegistered': taxRegistered,
        'taxNumber': taxNumber,
        'storeImage': storeImage,
        'approved': false,
        'vendorId': _auth.currentUser!.uid,
      });
    } catch (e) {
      res = e.toString();
    }

    return res;
  }
  // FUNCTION TO SAVE VENDOR DATA ENDS HERE
}

