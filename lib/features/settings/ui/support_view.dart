// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:translators/core/helpers/spacing.dart';
import 'package:translators/core/theme/app_colors.dart';
import 'package:translators/core/theme/app_styles.dart';
import 'package:translators/core/widgets/app_snack_bar.dart';
import 'package:translators/core/widgets/custom_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportView extends StatefulWidget {
  const SupportView({super.key});

  @override
  State<SupportView> createState() => _SupportViewState();
}

class _SupportViewState extends State<SupportView>
    with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  // Loading states for each action
  final Map<String, bool> _loadingStates = {};

  // Performance constants
  static const Duration _animationDuration = Duration(milliseconds: 800);
  static const Duration _buttonAnimationDuration = Duration(milliseconds: 200);
  static const double _defaultBorderRadius = 12.0;
  static const double _defaultMargin = 16.0;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: _animationDuration,
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.2, 1.0, curve: Curves.easeOutCubic),
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _launchEmail() async {
    await _performAction('email', () async {
      final Uri emailUri = Uri(
        scheme: 'mailto',
        path: 'tarekahmedbelal@gmail.com',
        query: 'subject=Support Request&body=Hello, I need help with...',
      );

      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      } else {
        _showErrorSnackBar('Could not open email app');
      }
    });
  }

  Future<void> _launchCall() async {
    await _performAction('call', () async {
      final Uri callUri = Uri(scheme: 'tel', path: '+201271845331');

      if (await canLaunchUrl(callUri)) {
        await launchUrl(callUri);
      } else {
        _showErrorSnackBar('Could not open phone app');
      }
    });
  }

  Future<void> _launchWhatsApp() async {
    await _performAction('whatsapp', () async {
      final Uri whatsappUri = Uri.parse('https://wa.me/201271845331');

      if (await canLaunchUrl(whatsappUri)) {
        await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
      } else {
        _showErrorSnackBar('Could not open WhatsApp');
      }
    });
  }

  Future<void> _performAction(
      String action, Future<void> Function() actionCallback) async {
    if (_loadingStates[action] == true) return; // Prevent multiple taps

    setState(() {
      _loadingStates[action] = true;
    });

    try {
      await actionCallback();
    } catch (e) {
      _showErrorSnackBar('An error occurred. Please try again.');
    } finally {
      if (mounted) {
        setState(() {
          _loadingStates[action] = false;
        });
      }
    }
  }

  void _showErrorSnackBar(String message) {
    if (!mounted) return;

    AppSnackBar.showError(context: context, message: message);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const CustomAppBar(title: "Support"),
                      verticalSpacing(20),
                      _buildHeader(theme),
                      verticalSpacing(30),
                      _buildSupportButtons(theme),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Column(
      children: [
        Text(
          "Need Help?",
          style: AppTextStyles.headlineMedium.copyWith(
            color: theme.colorScheme.secondary,
          ),
        ),
        verticalSpacing(10),
        Text(
          "Contact us via Email, Phone, or WhatsApp.",
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.grey,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildSupportButtons(ThemeData theme) {
    return Column(
      children: [
        _buildSupportButton(
          Icons.email,
          "Email Support",
          _launchEmail,
          'email',
          theme,
        ),
        _buildSupportButton(
          Icons.call,
          "Call Support",
          _launchCall,
          'call',
          theme,
        ),
        _buildSupportButton(
          FontAwesomeIcons.whatsapp,
          "WhatsApp Support",
          _launchWhatsApp,
          'whatsapp',
          theme,
        ),
      ],
    );
  }

  Widget _buildSupportButton(
    IconData icon,
    String label,
    VoidCallback onTap,
    String actionKey,
    ThemeData theme,
  ) {
    final isLoading = _loadingStates[actionKey] ?? false;

    return AnimatedContainer(
      duration: _buttonAnimationDuration,
      curve: Curves.easeInOut,
      margin: EdgeInsets.symmetric(
        horizontal: _defaultMargin.w,
        vertical: 8.h,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onTap,
          borderRadius: BorderRadius.circular(_defaultBorderRadius),
          splashColor: theme.colorScheme.primary.withOpacity(0.1),
          highlightColor: theme.colorScheme.primary.withOpacity(0.05),
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 16.h,
              horizontal: _defaultMargin.w,
            ),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(_defaultBorderRadius),
              border: Border.all(
                color: theme.colorScheme.outline.withOpacity(0.2),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: theme.shadowColor.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                AnimatedSwitcher(
                  duration: _buttonAnimationDuration,
                  child: isLoading
                      ? SizedBox(
                          key: const ValueKey('loading'),
                          width: 24.w,
                          height: 24.w,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              theme.colorScheme.primary,
                            ),
                          ),
                        )
                      : Icon(
                          key: const ValueKey('icon'),
                          icon,
                          size: 28.w,
                          color: _getIconColor(icon, theme),
                        ),
                ),
                horizontalSpacing(16),
                Expanded(
                  child: Text(
                    label,
                    style: AppTextStyles.titleMedium.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ),
                if (!isLoading)
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 16.w,
                    color: theme.colorScheme.onSurface.withOpacity(0.5),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getIconColor(IconData icon, ThemeData theme) {
    if (icon == Icons.email) {
      return Colors.red;
    } else if (icon == Icons.call) {
      return Colors.green;
    } else if (icon == FontAwesomeIcons.whatsapp) {
      return const Color(0xFF25D366);
    }
    return theme.colorScheme.primary;
  }
}
