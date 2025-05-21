import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vendor_app_only/vendor/controllers/vendor_register_controller.dart';
import 'package:flutter/foundation.dart';


class VendorRegistrationScreen extends StatefulWidget {
  const VendorRegistrationScreen({super.key});

  @override
  State<VendorRegistrationScreen> createState() =>
      _VendorRegistrationScreenState();
}

class _VendorRegistrationScreenState extends State<VendorRegistrationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final VendorController _vendorController = VendorController();

  late String countryValue;
  late String bussinessName;
  late String email;
  late String phoneNumber;
  late String taxNumber;   // Exception has occurred. LateError (LateInitializationError: Field 'taxNumber' has not been initialized.)


  late String stateValue;
  late String cityValue;
  Uint8List?
      _image; //Undefined class 'Uint8List'.Try changing the name to the name of an existing class, or creating a class with the name 'Uint8List'.

  // Function to select image from gallery
  selectGalleryImage() async {
    Uint8List? image =
        await _vendorController.pickStoreImage(ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = image;
      });
    }
  }

  // Function to select image from camera
  selectCameraImage() async {
    Uint8List? image =
        await _vendorController.pickStoreImage(ImageSource.camera);
    if (image != null) {
      setState(() {
        _image = image;
      });
    }
  }

  String? _taxStatus;

  final List<String> _taxOptions = [
    'YES',
    'NO',
  ];

  _saveVendorDetail() async {
    EasyLoading.show(status: 'PLEASE WAIT');
    if (_formKey.currentState!.validate()) {
      await _vendorController
          .registerVendor(bussinessName, email, phoneNumber, countryValue,
              stateValue, cityValue, _taxStatus!, taxNumber, _image)
          .whenComplete(() {
        EasyLoading.dismiss();

        setState(() {
          _formKey.currentState!.reset();

          _image = null;
        });
      });
    } else {
      if (kDebugMode) {
        print('Bad');
        EasyLoading.dismiss();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 199,
            flexibleSpace: LayoutBuilder(builder: (context, constraints) {
              return FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.red.shade300,
                        Colors.purple.shade500,
                        Colors.blue.shade200
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
                          child: _image != null
                              ? Image.memory(_image!)
                              : IconButton(
                                  onPressed: selectGalleryImage,
                                  icon: const Icon(Icons.photo),
                                ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
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
                        bussinessName = value;
                      },
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please enter a business name'
                          : null,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        labelText: 'Business Name',
                      ),
                    ),
                    const SizedBox(
                      height: 11,
                    ),
                    TextFormField(
                      onChanged: (value) {
                        email = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Email Address Must not be empty';
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Email Address',
                      ),
                    ),
                    const SizedBox(
                      height: 11,
                    ),
                    TextFormField(
                      onChanged: (value) {
                        phoneNumber = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Phone Number Must not be empty';
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        labelText: 'Phone Number',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(
                        14.0,
                      ),
                      child: SelectState(
                        onCountryChanged: (value) => setState(() {
                          countryValue = value;
                        }),
                        onStateChanged: (value) => setState(() {
                          stateValue = value;
                        }),
                        onCityChanged: (value) => setState(() {
                          cityValue = value;
                        }),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Tax Registered?',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500)),
                          Flexible(
                            child: SizedBox(
                              width: 99,
                              child: DropdownButtonFormField<String>(
                                hint: const Text('Select'),
                                items: _taxOptions
                                    .map((String value) => DropdownMenuItem(
                                        value: value, child: Text(value)))
                                    .toList(),
                                onChanged: (value) => setState(() {
                                  _taxStatus = value;
                                }),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (_taxStatus == 'YES')
                      Padding(
                        padding: const EdgeInsets.all(11.0),
                        child: TextFormField(
                          onChanged: (value) {
                            taxNumber =
                                value; // Undefined name 'texNumber'. Try correcting the name to one that is defined, or defining the name.
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your tax number';
                            } else {
                              return null;
                            }
                          },
                          decoration:
                              const InputDecoration(labelText: 'Tax Number'),
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
                            'Save',
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

