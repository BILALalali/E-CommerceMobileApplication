

import 'dart:io';
import 'package:esra/provider/product_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class ImagesTabScreen extends StatefulWidget {
  @override
  State<ImagesTabScreen> createState() => ImagesTabScreenState();
}

class ImagesTabScreenState extends State<ImagesTabScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final ImagePicker picker = ImagePicker();
  final FirebaseStorage storage = FirebaseStorage.instance;

  List<File> image = [];
  List<String> imageUrlList = [];

  choosImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) {
      print('no image picked');
    } else {
      setState(() {
        image.add(File(pickedFile.path));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ProductProvider productProvider =
        Provider.of<ProductProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Title
          Text(
            'Upload Product Images',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurpleAccent,
            ),
          ),
          SizedBox(height: 20),

          // Image Grid with Add button
          GridView.builder(
            shrinkWrap: true,
            itemCount: image.length + 1,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, index) {
              return index == 0
                  ? GestureDetector(
                      onTap: choosImage,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(103, 58, 183,
                              0.1), // Replaced with Color.fromRGBO()
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.deepPurpleAccent,
                            width: 1.5,
                          ),
                        ),
                        child: Icon(
                          Icons.add_a_photo,
                          size: 30,
                          color: Colors.deepPurpleAccent,
                        ),
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(
                        image[index - 1],
                        fit: BoxFit.cover,
                      ),
                    );
            },
          ),
          SizedBox(height: 30),

          // Upload Button with Animation
          ElevatedButton(
            onPressed: () async {
              if (image.isNotEmpty) {
                EasyLoading.show(status: 'Uploading images...');
                for (var img in image) {
                  Reference ref =
                      storage.ref().child('productImage').child(Uuid().v4());

                  await ref.putFile(img).whenComplete(() async {
                    await ref.getDownloadURL().then((value) {
                      setState(() {
                        imageUrlList.add(value);
                      });
                    });
                  });
                }

                setState(() {
                  productProvider.getFormData(imageUrlList: imageUrlList);
                  EasyLoading.dismiss();
                });
              } else {
                EasyLoading.showError('No images selected');
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurpleAccent, // Fixed property name

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
            ),
            child: Text(
              'Upload Images',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
