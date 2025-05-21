import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esra_admin/views/screens/side_bar_screens/widgets/banner_widgets.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
class UploadBannerScreen extends StatefulWidget {
  static const String routeName = '\UploadBannerScreen';

  @override
  State<UploadBannerScreen> createState() => _UploadBannerScreenState();
}
class _UploadBannerScreenState extends State<UploadBannerScreen> {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  dynamic _image;
  String? fileName;

  pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.image,
    );

    if (result != null) {
      setState(() {
        _image = result.files.first.bytes;
        fileName = result.files.first.name;
      });
    }
  }

  Future<String> _uploadToFireStorage(dynamic image) async {
    Reference ref = _storage.ref().child('Banners').child(fileName!);
    UploadTask uploadTask = ref.putData(image);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> uploadToFirebaseStore() async {
    EasyLoading.show();
    if (_image != null) {
      String imageUrl = await _uploadToFireStorage(_image);

      await _firestore.collection('banners').doc(fileName).set({
        'image': imageUrl,
      }).whenComplete(() {
        EasyLoading.dismiss();

        setState(() {
          _image = null;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Banners',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 36,
              ),
            ),
          ),
          Divider(
            color: Colors.grey,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  children: [
                    Container(
                      height: 149,
                      width: 149,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade700,
                        border: Border.all(color: Colors.grey.shade800),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: _image != null
                          ? Image.memory(
                              _image,
                              fit: BoxFit.cover,
                            )
                          : Center(
                              child: Text('Banners'),
                            ),
                    ),
                    SizedBox(
                      height: 21,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow.shade900),
                      onPressed: pickImage,
                      child: Text('Upload Image'),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 30,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow.shade900),
                onPressed: uploadToFirebaseStore,
                child: Text('Save'),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Divider(
              color: Colors.grey,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.topLeft,
              child: Text(
                'Banners',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          BannerWidgets(),
        ],
      ),
    );
  }
}






/* شرح الكود:
1. الأسطر 1-2: استيراد الحزم الضرورية مثل `cloud_firestore` للتعامل مع Firebase Firestore و `firebase_storage` لتخزين البيانات في Firebase Storage.
2. الأسطر 4-6: إنشاء متغيرات لتخزين البيانات المتعلقة بالصورة، مثل `_image` و `fileName`.
3. الأسطر 9-19: دالة `pickImage` لاختيار صورة من الجهاز باستخدام `FilePicker`.
4. الأسطر 21-29: دالة `_uploadToFireStorage` لتحميل الصورة إلى Firebase Storage واسترجاع الرابط.
5. الأسطر 31-42: دالة `uploadToFirebaseStore` لحفظ الرابط في Firestore بعد تحميل الصورة إلى Firebase Storage.
6. الأسطر 44-78: عرض واجهة المستخدم التي تسمح للمستخدم باختيار صورة وتحميلها إلى Firebase. تتضمن واجهة المستخدم صورة مصغرة للصورة المختارة وزر لتحميل الصورة إلى Firebase.
*/