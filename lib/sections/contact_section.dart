import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../theme/app_theme.dart';
import '../widgets/content_wrapper.dart';
import '../widgets/interactive_link.dart';
import '../widgets/brand_icons.dart';
import '../widgets/scroll_reveal.dart';


class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _nameController = TextEditingController();
  final _contactController = TextEditingController();
  final _messageController = TextEditingController();

  String _selectedCategory = '💼 Job Opportunity';
  bool _isSubmitted = false;
  bool _isSending = false;

  final List<String> _categories = [
    '💼 Job Opportunity',
    '💡 Project Feedback',
    '☕ Say Hello',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _contactController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    final name = _nameController.text.trim();
    final email = _contactController.text.trim();
    final message = _messageController.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please enter your email so I can reply to you.',
            style: AppTypography.body(fontSize: 14, color: AppColors.primaryBtnText),
          ),
          backgroundColor: AppColors.accent,
          duration: const Duration(seconds: 3),
        ),
      );
      return;
    }

    final emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');
    if (!emailRegex.hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please enter a valid email address (e.g. name@example.com).',
            style: AppTypography.body(fontSize: 14, color: AppColors.primaryBtnText),
          ),
          backgroundColor: AppColors.accent,
          duration: const Duration(seconds: 3),
        ),
      );
      return;
    }

    if (message.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please enter a message before sending.',
            style: AppTypography.body(fontSize: 14, color: AppColors.primaryBtnText),
          ),
          backgroundColor: AppColors.accent,
          duration: const Duration(seconds: 3),
        ),
      );
      return;
    }

    setState(() => _isSending = true);

    try {
      final response = await http.post(
        Uri.parse('https://api.web3forms.com/submit'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'access_key': 'c3493259-1edf-4bc2-b2a2-c6515f40f0ce',
          'subject': '[$_selectedCategory] Message from ${name.isNotEmpty ? name : email}',
          'from_name': name.isNotEmpty ? '$name (via Portfolio)' : 'Portfolio Lead ($email)',
          'replyto': email,
          'Topic': _selectedCategory,
          'Sender Name': name.isNotEmpty ? name : 'Not specified',
          'Sender Email': email,
          'Message': message,
        }),
      );

      final data = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 200 && data['success'] == true) {
        if (mounted) {
          setState(() {
            _isSending = false;
            _isSubmitted = true;
          });
        }
      } else {
        throw Exception(data['message'] ?? 'Submission failed');
      }
    } catch (_) {
      if (mounted) {
        setState(() => _isSending = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Could not send automatically. Opening email client as backup...',
              style: AppTypography.body(fontSize: 14, color: AppColors.primaryBtnText),
            ),
            backgroundColor: AppColors.accent,
            duration: const Duration(seconds: 3),
          ),
        );
      }
      // Backup fallback to mailto
      final senderDisplay = name.isNotEmpty ? '$name ($email)' : email;
      final subject = Uri.encodeComponent('[$_selectedCategory] Portfolio Message from $senderDisplay');
      final body = Uri.encodeComponent(
        'Category: $_selectedCategory\n'
        'Name: ${name.isNotEmpty ? name : 'Not provided'}\n'
        'Reply-To: $email\n\n'
        'Message:\n$message\n\n---\nSent from Fares Elhabashy Portfolio',
      );
      openUrl('mailto:fareselhabashy7@gmail.com?subject=$subject&body=$body');
    }
  }

  void _sendWhatsApp() {
    final name = _nameController.text.trim();
    final email = _contactController.text.trim();
    final message = _messageController.text.trim();
    
    final senderDisplay = name.isNotEmpty ? (email.isNotEmpty ? '$name ($email)' : name) : (email.isNotEmpty ? email : 'Visitor');
    String text;
    if (message.isEmpty) {
      text = Uri.encodeComponent(
        'Hi Fares! I saw your Flutter portfolio and would like to connect.\n👤 From: $senderDisplay',
      );
    } else {
      text = Uri.encodeComponent(
        'Hi Fares! I visited your Flutter portfolio.\n\n'
        '📌 Topic: $_selectedCategory\n'
        '👤 From: $senderDisplay\n'
        '💬 Message: $message',
      );
    }

    // WhatsApp targeting Fares's direct phone number: +20 128 178 8394
    openUrl('https://wa.me/201281788394?text=$text');
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth <= AppDimensions.mobileBreakpoint;

    final infoColumn = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Let\'s talk about Flutter.',
          style: AppTypography.heading(
            fontSize: isMobile ? 30 : 36,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Text(
            'Currently looking for a junior Flutter or mobile developer role where I can keep learning from people more experienced than me. Feel free to reach out, download my resume, or leave your thoughts!',
            style: AppTypography.body(
              fontSize: 15.5,
              color: AppColors.muted,
              height: 1.6,
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Location Badge (No phone call button)
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.panel,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.line),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.location_on_outlined, size: 16, color: AppColors.accent),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  'El-Mahmoudia, El-Beheira, Egypt (Open to Remote / Hybrid)',
                  style: AppTypography.mono(fontSize: 12.5, color: AppColors.stackText),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),

        // Connect & Chat Cards Grid with Official Brand Logos
        Text(
          'Connect directly:',
          style: AppTypography.mono(fontSize: 12.5, color: AppColors.accent),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 10,
          children: [
            _buildDirectChannelCard(
              icon: (c) => BrandIcons.whatsapp(size: 20, color: c),
              title: 'WhatsApp',
              subtitle: '+20 128 178 8394',
              activeColor: const Color(0xFF25D366),
              onTap: () => openUrl('https://wa.me/201281788394?text=Hi%20Fares!%20I%20saw%20your%20Flutter%20portfolio.'),
            ),
            _buildDirectChannelCard(
              icon: (c) => BrandIcons.linkedin(size: 20, color: c),
              title: 'LinkedIn',
              subtitle: 'fares-elhabashy',
              activeColor: const Color(0xFF0A66C2),
              onTap: () => openUrl('https://www.linkedin.com/in/fares-elhabashy-484b31295/'),
            ),
            _buildDirectChannelCard(
              icon: (c) => BrandIcons.github(size: 20, color: c),
              title: 'GitHub',
              subtitle: 'FaresFady',
              activeColor: AppColors.text,
              onTap: () => openUrl('https://github.com/FaresFady'),
            ),
            _buildDirectChannelCard(
              icon: (c) => BrandIcons.email(size: 20, color: c),
              title: 'Email',
              subtitle: 'fareselhabashy7@gmail.com',
              activeColor: AppColors.accent,
              onTap: () => openUrl('mailto:fareselhabashy7@gmail.com'),
            ),
            _buildDirectChannelCard(
              icon: (c) => BrandIcons.facebook(size: 20, color: c),
              title: 'Facebook',
              subtitle: 'fares.elhabashy77',
              activeColor: const Color(0xFF1877F2),
              onTap: () => openUrl('https://www.facebook.com/fares.elhabashy77'),
            ),
            _buildDirectChannelCard(
              icon: (c) => BrandIcons.instagram(size: 20, color: c),
              title: 'Instagram',
              subtitle: '@fares_elhabashy',
              activeColor: const Color(0xFFE4405F),
              onTap: () => openUrl('https://www.instagram.com/fares_elhabashy/'),
            ),
          ],
        ),
      ],
    );

    final formCard = _buildFeedbackCard();

    return Container(
      padding: EdgeInsets.symmetric(vertical: isMobile ? 48 : 76),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.line, width: 1),
        ),
      ),
      child: ContentWrapper(
        child: isMobile
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ScrollReveal(
                    direction: RevealDirection.up,
                    child: infoColumn,
                  ),
                  const SizedBox(height: 40),
                  ScrollReveal(
                    direction: RevealDirection.up,
                    delayMs: 80,
                    child: formCard,
                  ),
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 11,
                    child: ScrollReveal(
                      direction: RevealDirection.left,
                      child: infoColumn,
                    ),
                  ),
                  const SizedBox(width: 48),
                  Expanded(
                    flex: 13,
                    child: ScrollReveal(
                      direction: RevealDirection.right,
                      delayMs: 100,
                      child: formCard,
                    ),
                  ),
                ],
              ),

      ),
    );
  }

  Widget _buildFeedbackCard() {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: AppColors.panel,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.line, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: AppColors.isDark ? 0.40 : 0.08),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: _isSubmitted ? _buildSuccessState() : _buildFormInputs(),
    );
  }

  Widget _buildSuccessState() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 16),
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: AppColors.success.withValues(alpha: 0.15),
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.success, width: 2),
          ),
          child: const Icon(Icons.check, color: AppColors.success, size: 30),
        ),
        const SizedBox(height: 20),
        Text(
          'Thank you for reaching out!',
          style: AppTypography.heading(fontSize: 22, fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Text(
          'Your message has been sent directly to Fares\'s Gmail! He will get back to you as soon as possible. You can also connect directly on WhatsApp.',
          style: AppTypography.body(fontSize: 14.5, color: AppColors.muted),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 12,
          runSpacing: 10,
          alignment: WrapAlignment.center,
          children: [
            PrimaryButton(
              text: 'Chat on WhatsApp 💬',
              icon: Icons.chat_outlined,
              onTap: _sendWhatsApp,
            ),
            GhostButton(
              text: 'Send Another Message',
              onTap: () {
                setState(() {
                  _nameController.clear();
                  _contactController.clear();
                  _messageController.clear();
                  _isSubmitted = false;
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildFormInputs() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                'Send a message / feedback',
                style: AppTypography.heading(
                  fontSize: 19,
                  fontWeight: FontWeight.w600,
                  color: AppColors.text,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Icon(Icons.mark_email_read_outlined, size: 20, color: AppColors.accent),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          'Have a job opening, a feedback on my projects, or want to connect?',
          style: AppTypography.body(fontSize: 13.5, color: AppColors.muted),
        ),
        const SizedBox(height: 20),

        // Category Pills
        Text(
          'Topic:',
          style: AppTypography.mono(fontSize: 12, color: AppColors.accent),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _categories.map((cat) {
            final isSelected = _selectedCategory == cat;
            return GestureDetector(
              onTap: () => setState(() => _selectedCategory = cat),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.accent.withValues(alpha: 0.18) : AppColors.inputBackground,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isSelected ? AppColors.accent : AppColors.line,
                    width: 1,
                  ),
                ),
                child: Text(
                  cat,
                  style: AppTypography.body(
                    fontSize: 12.5,
                    fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
                    color: isSelected ? AppColors.accent : AppColors.muted,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 18),

        // Name Field
        _buildTextField(
          controller: _nameController,
          label: 'Your Name (optional)',
          hint: 'e.g. Sarah Connor / Hiring Manager',
          icon: Icons.person_outline,
        ),
        const SizedBox(height: 14),

        // Email Field
        _buildTextField(
          controller: _contactController,
          label: 'Your Email *',
          hint: 'e.g. sarah@example.com',
          icon: Icons.alternate_email,
        ),
        const SizedBox(height: 14),

        // Message Field
        _buildTextField(
          controller: _messageController,
          label: 'Message / Feedback *',
          hint: 'Write your thoughts, feedback on my code, or project details...',
          icon: Icons.chat_bubble_outline,
          maxLines: 4,
        ),
        const SizedBox(height: 22),

        // Action Buttons
        Wrap(
          spacing: 12,
          runSpacing: 10,
          children: [
            PrimaryButton(
              text: _isSending ? 'Sending... ⏳' : 'Send Message ✉️',
              onTap: _isSending ? () {} : _sendMessage,
            ),
            GhostButton(
              text: 'Chat on WhatsApp 💬',
              onTap: _sendWhatsApp,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.mono(fontSize: 12, color: AppColors.muted),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          maxLines: maxLines,
          style: AppTypography.body(fontSize: 14.5, color: AppColors.text),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTypography.body(fontSize: 13.5, color: AppColors.muted.withValues(alpha: 0.5)),
            prefixIcon: maxLines == 1 ? Icon(icon, size: 18, color: AppColors.muted) : null,
            filled: true,
            fillColor: AppColors.inputBackground,
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.line),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.accent, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDirectChannelCard({
    required Widget Function(Color color) icon,
    required String title,
    required String subtitle,
    required Color activeColor,
    required VoidCallback onTap,
  }) {
    return _DirectChannelCard(
      icon: icon,
      title: title,
      subtitle: subtitle,
      activeColor: activeColor,
      onTap: onTap,
    );
  }
}

class _DirectChannelCard extends StatefulWidget {
  final Widget Function(Color color) icon;
  final String title;
  final String subtitle;
  final Color activeColor;
  final VoidCallback onTap;

  const _DirectChannelCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.activeColor,
    required this.onTap,
  });

  @override
  State<_DirectChannelCard> createState() => _DirectChannelCardState();
}

class _DirectChannelCardState extends State<_DirectChannelCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          transform: Matrix4.translationValues(0, _isHovered ? -2 : 0, 0),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.panel,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: _isHovered ? widget.activeColor : AppColors.line,
              width: 1.2,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: widget.activeColor.withValues(alpha: 0.20),
                      blurRadius: 12,
                      offset: const Offset(0, 3),
                    ),
                  ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 20,
                height: 20,
                child: Center(
                  child: widget.icon(_isHovered ? widget.activeColor : AppColors.muted),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.title,
                    style: AppTypography.body(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w600,
                      color: _isHovered ? widget.activeColor : AppColors.text,
                    ),
                  ),
                  Text(
                    widget.subtitle,
                    style: AppTypography.mono(
                      fontSize: 11,
                      color: AppColors.muted,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
