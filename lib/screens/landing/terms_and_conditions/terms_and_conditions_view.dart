import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../values/insets.dart';
import 'terms_and_conditions_controller.dart';

/// View for the [HomeRoute].
///
/// Presents a series of [Card]s that showcase software developed by Splendid Endeavors.
class TermsAndConditionsView extends StatelessWidget {
  final TermsAndConditionsController state;

  const TermsAndConditionsView(this.state, {Key? key}) : super(key: key);

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
                style: GoogleFonts.mavenPro().copyWith(
                  fontSize: 16.0,
                  color: Theme.of(context).primaryColorDark,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Terms and Conditions for HerdGPT by Splendid Endeavors\n\n',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                  ),
                  TextSpan(
                    text: '1. Acceptance of Terms:\n',
                    style: GoogleFonts.mavenPro().copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const TextSpan(
                    text:
                        'By using HerdGPT\'s website and services, you agree to be bound by these terms and conditions. If you do not agree to these terms and conditions, you should not use the HerdGPT website or services.\n\n',
                  ),
                  TextSpan(
                    text: '2. Use of HerdGPT\'s Services:\n',
                    style: GoogleFonts.mavenPro().copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const TextSpan(
                    text:
                        'HerdGPT offers users the ability to create a "team" of Large Language Model AI assistants that work together to solve problems. Users may create teams and use them to solve problems, but must comply with the following guidelines:\n\n',
                  ),
                  const TextSpan(
                    text:
                        '• Users may not use the HerdGPT website or services for any illegal or unauthorized purpose.\n\n',
                  ),
                  const TextSpan(
                    text:
                        '• Users may not interfere with or disrupt the HerdGPT website or services, or servers or networks connected to the HerdGPT website or services.\n\n',
                  ),
                  const TextSpan(
                    text:
                        '• Users may not attempt to gain unauthorized access to the HerdGPT website or services, other users\' accounts, or other systems or networks connected to the HerdGPT website or services.\n\n',
                  ),
                  TextSpan(
                    text: '3. Ownership and Copyright:\n',
                    style: GoogleFonts.mavenPro().copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const TextSpan(
                    text:
                        'All content on the HerdGPT website, including text, graphics, logos, images, and software, is the property of HerdGPT or its licensors and is protected by copyright and other intellectual property laws. Users may not copy, modify, distribute, or reproduce any content from the HerdGPT website without prior written permission from HerdGPT.\n\n',
                  ),
                  const TextSpan(
                    text:
                        'However, please note that HerdGPT does not claim copyright ownership over any content generated by the AI assistants used by website visitors. Such content is the property of the respective user who created it using the HerdGPT website and services. Users retain ownership of the content they generate through the HerdGPT website and services.\n',
                  ),
                  TextSpan(
                    text: '4. Misuse of the Service:\n',
                    style: GoogleFonts.mavenPro().copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const TextSpan(
                    text:
                        'HerdGPT takes misuse of its services seriously. Users are prohibited from using the HerdGPT website or services in any way that violates these terms and conditions, or any applicable laws or regulations. Prohibited activities include, but are not limited to:\n',
                  ),
                  const TextSpan(
                    text: '• Using the HerdGPT website or services to engage in spamming or phishing activities.\n\n',
                  ),
                  const TextSpan(
                    text:
                        '• Using the HerdGPT website or services to distribute malware, viruses, or other harmful software.\n\n',
                  ),
                  const TextSpan(
                    text: '• Using the HerdGPT website or services to harass, intimidate, or threaten others.\n\n',
                  ),
                  const TextSpan(
                    text: '• Using the HerdGPT website or services to engage in fraudulent or illegal activities.\n\n',
                  ),
                  TextSpan(
                    text: '5. Termination of Service:\n',
                    style: GoogleFonts.mavenPro().copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const TextSpan(
                    text:
                        'HerdGPT reserves the right to terminate any user\'s access to the HerdGPT website or services at any time, for any reason, without notice. HerdGPT may also remove any user-generated content from the HerdGPT website or services at any time, for any reason, without notice.\n\n',
                  ),
                  TextSpan(
                    text: '6. Limitation of Liability:\n',
                    style: GoogleFonts.mavenPro().copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const TextSpan(
                    text:
                        'HerdGPT is not liable for any damages, including but not limited to direct, indirect, incidental, consequential, or punitive damages, arising out of or in connection with the use of the HerdGPT website or services. HerdGPT is not liable for any loss of data or information resulting from the use of the HerdGPT website or services.\n\n',
                  ),
                  TextSpan(
                    text: '7. Changes to Terms and Conditions:\n',
                    style: GoogleFonts.mavenPro().copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const TextSpan(
                    text:
                        'HerdGPT reserves the right to change these terms and conditions at any time, without notice. Users are responsible for reviewing these terms and conditions periodically to ensure they are aware of any changes.\n\n',
                  ),
                  TextSpan(
                    text: '8. Governing Law and Jurisdiction:\n',
                    style: GoogleFonts.mavenPro().copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const TextSpan(
                    text:
                        'These terms and conditions are governed by and construed in accordance with the laws of the state of California, United States. Any disputes arising out of or in connection with these terms and conditions will be subject to the exclusive jurisdiction of the courts located in Dane County, Wisconsin.\n\n\n',
                  ),
                  const TextSpan(
                    text:
                        'By using the HerdGPT website and services, you acknowledge that you have read, understood, and agree to these terms and conditions, including the disclaimer regarding the ownership of content generated by the AI assistants used by website visitors. If you do not agree to these terms and conditions, please do not use the HerdGPT website or services. If you have any questions or concerns about these terms and conditions, please contact us at hello@splendidendeavors.com.',
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
