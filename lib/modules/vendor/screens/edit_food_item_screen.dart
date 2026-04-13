import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/models/food_item.dart';
import '../controllers/menu_controller.dart';

class EditFoodItemScreen extends ConsumerStatefulWidget {
  final FoodItem item;
  const EditFoodItemScreen({super.key, required this.item});

  @override
  ConsumerState<EditFoodItemScreen> createState() => _EditFoodItemScreenState();
}

class _EditFoodItemScreenState extends ConsumerState<EditFoodItemScreen> {
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _stockController;
  late TextEditingController _prepTimeController;
  late String _selectedCategory;
  late bool _isAvailable;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.item.name);
    _priceController = TextEditingController(text: widget.item.price.toString());
    _stockController = TextEditingController(text: '50'); // Default or fetch if exists
    _prepTimeController = TextEditingController(text: '15');
    _selectedCategory = widget.item.category;
    _isAvailable = widget.item.isAvailable;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    _prepTimeController.dispose();
    super.dispose();
  }

  Future<void> _handleUpdate() async {
    final updatedItem = widget.item.copyWith(
      name: _nameController.text.trim(),
      price: double.tryParse(_priceController.text) ?? widget.item.price,
      category: _selectedCategory,
      isAvailable: _isAvailable,
    );

    await ref.read(vendorMenuControllerProvider.notifier).updateItem(updatedItem);
    if (mounted) Navigator.pop(context);
  }

  Future<void> _handleDelete() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Item?'),
        content: const Text('Are you sure you want to remove this item from the menu?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true), 
            child: const Text('Delete', style: TextStyle(color: AppTheme.errorRed)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ref.read(vendorMenuControllerProvider.notifier).deleteItem(widget.item.id!);
      if (mounted) Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Edit Food Item', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline_rounded, color: AppTheme.errorRed),
            onPressed: _handleDelete,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImagePicker(),
            const SizedBox(height: 32),
            _buildTextField('Item Name', 'Item Name', _nameController),
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
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Available for Orders', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Switch(
                  value: _isAvailable, 
                  onChanged: (v) => setState(() => _isAvailable = v), 
                  activeColor: AppTheme.successGreen
                ),
              ],
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _handleUpdate,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryPink,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 0,
                ),
                child: const Text('Save Changes', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePicker() {
    return Center(
      child: Stack(
        children: [
          Container(
            width: 120, height: 120,
            decoration: BoxDecoration(
              color: AppTheme.softPink.withOpacity(0.5),
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Icon(Icons.restaurant_menu_rounded, color: AppTheme.primaryPink, size: 48),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(color: AppTheme.primaryPink, shape: BoxShape.circle),
              child: const Icon(Icons.edit_rounded, color: Colors.white, size: 20),
            ),
          ),
        ],
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

