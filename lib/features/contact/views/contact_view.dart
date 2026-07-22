import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/responsive/responsive_breakpoints.dart';
import '../../../core/services/url_launcher_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../widgets/buttons/primary_button.dart';
import '../../../widgets/cards/glass_card.dart';
import '../../../widgets/typography/section_header.dart';
import '../viewmodels/contact_viewmodel.dart';
import '../widgets/contact_info_card.dart';
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
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.isMobile(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? AppSpacing.md : AppSpacing.xl,
        vertical: AppSpacing.xxl,
      ),
      child: Consumer<ContactViewModel>(
        builder: (context, viewModel, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(
                title: 'Contacts',
              ),
              const SizedBox(height: AppSpacing.xl),
              Flex(
                direction: isMobile ? Axis.vertical : Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left Column: Heading + Direct Contact info (exact reference image layout)
                  Expanded(
                    flex: isMobile ? 0 : 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Have a project?\nLet\'s talk!',
                          style: (isMobile
                                  ? AppTypography.displayMedium(color: Colors.white)
                                  : AppTypography.displayLarge(color: Colors.white))
                              .copyWith(
                            fontWeight: FontWeight.w800,
                            height: 1.15,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xl),
                        ContactInfoCard(
                          icon: Icons.email_rounded,
                          title: 'Email Direct',
                          value: AppConstants.email,
                          onTap: () => UrlLauncherService.openEmail(AppConstants.email),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        ContactInfoCard(
                          icon: FontAwesomeIcons.linkedin,
                          title: 'LinkedIn',
                          value: 'in/sreerag-dev',
                          onTap: () => UrlLauncherService.openUrl(AppConstants.linkedinUrl),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        ContactInfoCard(
                          icon: FontAwesomeIcons.github,
                          title: 'GitHub',
                          value: 'github.com/sreerag-dev',
                          onTap: () => UrlLauncherService.openUrl(AppConstants.githubUrl),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        ContactInfoCard(
                          icon: FontAwesomeIcons.whatsapp,
                          title: 'WhatsApp',
                          value: AppConstants.phone,
                          onTap: () => UrlLauncherService.openUrl(AppConstants.whatsappUrl),
                        ),
                      ],
                    ),
                  ),

                  if (isMobile) const SizedBox(height: AppSpacing.xl) else const SizedBox(width: AppSpacing.xxl),

                  // Right Column: Minimal Modern Contact Form (exact reference image inputs)
                  Expanded(
                    flex: isMobile ? 0 : 7,
                    child: GlassCard(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Send a Message',
                              style: AppTypography.titleLarge(),
                            ),
                            const SizedBox(height: AppSpacing.lg),

                            // Name Input
                            TextFormField(
                              controller: _nameController,
                              style: const TextStyle(color: Colors.white),
                              decoration: _buildInputDecoration('Name', Icons.person_outline_rounded),
                              validator: (val) {
                                if (val == null || val.trim().isEmpty) {
                                  return 'Please enter your name';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: AppSpacing.md),

                            // Email Input
                            TextFormField(
                              controller: _emailController,
                              style: const TextStyle(color: Colors.white),
                              decoration: _buildInputDecoration('Email', Icons.mail_outline_rounded),
                              keyboardType: TextInputType.emailAddress,
                              validator: (val) {
                                if (val == null || val.trim().isEmpty) {
                                  return 'Please enter your email';
                                }
                                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(val.trim())) {
                                  return 'Please enter a valid email address';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: AppSpacing.md),

                            // Message Input
                            TextFormField(
                              controller: _messageController,
                              maxLines: 5,
                              style: const TextStyle(color: Colors.white),
                              decoration: _buildInputDecoration('Message', Icons.message_outlined),
                              validator: (val) {
                                if (val == null || val.trim().isEmpty) {
                                  return 'Please enter your message';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: AppSpacing.xl),

                            PrimaryButton(
                              text: 'Submit',
                              icon: Icons.send_rounded,
                              isLoading: viewModel.isSubmitting,
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  final success = await viewModel.submitForm(
                                    name: _nameController.text.trim(),
                                    email: _emailController.text.trim(),
                                    subject: 'Portfolio Inquiry',
                                    message: _messageController.text.trim(),
                                  );
                                  if (success && context.mounted) {
                                    _nameController.clear();
                                    _emailController.clear();
                                    _messageController.clear();
                                    showDialog(
                                      context: context,
                                      builder: (context) => const ContactSuccessDialog(),
                                    );
                                  }
                                }
                              },
                            ),
                          ],
                        ),
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

  InputDecoration _buildInputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: AppTypography.bodyMedium(color: AppColors.textSecondary),
      prefixIcon: Icon(icon, color: AppColors.textMuted, size: 20),
      filled: true,
      fillColor: AppColors.surfaceElevated,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: AppRadius.borderMd,
        borderSide: const BorderSide(color: AppColors.surfaceBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: AppRadius.borderMd,
        borderSide: const BorderSide(color: AppColors.surfaceBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: AppRadius.borderMd,
        borderSide: const BorderSide(color: AppColors.dotAccent, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: AppRadius.borderMd,
        borderSide: const BorderSide(color: AppColors.error),
      ),
    );
  }
}
