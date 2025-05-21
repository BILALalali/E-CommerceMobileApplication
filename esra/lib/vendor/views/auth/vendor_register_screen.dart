import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:esra/vendor/controllers/vendor_register_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';


class VendorRegistrationScreen extends StatefulWidget {
  @override
  State<VendorRegistrationScreen> createState() =>
      _VendorRegistrationScreenState();
}

class _VendorRegistrationScreenState extends State<VendorRegistrationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final VendorController _vendorController = VendorController();

  late String countryValue;
  late String businessName;
  late String email;
  late String phoneNumber;
  late String taxNumber;
  late String stateValue;
  late String cityValue;
  Uint8List? image;

  Future<void> selectGalleryImage() async {
    Uint8List? im = await _vendorController.pickStoreImage(ImageSource.gallery);
    setState(() {
      image = im;
    });
  }

  Future<void> selectCameraImage() async {
    Uint8List? im = await _vendorController.pickStoreImage(ImageSource.camera);
    setState(() {
      image = im;
    });
  }

  String? _taxStatus;
  final List<String> _taxOptions = ['EVET', 'HAYIR'];

  Future<void> _saveVendorDetail() async {
    EasyLoading.show(status: 'Lütfen Bekleyin...');
    if (_formKey.currentState!.validate()) {
      await _vendorController
          .registerVendor(
        businessName,
        email,
        phoneNumber,
        countryValue,
        stateValue,
        cityValue,
        _taxStatus!,
        taxNumber,
        image,
      )
          .whenComplete(() {
        EasyLoading.dismiss();
        setState(() {
          _formKey.currentState!.reset();
          image = null;
        });
      });
    } else {
      EasyLoading.dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 199,
            flexibleSpace: LayoutBuilder(
              builder: (context, constraints) {
                return FlexibleSpaceBar(
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.red.shade300,
                          Colors.purple.shade500,
                          Colors.blue.shade200,
                        ],
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 99,
                            width: 99,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: image != null
                                ? Image.memory(image!)
                                : IconButton(
                                    onPressed: selectGalleryImage,
                                    icon: const Icon(CupertinoIcons.photo),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(11.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      onChanged: (value) {
                        businessName = value;
                      },
                      validator: (value) =>
                          value!.isEmpty ? 'Lütfen işletme adını girin' : null,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        labelText: 'İşletme Adı',
                      ),
                    ),
                    const SizedBox(height: 11),
                    TextFormField(
                      onChanged: (value) {
                        email = value;
                      },
                      validator: (value) =>
                          value!.isEmpty ? 'E-posta adresi boş olamaz' : null,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'E-posta Adresi',
                      ),
                    ),
                    const SizedBox(height: 11),
                    TextFormField(
                      onChanged: (value) {
                        phoneNumber = value;
                      },
                      validator: (value) =>
                          value!.isEmpty ? 'Telefon numarası boş olamaz' : null,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        labelText: 'Telefon Numarası',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: SelectState(
                        onCountryChanged: (value) {
                          setState(() {
                            countryValue = value;
                          });
                        },
                        onStateChanged: (value) {
                          setState(() {
                            stateValue = value;
                          });
                        },
                        onCityChanged: (value) {
                          setState(() {
                            cityValue = value;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Vergi Kaydı Var mı?',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Flexible(
                            child: SizedBox(
                              width: 99,
                              child: DropdownButtonFormField<String>(
                                hint: const Text('Seçiniz'),
                                items: _taxOptions
                                    .map(
                                      (value) => DropdownMenuItem(
                                        value: value,
                                        child: Text(value),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _taxStatus = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (_taxStatus == 'EVET')
                      Padding(
                        padding: const EdgeInsets.all(11.0),
                        child: TextFormField(
                          onChanged: (value) {
                            taxNumber = value;
                          },
                          validator: (value) => value!.isEmpty
                              ? 'Lütfen vergi numaranızı girin'
                              : null,
                          decoration: const InputDecoration(
                            labelText: 'Vergi Numarası',
                          ),
                        ),
                      ),
                    InkWell(
                      onTap: _saveVendorDetail,
                      child: Container(
                        height: 36,
                        width: MediaQuery.of(context).size.width - 49,
                        decoration: BoxDecoration(
                          color: Colors.purple.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            'Kaydet',
                            style: TextStyle(
                                fontSize: 21,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
