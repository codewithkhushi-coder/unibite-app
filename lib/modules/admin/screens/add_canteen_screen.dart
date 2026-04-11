import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class AddCanteenScreen extends StatelessWidget {
  const AddCanteenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Register New Canteen', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageUpload(),
            const SizedBox(height: 32),
            _buildTextField('Canteen Name', 'e.g. South Campus Mess'),
            const SizedBox(height: 20),
            _buildTextField('University Block / Location', 'e.g. Block C, Near Auditorium'),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: _buildTextField('Opening Time', '08:00 AM')),
                const SizedBox(width: 16),
                Expanded(child: _buildTextField('Closing Time', '10:00 PM')),
              ],
            ),
            const SizedBox(height: 20),
            _buildDropdown('Service Type', ['Veg Only', 'Veg & Non-Veg', 'Snacks & Drinks']),
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
                child: const Text('Add to Marketplace', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildImageUpload() {
    return Center(
      child: Container(
        width: 140, height: 140,
        decoration: BoxDecoration(
          color: AppTheme.softPink.withOpacity(0.3),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: AppTheme.primaryPink.withOpacity(0.1), width: 2),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_a_photo_rounded, color: AppTheme.primaryPink, size: 36),
            SizedBox(height: 8),
            Text('Upload Image', style: TextStyle(color: AppTheme.primaryPink, fontSize: 12, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.textDark, fontSize: 14)),
        const SizedBox(height: 8),
        TextField(
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
