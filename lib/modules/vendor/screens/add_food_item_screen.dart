import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/models/food_item.dart';
import '../controllers/menu_controller.dart';

class AddFoodItemScreen extends ConsumerStatefulWidget {
  const AddFoodItemScreen({super.key});

  @override
  ConsumerState<AddFoodItemScreen> createState() => _AddFoodItemScreenState();
}

class _AddFoodItemScreenState extends ConsumerState<AddFoodItemScreen> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _stockController = TextEditingController();
  final _prepTimeController = TextEditingController();
  String _selectedCategory = 'Breakfast';

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    _prepTimeController.dispose();
    super.dispose();
  }

  Future<void> _handleSave() async {
    final name = _nameController.text.trim();
    final price = double.tryParse(_priceController.text) ?? 0.0;
    
    if (name.isEmpty || price <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter valid name and price')),
      );
      return;
    }

    final newItem = FoodItem(
      id: '', // Supabase will generate this or we handle it in repo
      name: name,
      price: price,
      category: _selectedCategory,
      isAvailable: true,
      imageUrl: '', // Future: upload to Supabase storage
    );

    await ref.read(vendorMenuControllerProvider.notifier).addItem(newItem);
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Add Food Item', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImagePicker(),
            const SizedBox(height: 32),
            _buildTextField('Item Name', 'e.g. Masala Dosa', _nameController),
            const SizedBox(height: 20),
            _buildDropdown('Category', ['Breakfast', 'Lunch', 'Snacks', 'Beverages']),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: _buildTextField('Price (₹)', '0.00', _priceController, keyboardType: TextInputType.number)),
                const SizedBox(width: 16),
                Expanded(child: _buildTextField('Prep Time (Mins)', '15', _prepTimeController, keyboardType: TextInputType.number)),
              ],
            ),
            const SizedBox(height: 20),
            _buildTextField('Available Stock', '50', _stockController, keyboardType: TextInputType.number),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _handleSave,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryPink,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 0,
                ),
                child: const Text('Save Food Item', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePicker() {
    return Center(
      child: Container(
        width: 120, height: 120,
        decoration: BoxDecoration(
          color: AppTheme.softPink.withOpacity(0.5),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: AppTheme.primaryPink.withOpacity(0.2), width: 2),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_a_photo_rounded, color: AppTheme.primaryPink, size: 32),
            SizedBox(height: 8),
            Text('Add Photo', style: TextStyle(color: AppTheme.primaryPink, fontSize: 12, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String hint, TextEditingController controller, {TextInputType keyboardType = TextInputType.text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.textDark, fontSize: 14)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
            filled: true,
            fillColor: Colors.grey.shade50,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown(String label, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.textDark, fontSize: 14)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: BorderRadius.circular(16)),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: _selectedCategory,
              items: items.map((String value) => DropdownMenuItem<String>(value: value, child: Text(value))).toList(),
              onChanged: (v) {
                if (v != null) setState(() => _selectedCategory = v);
              },
            ),
          ),
        ),
      ],
    );
  }
}

