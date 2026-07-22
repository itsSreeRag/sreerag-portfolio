import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

/// Right section of Contact form: Underline Form Fields (Name, Email, Phone, Message)
class ContactFormFields extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController messageController;

  const ContactFormFields({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.messageController,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Name Input
          TextFormField(
            controller: nameController,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
            decoration: _buildInputDecoration('Name'),
            validator: (val) {
              if (val == null || val.trim().isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          const SizedBox(height: 28),

          // Email Input
          TextFormField(
            controller: emailController,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
            keyboardType: TextInputType.emailAddress,
            decoration: _buildInputDecoration('Email'),
            validator: (val) {
              if (val == null || val.trim().isEmpty) {
                return 'Please enter your email';
              }
              if (!RegExp(
                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
              ).hasMatch(val.trim())) {
                return 'Please enter a valid email address';
              }
              return null;
            },
          ),
          const SizedBox(height: 28),

          // Phone Number Input
          TextFormField(
            controller: phoneController,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
            keyboardType: TextInputType.phone,
            decoration: _buildInputDecoration('Phone Number'),
          ),
          const SizedBox(height: 28),

          // Message Input
          TextFormField(
            controller: messageController,
            maxLines: 4,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
            decoration: _buildInputDecoration('Message'),
            validator: (val) {
              if (val == null || val.trim().isEmpty) {
                return 'Please enter your message';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  InputDecoration _buildInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 15),
      floatingLabelStyle: const TextStyle(
        color: AppColors.dotAccent,
        fontSize: 14,
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 12),
      border: const UnderlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF2A364F)),
      ),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF2A364F)),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.dotAccent, width: 2),
      ),
      errorBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.redAccent),
      ),
    );
  }
}
