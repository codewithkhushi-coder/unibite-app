import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../controllers/auth_controller.dart';

class OtpVerificationScreen extends ConsumerStatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  ConsumerState<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends ConsumerState<OtpVerificationScreen> {
  final List<TextEditingController> _controllers = List.generate(8, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(8, (_) => FocusNode());
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onChanged(String value, int index) {
    if (value.length > 1) {
      // Handle paste: distribute digits across boxes
      final String pastedValue = value.replaceAll(RegExp(r'[^0-9]'), '');
      for (int i = 0; i < pastedValue.length && (index + i) < 8; i++) {
        _controllers[index + i].text = pastedValue[index + i];
      }
      // Move focus to the last filled box or next empty
      final nextIndex = (index + pastedValue.length).clamp(0, 7);
      _focusNodes[nextIndex].requestFocus();
      return;
    }

    if (value.isNotEmpty && index < 7) {
      _focusNodes[index + 1].requestFocus();
    }
  }

  Future<void> _handleVerifyOtp() async {
    final otp = _controllers.map((c) => c.text).join();
    if (otp.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter all 8 digits'),
          backgroundColor: AppTheme.errorRed,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      await ref.read(authControllerProvider.notifier).verifyOtp(otp);
      if (mounted) {
        context.push('/set-password');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}'), backgroundColor: AppTheme.errorRed),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final signupData = ref.watch(signupDataProvider);
    // Calculate box width dynamically with a fallback for very small screens
    final screenWidth = MediaQuery.of(context).size.width;
    final boxWidth = (screenWidth - 60) / 8;

    return Scaffold(
      appBar: AppBar(title: const Text('Verify OTP')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              Text(
                'Verify Your Account',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryPink,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                'Enter the 8-digit code sent to\n${signupData.email}',
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppTheme.textLight),
              ),
              const SizedBox(height: 48),
              // Use a Center + Wrap for better layout stability
              Center(
                child: Wrap(
                  spacing: 4,
                  runSpacing: 8,
                  children: List.generate(8, (index) {
                    return SizedBox(
                      width: boxWidth.clamp(30.0, 42.0),
                      child: RawKeyboardListener(
                        focusNode: FocusNode(canRequestFocus: false),
                        onKey: (event) {
                          if (event is RawKeyDownEvent && 
                              event.logicalKey == LogicalKeyboardKey.backspace && 
                              _controllers[index].text.isEmpty && 
                              index > 0) {
                            _focusNodes[index - 1].requestFocus();
                          }
                        },
                        child: TextFormField(
                          controller: _controllers[index],
                          focusNode: _focusNodes[index],
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          maxLength: 8, // Allow multiple for paste handle
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            counterText: '',
                            contentPadding: const EdgeInsets.symmetric(vertical: 12),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: AppTheme.primaryPink.withOpacity(0.3)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: AppTheme.primaryPink, width: 2),
                            ),
                          ),
                          onChanged: (value) => _onChanged(value, index),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 48),
              ElevatedButton(
                onPressed: _isLoading ? null : _handleVerifyOtp,
                child: _isLoading 
                  ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                  : const Text('Verify Code'),
              ),
              const SizedBox(height: 24),
              TextButton(
                onPressed: () => context.pop(),
                child: const Text('Change Email Address'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
