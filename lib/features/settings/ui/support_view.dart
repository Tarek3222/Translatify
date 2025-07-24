// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:translators/core/helpers/spacing.dart';
import 'package:translators/core/theme/app_colors.dart';
import 'package:translators/core/theme/app_styles.dart';
import 'package:translators/core/widgets/custom_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportView extends StatelessWidget {
  const SupportView({super.key});

  Future<void> _launchEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'tarekahmedbelal@gmail.com',
      query: 'subject=Support Request&body=Hello, I need help with...',
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }

  Future<void> _launchCall() async {
    final Uri callUri =
        Uri(scheme: 'tel', path: '+201271845331'); // Change number
    if (await canLaunchUrl(callUri)) {
      await launchUrl(callUri);
    }
  }

  Future<void> _launchWhatsApp() async {
    final Uri whatsappUri = Uri.parse('https://wa.me/201271845331');
    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CustomAppBar(title: "Support"),
              verticalSpacing(20),
              Lottie.asset(
                'assets/images/support.json', // Add your Lottie file in assets
                height: 180.h,
              ),
              verticalSpacing(20),
              Text(
                "Need Help?",
                style: getBoldStyle(
                  fontSize: 24,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              verticalSpacing(10),
              Text(
                "Contact us via Email, Phone, or WhatsApp.",
                style: getRegularStyle(
                  fontSize: 14,
                  color: AppColors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              verticalSpacing(30),
              // ✅ Support Buttons
              _buildSupportButton(
                  Icons.email, "Email Support", _launchEmail, context),
              _buildSupportButton(
                  Icons.call, "Call Support", _launchCall, context),
              _buildSupportButton(FontAwesomeIcons.whatsapp, "WhatsApp Support",
                  _launchWhatsApp, context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSupportButton(
      IconData icon, String label, VoidCallback onTap, BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: Colors.blueAccent.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, size: 28.w, color: Colors.blueAccent),
            horizontalSpacing(16),
            Text(
              label,
              style: getMediumStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
