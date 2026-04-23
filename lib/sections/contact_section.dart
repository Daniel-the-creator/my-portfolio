import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';
import '../widgets/scroll_reveal.dart';

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

  void _sendMessage() async {
    if (_formKey.currentState!.validate()) {
      const String email = 'danielilesanmi04@gmail.com';
      final String name = _nameController.text;
      final String senderEmail = _emailController.text;
      final String message = _messageController.text;

      final String subject = 'New Portfolio Contact from $name';
      final String body = 'Sender Email: $senderEmail\n\nMessage:\n$message';

      final Uri mailtoUri = Uri(
        scheme: 'mailto',
        path: email,
        query:
            'subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}',
      );

      final Uri webMailUri = Uri.parse(
          'https://mail.google.com/mail/u/0/?view=cm&fs=1&tf=1&to=$email&su=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}');

      try {
        final bool launched =
            await launchUrl(mailtoUri, mode: LaunchMode.platformDefault);
        if (!launched) {
          await launchUrl(webMailUri, mode: LaunchMode.externalApplication);
        }
      } catch (e) {
        try {
          await launchUrl(webMailUri, mode: LaunchMode.externalApplication);
        } catch (e2) {
          debugPrint('Could not launch email client: $e2');
        }
      }
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
    final isMobile = MediaQuery.of(context).size.width < 800;

    return Container(
      constraints: const BoxConstraints(maxWidth: 700),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? AppSpacing.xl : AppSpacing.xxxl,
        vertical: AppSpacing.section,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ScrollReveal(
            key: const ValueKey('contact_header'),
            child: Column(
              children: [
                GradientText(
                  "04. What's Next?",
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.5,
                  ),
                  gradient: AppColors.primaryGradient,
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  'Get In Touch',
                  style: GoogleFonts.spaceGrotesk(
                    color: AppColors.textPrimary,
                    fontSize: isMobile ? 36 : 48,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -1,
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                Text(
                  "I'm actively seeking remote or freelance opportunities. "
                  "Feel free to reach out with any questions or project offers!",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: AppColors.textSecondary,
                    fontSize: 16,
                    height: 1.7,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xxxl),
          // Contact form
          ScrollReveal(
            key: const ValueKey('contact_form'),
            index: 1,
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.xxl),
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant.withOpacity(0.4),
                borderRadius: BorderRadius.circular(AppRadius.xl),
                border: Border.all(
                  color: AppColors.border.withOpacity(0.3),
                ),
              ),
              child: Form(
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
                      label: 'Message',
                      icon: Icons.message_outlined,
                      maxLines: 5,
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    SizedBox(
                      width: double.infinity,
                      child: PrimaryButton(
                        text: 'Send Message',
                        icon: Icons.send_rounded,
                        onPressed: _sendMessage,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xxxl),
          // Social links
          ScrollReveal(
            key: const ValueKey('contact_socials'),
            index: 2,
            child: Column(
              children: [
                // Info row
                Wrap(
                  spacing: AppSpacing.xxl,
                  runSpacing: AppSpacing.lg,
                  alignment: WrapAlignment.center,
                  children: [
                    _buildInfoChip(
                      Icons.phone_rounded,
                      '+234 704 567 8882',
                    ),
                    _buildInfoChip(
                      Icons.location_on_rounded,
                      'Ibadan, Nigeria',
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xl),
                // Social icons
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _SocialIcon(
                      icon: Icons.code_rounded,
                      url: 'https://github.com/Daniel-the-creator',
                      tooltip: 'GitHub',
                    ),
                    SizedBox(width: AppSpacing.lg),
                    _SocialIcon(
                      icon: Icons.work_outline_rounded,
                      url: 'https://linkedin.com',
                      tooltip: 'LinkedIn',
                    ),
                    SizedBox(width: AppSpacing.lg),
                    _SocialIcon(
                      icon: Icons.alternate_email_rounded,
                      url: 'https://twitter.com',
                      tooltip: 'Twitter / X',
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.huge),
          // Footer
          ScrollReveal(
            key: const ValueKey('footer'),
            index: 3,
            child: Column(
              children: [
                Container(
                  height: 1,
                  width: 120,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.border.withOpacity(0),
                        AppColors.border,
                        AppColors.border.withOpacity(0),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                Text(
                  'Designed & Built by Daniel Ilesanmi',
                  style: GoogleFonts.inter(
                    color: AppColors.textMuted,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.favorite_rounded,
                        color: Color(0xFFE040FB), size: 14),
                    const SizedBox(width: AppSpacing.xs),
                    Text(
                      'Built with Flutter',
                      style: GoogleFonts.inter(
                        color: AppColors.textMuted,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: AppColors.primary, size: 18),
        const SizedBox(width: AppSpacing.sm),
        Text(
          text,
          style: GoogleFonts.inter(
            color: AppColors.textSecondary,
            fontSize: 14,
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
      style: GoogleFonts.inter(color: AppColors.textPrimary, fontSize: 15),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Please enter your $label';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.inter(
          color: AppColors.textMuted,
          fontSize: 14,
        ),
        prefixIcon: Padding(
          padding: EdgeInsets.only(
            bottom: maxLines > 1 ? (maxLines * 14.0) - 20 : 0,
          ),
          child: Icon(icon, color: AppColors.primary, size: 20),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: BorderSide(
            color: AppColors.border.withOpacity(0.5),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(
            color: Colors.redAccent,
            width: 1.5,
          ),
        ),
        filled: true,
        fillColor: AppColors.surface.withOpacity(0.6),
      ),
    );
  }
}

class _SocialIcon extends StatefulWidget {
  final IconData icon;
  final String url;
  final String tooltip;

  const _SocialIcon({
    required this.icon,
    required this.url,
    required this.tooltip,
  });

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      cursor: SystemMouseCursors.click,
      child: Tooltip(
        message: widget.tooltip,
        child: GestureDetector(
          onTap: () async {
            try {
              await launchUrl(
                Uri.parse(widget.url),
                mode: LaunchMode.externalApplication,
              );
            } catch (_) {}
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: _isHovering
                  ? AppColors.primary.withOpacity(0.1)
                  : AppColors.surfaceVariant.withOpacity(0.5),
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(
                color: _isHovering
                    ? AppColors.primary.withOpacity(0.4)
                    : AppColors.border.withOpacity(0.3),
              ),
            ),
            child: Icon(
              widget.icon,
              color: _isHovering ? AppColors.primary : AppColors.textMuted,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}
