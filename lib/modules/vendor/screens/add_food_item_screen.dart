import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class AddFoodItemScreen extends StatelessWidget {
  const AddFoodItemScreen({super.key});

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
            _buildTextField('Item Name', 'e.g. Masala Dosa'),
            const SizedBox(height: 20),
            _buildDropdown('Category', ['Breakfast', 'Lunch', 'Snacks', 'Beverages']),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: _buildTextField('Price (₹)', '0.00', keyboardType: TextInputType.number)),
                const SizedBox(width: 16),
                Expanded(child: _buildTextField('Prep Time (Mins)', '15', keyboardType: TextInputType.number)),
              ],
            ),
            const SizedBox(height: 20),
            _buildTextField('Available Stock', '50', keyboardType: TextInputType.number),
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

  Widget _buildTextField(String label, String hint, {TextInputType keyboardType = TextInputType.text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.textDark, fontSize: 14)),
        const SizedBox(height: 8),
        TextField(
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
              value: items.first,
              items: items.map((String value) => DropdownMenuItem<String>(value: value, child: Text(value))).toList(),
              onChanged: (_) {},
            ),
          ),
        ),
      ],
    );
  }
}
