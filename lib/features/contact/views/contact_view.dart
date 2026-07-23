import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/responsive/responsive_breakpoints.dart';
import '../../../core/theme/app_spacing.dart';
import '../viewmodels/contact_viewmodel.dart';
import '../widgets/contact_form_fields.dart';
import '../widgets/contact_header.dart';
import '../widgets/contact_left_content.dart';
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
      } else if (!success && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              viewModel.errorMessage ??
                  'Failed to send message. Please try again.',
            ),
            backgroundColor: Colors.redAccent,
          ),
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
              // Top Red Line Accent & Contacts Header
              const ContactHeader(),
              const SizedBox(height: 48),

              // 2-Column Main Section (Headline + Professional Contact Info on Left, Minimal Underline Form + Submit Button on Right)
              Flex(
                direction: isMobile ? Axis.vertical : Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left Column: Headline + Elegant Contact Info Rows
                  Expanded(
                    flex: isMobile ? 0 : 5,
                    child: ContactLeftContent(
                      isMobile: isMobile,
                    ),
                  ),

                  if (isMobile)
                    const SizedBox(height: 48)
                  else
                    const SizedBox(width: 80),

                  // Right Column: Underline Form Fields (Name, Email, Phone Number, Message) + Submit Button below
                  Expanded(
                    flex: isMobile ? 0 : 7,
                    child: ContactFormFields(
                      formKey: _formKey,
                      nameController: _nameController,
                      emailController: _emailController,
                      phoneController: _phoneController,
                      messageController: _messageController,
                      isSubmitting: viewModel.isSubmitting,
                      onSubmit: () => _submitForm(context, viewModel),
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
}
