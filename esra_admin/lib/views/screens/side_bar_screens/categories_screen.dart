import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esra_admin/views/screens/side_bar_screens/widgets/category_widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class CategoriesScreen extends StatefulWidget {
  static const String routeName = '/CategoriesScreen';
  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); // مفتاح التحقق للنموذج.
  dynamic _image; // تخزين الصورة لمختارة.
  String? fileName; // تخزين اسم الملف.
  String categoryName = ''; // تخزين اسم الفئة المدخل.
  Future<void> _pickImage() async {
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

  Future<String> _uploadCategoryBannerToStorage(dynamic image) async {
    // إنشاء مرجع لمسار التخزين.
    Reference ref = _storage.ref().child('categoryImages').child(fileName!);
    UploadTask uploadTask = ref.putData(image); // بدء عملية الرفع.
    TaskSnapshot snapshot = await uploadTask; // انتظار اكتمال الرفع.
    return await snapshot.ref.getDownloadURL(); // إرجاع رابط الصورة.
  }

  void uploadCategory() async {
    if (_formKey.currentState!.validate() && _image != null) {
      EasyLoading.show(status: 'Uploading...'); // عرض شاشة تحميل.
      try {
        String imageUrl = await _uploadCategoryBannerToStorage(_image);
        await _firestore.collection('categories').doc(fileName).set({
          'image': imageUrl,
          'categoryName': categoryName,
        });

        EasyLoading.dismiss(); // إخفاء شاشة التحميل.
        setState(() {
          _image = null;
          _formKey.currentState!.reset();
          fileName = null;
          categoryName = '';
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Category uploaded successfully!')),
        );
      } catch (error) {
        EasyLoading.dismiss(); // إخفاء شاشة التحميل عند حدوث خطأ.
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Upload failed: $error')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text('Please select an image and fill in the category name')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey, // ربط النموذج بالمفتاح للتحقق من صحة البيانات.
        child: Column(
          children: [
            Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.all(10),
                child: const Text('Category',
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 36))),
            const Divider(color: Colors.grey), // فاصل لتنسيق العرض.
            Row(children: [
              Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(children: [
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
                                _image, // عرض الصورة إذا تم اختيارها.
                                fit: BoxFit.cover,
                              )
                            : const Center(child: Text('Category'))),
                    const SizedBox(height: 21), // مساحة بين الصورة وزر التحميل.
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow.shade900,
                        ),
                        onPressed: _pickImage,
                        child: const Text('Upload Image'))
                  ])),
              Flexible(
                  child: SizedBox(
                      width: 177,
                      child: TextFormField(
                          onChanged: (value) => categoryName = value,
                          validator: (value) {
                            // التحقق من عدم ترك الحقل فارغًا.
                            if (value == null || value.isEmpty) {
                              return 'Category Name must not be empty';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              labelText: 'Enter Category Name',
                              hintText: 'Enter Category Name')))),
              const SizedBox(width: 30),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow.shade900,
                  ),
                  onPressed: uploadCategory,
                  child: const Text('Save'))
            ]),
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
                    child: Text('Categories',
                        style: TextStyle(
                            fontSize: 36, fontWeight: FontWeight.bold)))),
            CategoryWidget(), // ويدجت لعرض قائمة الفئات المتوفرة.
          ],
        ),
      ),
    );
  }
}

// شرح الكود:
// - السطر 1-5: استيراد المكتبات اللازمة لتشغيل واجهة Flutter، Firebase، وأدوات رفع الصور واختيارها.
// - السطر 7-12: تعريف واجهة `CategoriesScreen` كـ `StatefulWidget`، وتحديد مسار ثابت للشاشة للتنقل.
// - السطر 14-25: إعداد الحالة `CategoriesScreenState` وتعريف المتغيرات الرئيسية، مثل مراجع Firebase Storage وFirestore، ومتغيرات لتخزين الصورة واسم الفئة.
// - السطر 27-38: تعريف دالة `_pickImage` لاختيار صورة من جهاز المستخدم وتخزين بياناتها واسمها.
// - السطر 40-47: تعريف دالة `_uploadCategoryBannerToStorage` لتحميل الصورة إلى Firebase Storage والحصول على رابط التحميل.
// - السطر 49-79: تعريف دالة `uploadCategory` للتحقق من المدخلات (التأكد من صحة البيانات)، ورفع بيانات الفئة إلى Firestore، مع عرض رسائل للمستخدم أثناء العملية وعند النجاح أو الفشل.
// - السطر 81-134: بناء واجهة المستخدم باستخدام `Form` يحتوي على حقول الإدخال لاختيار الصورة وكتابة اسم الفئة، مع زر لحفظ الفئة.
// - السطر 136-147: إضافة قسم لعرض قائمة الفئات، باستخدام ويدجت `CategoryWidget` لعرض الفئات المتوفرة.
