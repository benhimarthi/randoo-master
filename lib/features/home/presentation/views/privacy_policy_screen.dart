import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  static const routeName = '/privacy-policy';
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Privacy Policy for Randoo',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Last updated: December 9, 2025',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 16),
            Text(
              'Welcome to Randoo. We are committed to protecting your privacy. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our mobile application.',
            ),
            SizedBox(height: 16),
            _PolicySection(
              title: '1. Information We Collect',
              content:
                  'We may collect information about you in a variety of ways. The information we may collect on the Application includes:\n\n' 
                  'Personal Data: Personally identifiable information, such as your name and email address, that you voluntarily give to us when you register with the Application.\n\n' 
                  'User Content: We may collect information that you post, upload, or otherwise provide to the Application, such as service listings, reviews, and comments.',
            ),
            _PolicySection(
              title: '2. Use of Your Information',
              content:
                  'Having accurate information about you permits us to provide you with a smooth, efficient, and customized experience. Specifically, we may use information collected about you via the Application to:\n\n' 
                  '- Create and manage your account.\n' 
                  '- Email you regarding your account or order.\n' 
                  '- Enable user-to-user communications.\n' 
                  '- Monitor and analyze usage and trends to improve your experience with the Application.\n' 
                  '- Respond to your comments and questions and provide customer service.',
            ),
            _PolicySection(
              title: '3. Disclosure of Your Information',
              content:
                  'We do not share, sell, rent, or trade your information with any third parties for their commercial purposes.',
            ),
            _PolicySection(
              title: '4. Security of Your Information',
              content:
                  'We use administrative, technical, and physical security measures to help protect your personal information. While we have taken reasonable steps to secure the personal information you provide to us, please be aware that despite our efforts, no security measures are perfect or impenetrable, and no method of data transmission can be guaranteed against any interception or other type of misuse.',
            ),
            _PolicySection(
              title: '5. Contact Us',
              content:
                  'If you have questions or comments about this Privacy Policy, please contact us at: support@randoo.com',
            ),
          ],
        ),
      ),
    );
  }
}

class _PolicySection extends StatelessWidget {
  final String title;
  final String content;

  const _PolicySection({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(content),
        const SizedBox(height: 16),
      ],
    );
  }
}
