import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class EditFoodItemScreen extends StatelessWidget {
  final String itemId;
  const EditFoodItemScreen({super.key, required this.itemId});

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
            onPressed: () {},
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
            _buildTextField('Item Name', 'Paneer Tikka Roll'),
            const SizedBox(height: 20),
            _buildDropdown('Category', ['Breakfast', 'Lunch', 'Snacks', 'Beverages']),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: _buildTextField('Price (₹)', '120.00', keyboardType: TextInputType.number)),
                const SizedBox(width: 16),
                Expanded(child: _buildTextField('Prep Time (Mins)', '12', keyboardType: TextInputType.number)),
              ],
            ),
            const SizedBox(height: 20),
            _buildTextField('Available Stock', '35', keyboardType: TextInputType.number),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Available for Orders', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Switch(value: true, onChanged: (v) {}, activeColor: AppTheme.successGreen),
              ],
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
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
              image: const DecorationImage(
                image: NetworkImage('https://images.unsplash.com/photo-1599487488170-d11ec9c172f0?w=500'),
                fit: BoxFit.cover,
              ),
            ),
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

  Widget _buildTextField(String label, String initialValue, {TextInputType keyboardType = TextInputType.text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.textDark, fontSize: 14)),
        const SizedBox(height: 8),
        TextField(
          controller: TextEditingController(text: initialValue),
          keyboardType: keyboardType,
          decoration: InputDecoration(
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
              value: items[2], // Snacks
              items: items.map((String value) => DropdownMenuItem<String>(value: value, child: Text(value))).toList(),
              onChanged: (_) {},
            ),
          ),
        ),
      ],
    );
  }
}
