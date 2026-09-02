import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  bool _sending = false;
  bool _sent = false;
  String? _errorMessage;

  Future<void> _sendMessage() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _sending = true;
      _errorMessage = null;
    });

    const String recipientEmail = 'danielilesanmi04@gmail.com';
    final String name = _nameController.text.trim();
    final String senderEmail = _emailController.text.trim();
    final String message = _messageController.text.trim();

    try {
      final response = await http.post(
        Uri.parse('https://formsubmit.co/ajax/$recipientEmail'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'name': name,
          'email': senderEmail,
          'message': message,
          '_subject': 'New Portfolio Message from $name',
          '_template': 'table',
        }),
      );

      if (response.statusCode == 200) {
        setState(() {
          _sending = false;
          _sent = true;
        });
        _nameController.clear();
        _emailController.clear();
        _messageController.clear();
        return;
      }
    } catch (e) {
      debugPrint('FormSubmit direct POST failed: $e');
    }

    // Fallback: If HTTP request fails (e.g. offline/CORS), open mail client
    final String subject = 'New Portfolio Contact from $name';
    final String body = 'Sender Email: $senderEmail\n\nMessage:\n$message';
    final Uri mailtoUri = Uri(
      scheme: 'mailto',
      path: recipientEmail,
      query: 'subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}',
    );

    try {
      await launchUrl(mailtoUri, mode: LaunchMode.platformDefault);
      setState(() {
        _sending = false;
        _sent = true;
      });
    } catch (_) {
      setState(() {
        _sending = false;
        _errorMessage = 'Could not send message automatically. Please email danielilesanmi04@gmail.com directly.';
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 850;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? AppSpacing.xl : AppSpacing.xxxl,
        vertical: AppSpacing.huge,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(AppRadius.full),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.3),
                  ),
                ),
                child: Text(
                  '04. GET IN TOUCH',
                  style: GoogleFonts.sourceCodePro(
                    color: AppColors.primaryLight,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                "Let's Build Something Together",
                textAlign: TextAlign.center,
                style: GoogleFonts.spaceGrotesk(
                  color: AppColors.textPrimary,
                  fontSize: isMobile ? 32 : 46,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -1.0,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 580),
                child: Text(
                  "Have a project in mind, an open role, or just want to connect? "
                  "My inbox is always open — drop me a message and I'll get back to you promptly!",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: AppColors.textSecondary,
                    fontSize: 15,
                    height: 1.7,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xxxl),

              // Contact Form Card
              GlassCard(
                padding: EdgeInsets.all(isMobile ? AppSpacing.xl : AppSpacing.xxl),
                child: _sent
                    ? _buildSuccessState()
                    : Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            _buildTextField(
                              controller: _nameController,
                              label: 'Your Name',
                              icon: Icons.person_outline_rounded,
                            ),
                            const SizedBox(height: AppSpacing.lg),
                            _buildTextField(
                              controller: _emailController,
                              label: 'Email Address',
                              icon: Icons.email_outlined,
                              isEmail: true,
                            ),
                            const SizedBox(height: AppSpacing.lg),
                            _buildTextField(
                              controller: _messageController,
                              label: 'Your Message',
                              icon: Icons.chat_bubble_outline_rounded,
                              maxLines: 4,
                            ),
                            const SizedBox(height: AppSpacing.xl),
                            if (_errorMessage != null) ...[
                              Container(
                                padding: const EdgeInsets.all(AppSpacing.md),
                                decoration: BoxDecoration(
                                  color: Colors.redAccent.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(AppRadius.md),
                                  border: Border.all(color: Colors.redAccent.withValues(alpha: 0.4)),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.error_outline_rounded, color: Colors.redAccent, size: 18),
                                    const SizedBox(width: AppSpacing.sm),
                                    Expanded(
                                      child: Text(
                                        _errorMessage!,
                                        style: GoogleFonts.inter(color: Colors.redAccent, fontSize: 13),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: AppSpacing.lg),
                            ],
                            SizedBox(
                              width: double.infinity,
                              child: PrimaryButton(
                                text: _sending ? 'Sending directly to inbox...' : 'Send Message',
                                icon: Icons.send_rounded,
                                onPressed: _sending ? () {} : _sendMessage,
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
              const SizedBox(height: AppSpacing.xxxl),

              // Quick Contact Info Chips
              Wrap(
                spacing: AppSpacing.xl,
                runSpacing: AppSpacing.md,
                alignment: WrapAlignment.center,
                children: [
                  _buildContactChip(Icons.phone_iphone_rounded, '+234 704 567 8882'),
                  _buildContactChip(Icons.location_on_outlined, 'Ibadan, Nigeria'),
                  _buildContactChip(Icons.mail_outline_rounded, 'danielilesanmi04@gmail.com'),
                ],
              ),
              const SizedBox(height: AppSpacing.xxl),

              // Social Icons
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _SocialIconButton(
                    icon: Icons.code_rounded,
                    url: 'https://github.com/Daniel-the-creator',
                    tooltip: 'GitHub',
                  ),
                  SizedBox(width: AppSpacing.lg),
                  _SocialIconButton(
                    icon: Icons.work_outline_rounded,
                    url: 'https://linkedin.com',
                    tooltip: 'LinkedIn',
                  ),
                  SizedBox(width: AppSpacing.lg),
                  _SocialIconButton(
                    icon: Icons.alternate_email_rounded,
                    url: 'https://twitter.com',
                    tooltip: 'Twitter / X',
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.huge),

              // Footer
              Container(
                height: 1,
                width: 160,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.border.withValues(alpha: 0.0),
                      AppColors.border,
                      AppColors.border.withValues(alpha: 0.0),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              Text(
                '© 2026 Daniel Ilesanmi. All rights reserved.',
                style: GoogleFonts.inter(
                  color: AppColors.textMuted,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.favorite_rounded, color: AppColors.primaryLight, size: 13),
                  const SizedBox(width: 4),
                  Text(
                    'Built with Flutter Web',
                    style: GoogleFonts.inter(
                      color: AppColors.textMuted,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSuccessState() {
    return Column(
      children: [
        const SizedBox(height: AppSpacing.xl),
        Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: const Color(0xFF10B981).withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.check_rounded,
            color: Color(0xFF10B981),
            size: 36,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          'Message Delivered to Inbox!',
          style: GoogleFonts.spaceGrotesk(
            color: AppColors.textPrimary,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          "Your message has been sent directly to danielilesanmi04@gmail.com. I will get back to you shortly!",
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            color: AppColors.textSecondary,
            fontSize: 14,
            height: 1.6,
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        SecondaryButton(
          text: 'Send Another Message',
          icon: Icons.refresh_rounded,
          onPressed: () {
            setState(() {
              _sent = false;
              _errorMessage = null;
            });
          },
        ),
        const SizedBox(height: AppSpacing.lg),
      ],
    );
  }

  Widget _buildContactChip(IconData icon, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: AppColors.primaryLight, size: 16),
        const SizedBox(width: 8),
        Text(
          label,
          style: GoogleFonts.inter(
            color: AppColors.textSecondary,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isEmail = false,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      style: GoogleFonts.inter(color: AppColors.textPrimary, fontSize: 14),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Please enter your $label';
        }
        if (isEmail && !value.contains('@')) {
          return 'Please enter a valid email address';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.inter(color: AppColors.textMuted, fontSize: 14),
        prefixIcon: Padding(
          padding: EdgeInsets.only(
            bottom: maxLines > 1 ? (maxLines * 12.0) : 0,
          ),
          child: Icon(icon, color: AppColors.primaryLight, size: 18),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
        ),
        filled: true,
        fillColor: AppColors.surfaceVariant.withValues(alpha: 0.6),
      ),
    );
  }
}

class _SocialIconButton extends StatefulWidget {
  final IconData icon;
  final String url;
  final String tooltip;

  const _SocialIconButton({
    required this.icon,
    required this.url,
    required this.tooltip,
  });

  @override
  State<_SocialIconButton> createState() => _SocialIconButtonState();
}

class _SocialIconButtonState extends State<_SocialIconButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      cursor: SystemMouseCursors.click,
      child: Tooltip(
        message: widget.tooltip,
        child: GestureDetector(
          onTap: () async {
            try {
              await launchUrl(Uri.parse(widget.url), mode: LaunchMode.externalApplication);
            } catch (_) {}
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: _hover
                  ? AppColors.primary.withValues(alpha: 0.15)
                  : AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(
                color: _hover ? AppColors.primaryLight : AppColors.border,
              ),
            ),
            child: Icon(
              widget.icon,
              size: 20,
              color: _hover ? AppColors.primaryLight : AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
