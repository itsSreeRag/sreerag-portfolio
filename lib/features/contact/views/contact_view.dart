import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sreerag_dev/core/theme/app_typography.dart';

import '../../../core/responsive/responsive_breakpoints.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../viewmodels/contact_viewmodel.dart';
import '../widgets/contact_success_dialog.dart';

class ContactView extends StatefulWidget {
  const ContactView({super.key});

  @override
  State<ContactView> createState() => _ContactViewState();
}

class _ContactViewState extends State<ContactView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submitForm(
    BuildContext context,
    ContactViewModel viewModel,
  ) async {
    if (_formKey.currentState!.validate()) {
      final success = await viewModel.submitForm(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        phone: _phoneController.text.trim(),
        subject: 'Portfolio Inquiry',
        message: _messageController.text.trim(),
      );
      if (success && context.mounted) {
        _nameController.clear();
        _emailController.clear();
        _phoneController.clear();
        _messageController.clear();
        showDialog(
          context: context,
          builder: (context) => const ContactSuccessDialog(),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.isMobile(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? AppSpacing.lg : AppSpacing.xxl,
        vertical: isMobile ? 48 : 80,
      ),
      child: Consumer<ContactViewModel>(
        builder: (context, viewModel, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Red Line Accent & Contacts Header (matching reference image)
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(width: 100, height: 2, color: AppColors.dotAccent),
                  const SizedBox(width: 16),
                  Text(
                    'Contacts',
                    style: AppTypography.displayMedium(
                      color: Colors.white,
                    ).copyWith(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              const SizedBox(height: 48),

              // 2-Column Main Section (Headline + Submit Button on Left, Minimal Underline Form on Right)
              Flex(
                direction: isMobile ? Axis.vertical : Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left Column: Headline + Solid Coral Red Submit Button
                  Expanded(
                    flex: isMobile ? 0 : 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Have a project?\nLet\'s talk!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: isMobile ? 36 : 48,
                            fontWeight: FontWeight.w700,
                            height: 1.15,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 36),

                        // Solid Coral Red Submit Button (matching reference image)
                        SizedBox(
                          height: 48,
                          child: ElevatedButton(
                            onPressed: viewModel.isSubmitting
                                ? null
                                : () => _submitForm(context, viewModel),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.dotAccent,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 36,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              elevation: 0,
                            ),
                            child: viewModel.isSubmitting
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text(
                                    'Submit',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  if (isMobile)
                    const SizedBox(height: 48)
                  else
                    const SizedBox(width: 80),

                  // Right Column: Underline Form Fields (Name, Email, Phone Number, Message)
                  Expanded(
                    flex: isMobile ? 0 : 7,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Name Input
                          TextFormField(
                            controller: _nameController,
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
                            controller: _emailController,
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

                          // Phone Number Input (Added as requested!)
                          TextFormField(
                            controller: _phoneController,
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
                            controller: _messageController,
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
                    ),
                  ),
                ],
              ),
            ],
          );
        },
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
