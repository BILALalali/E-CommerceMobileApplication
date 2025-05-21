

import 'package:esra/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AttribuutesTabScreen extends StatefulWidget {
  @override
  State<AttribuutesTabScreen> createState() => AttribuutesTabScreenState();
}

class AttribuutesTabScreenState extends State<AttribuutesTabScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final TextEditingController sizController = TextEditingController();

  bool entered = false;
  List<String> sizeList = [];
  bool isSave = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ProductProvider productProvider =
        Provider.of<ProductProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Brand Name Input
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'Enter Brand Name';
              } else {
                return null;
              }
            },
            onChanged: (value) {
              productProvider.getFormData(brandName: value);
            },
            decoration: InputDecoration(
              labelText: 'Brand',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.grey[200],
            ),
          ),
          SizedBox(height: 16),

          // Size Input and Add Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextFormField(
                  controller: sizController,
                  onChanged: (value) {
                    setState(() {
                      entered = true;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Size',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
              ),
              SizedBox(width: 10),
              entered
                  ? ElevatedButton(
                      onPressed: () {
                        setState(() {
                          sizeList.add(sizController.text);
                          sizController.clear();
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                            113, 102, 64, 207), // Corrected to backgroundColor
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text('Add'),
                    )
                  : SizedBox.shrink(),
            ],
          ),
          SizedBox(height: 16),

          // Displaying the Size List
          if (sizeList.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: sizeList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            sizeList.removeAt(index);
                            productProvider.getFormData(sizeList: sizeList);
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(169, 80, 46, 173),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 12.0),
                            child: Text(
                              sizeList[index],
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          SizedBox(height: 16),

          // Save Button
          if (sizeList.isNotEmpty)
            ElevatedButton(
              onPressed: () {
                productProvider.getFormData(sizeList: sizeList);

                setState(() {
                  isSave = true;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(
                    66, 145, 43, 196), // Corrected to backgroundColor
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
              ),
              child: Text(
                isSave ? 'Saved' : 'Save',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
