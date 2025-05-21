import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esra/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class GeneralScreen extends StatefulWidget {
  @override
  State<GeneralScreen> createState() => GeneralScreenState();
}

class GeneralScreenState extends State<GeneralScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final List<String> _categoryList = [];
  final _formKey = GlobalKey<FormState>();
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    try {
      final QuerySnapshot querySnapshot = await _firestore.collection('categories').get();
      setState(() {
        _categoryList.addAll(
          querySnapshot.docs.map((doc) => doc['categoryName'] as String).toList(),
        );
      });
    } catch (e) {
      print('Error loading categories: $e');
    }
  }

  String _formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ProductProvider productProvider = Provider.of<ProductProvider>(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader('Product Information'),
            const SizedBox(height: 20),
            _buildTextField(
              label: 'Product Name',
              validator: (value) => value?.isEmpty ?? true ? 'Please enter product name' : null,
              onChanged: (value) => productProvider.getFormData(productName: value),
            ),
            const SizedBox(height: 16),
            _buildTextField(
              label: 'Price',
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value?.isEmpty ?? true) return 'Please enter price';
                if (double.tryParse(value!) == null) return 'Please enter valid price';
                return null;
              },
              onChanged: (value) => productProvider.getFormData(
                productPrice: double.tryParse(value) ?? 0.0,
              ),
            ),
            const SizedBox(height: 16),
            _buildTextField(
              label: 'Quantity',
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value?.isEmpty ?? true) return 'Please enter quantity';
                if (int.tryParse(value!) == null) return 'Please enter valid quantity';
                return null;
              },
              onChanged: (value) => productProvider.getFormData(
                quantity: int.tryParse(value) ?? 0,
              ),
            ),
            const SizedBox(height: 16),
            _buildDropdown(
              label: 'Category',
              value: _selectedCategory,
              items: _categoryList,
              onChanged: (value) {
                setState(() => _selectedCategory = value);
                productProvider.getFormData(category: value);
              },
            ),
            const SizedBox(height: 16),
            _buildTextField(
              label: 'Description',
              maxLines: 4,
              validator: (value) => value?.isEmpty ?? true ? 'Please enter description' : null,
              onChanged: (value) => productProvider.getFormData(description: value),
            ),
            const SizedBox(height: 20),
            _buildScheduleSection(productProvider),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.deepPurple,
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String? Function(String?) validator,
    required Function(String) onChanged,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.grey.shade50,
      ),
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      onChanged: onChanged,
    );
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.grey.shade50,
      ),
      value: value,
      items: items.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
      validator: (value) => value == null ? 'Please select a category' : null,
    );
  }

  Widget _buildScheduleSection(ProductProvider productProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader('Schedule'),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2025),
                  );
                  if (date != null) {
                    productProvider.getFormData(scheduleDate: date);
                  }
                },
                icon: Icon(Icons.calendar_today),
                label: Text('Select Date'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            if (productProvider.productData['scheduleDate'] != null) ...[
              const SizedBox(width: 16),
              Text(
                _formatDate(productProvider.productData['scheduleDate']),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.deepPurple,
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}
