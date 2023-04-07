import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../values/insets.dart';
import 'privacy_policy_controller.dart';

/// View for the [PrivacyPolicyRoute].
///
/// Presents a series of [Card]s that showcase software developed by Splendid Endeavors.
class PrivacyPolicyView extends StatelessWidget {
  final PrivacyPolicyController state;

  const PrivacyPolicyView(this.state, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).primaryColorDark,
          ),
          onPressed: state.onBackPressed,
        ),
        backgroundColor: Theme.of(context).primaryColorLight,
        title: Text(
          AppLocalizations.of(context).siteTitle,
          style: GoogleFonts.mavenPro().copyWith(
            color: Theme.of(context).primaryColorDark,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColorLight,
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context).primaryColorDark,
                width: 2.0,
              ),
              top: BorderSide(
                color: Theme.of(context).primaryColorDark,
                width: 3.0,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(
              insetsLarge,
            ),
            child: SelectableText.rich(
              TextSpan(
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 16.0,
                  color: Theme.of(context).primaryColorDark,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Privacy Policy for HerdGPT by Splendid Endeavors\n\n',
                    style: GoogleFonts.mavenPro().copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  const TextSpan(
                    text:
                        'Splendid Endeavors is committed to protecting the privacy of its clients and users. This privacy policy describes how we collect, use, and disclose personal information in connection with our services.\n\n',
                  ),
                  TextSpan(
                    text: '1. Personal Information We Collect:\n',
                    style: GoogleFonts.mavenPro().copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const TextSpan(
                    text:
                        'We may collect personal information such as your name, email address, phone number, and company information when you submit an inquiry or sign up for our services. We may also collect usage data, such as IP address, browser type, and pages visited, to improve our services and website.\n\n',
                  ),
                  TextSpan(
                    text: '2. How We Use Your Personal Information:\n',
                    style: GoogleFonts.mavenPro().copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const TextSpan(
                    text:
                        'We use your personal information to provide you with our services, communicate with you about your account or services, and improve our services and website. We may also use your personal information for marketing purposes, but you can opt-out of these communications at any time.\n\n',
                  ),
                  TextSpan(
                    text: '3. How We Disclose Your Personal Information:\n',
                    style: GoogleFonts.mavenPro().copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const TextSpan(
                    text:
                        'We may disclose your personal information to our third-party service providers who help us provide our services, such as hosting and payment processing. We may also disclose your personal information to comply with legal obligations, protect our rights or property, or enforce our agreements.\n\n',
                  ),
                  TextSpan(
                    text: '4. Security of Your Personal Information:\n',
                    style: GoogleFonts.mavenPro().copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const TextSpan(
                    text:
                        'We take reasonable steps to protect your personal information from unauthorized access, disclosure, or misuse. However, no method of transmission over the Internet or electronic storage is 100% secure.\n\n',
                  ),
                  TextSpan(
                    text: '5. Retention of Your Personal Information:\n',
                    style: GoogleFonts.mavenPro().copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const TextSpan(
                    text:
                        'We will retain your personal information for as long as necessary to provide you with our services and comply with our legal obligations.\n\n',
                  ),
                  TextSpan(
                    text: '6. Your Rights and Choices:\n',
                    style: GoogleFonts.mavenPro().copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const TextSpan(
                    text:
                        'You have the right to access, correct, or delete your personal information. You may also object to or restrict the processing of your personal information. Please contact us using the information below to exercise these rights.\n\n',
                  ),
                  TextSpan(
                    text: '7. Children\'s Privacy:\n',
                    style: GoogleFonts.mavenPro().copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const TextSpan(
                    text:
                        'Our services are not directed to individuals under the age of 18. We do not knowingly collect personal information from children.\n\n',
                  ),
                  TextSpan(
                    text: '8. Changes to Our Privacy Policy:\n',
                    style: GoogleFonts.mavenPro().copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const TextSpan(
                    text:
                        'We may update our privacy policy from time to time. We will provide notice of any material changes to this policy.\n\n',
                  ),
                  TextSpan(
                    text: '9. Contact Us:\n',
                    style: GoogleFonts.mavenPro().copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const TextSpan(
                    text:
                        'If you have any questions or concerns about our privacy policy, please contact us at legal@splendidendeavors.com.\n\n',
                  ),
                  const TextSpan(
                    text:
                        'By using our services, you consent to the collection, use, and disclosure of your personal information as described in this privacy policy.\n\n',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
