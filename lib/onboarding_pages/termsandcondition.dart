
import 'package:ag_mortgage/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: depend_on_referenced_packages

// import '../Market_Place/Details_Page/models.dart';


class LunchTermsAndConditionsDialog extends StatelessWidget {
  // final Houseview? house;
  final bool? viewBtn;
  const LunchTermsAndConditionsDialog({
    Key? key,
    // this.house,
    this.viewBtn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms and Conditions'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const Center(
            //   child: Text(
            //     'Terms And Conditions',
            //     style: TextStyle(
            //       fontSize: 24,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            // ),
            const SizedBox(height: 20),
            const Text(
              'Effective Date: January 2025',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Welcome to KWIK by AGMB! These Terms and Conditions (“Terms”) explain how the KWIK platform works and the rules for using it. By signing up or using the platform, you agree to these Terms, so please read them carefully.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),
            const Text(
              'Key Highlights of KWIK by AGMB',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            _buildBulletPoint(
                'Save for a 30% down payment over 18 months and earn competitive interest.'),
            _buildBulletPoint(
                'Referral credits are added to your savings balance (not withdrawable as cash).'),
            _buildBulletPoint(
                'Missed payments result in program extensions and delayed loan eligibility.'),
            _buildBulletPoint(
                'Only properties in approved locations qualify for funding.'),
            _buildBulletPoint(
              'Diaspora Nigerians can participate but must consider remittance timelines, exchange rates, and refunds in Naira only.',
            ),
            const SizedBox(height: 20),
            const Text(
              '1. What is KWIK by AGMB?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'KWIK by AGMB is a digital platform for the KWIK Mortgage program. This program helps users gradually save for a 30% down payment over 18 months, instilling a strong savings culture and enabling them to meet mortgage requirements to purchase verified properties.\n\nPlease note that the KWIK platform is not a regular savings or current account. It has specific terms and is for people on a mission to own a home. Applicants are encouraged to read these Terms carefully and fully understand them before signing up.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),
            const Text(
              '2. Who Can Use KWIK by AGMB?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            _buildBulletPoint('Age: You must be at least 18 years old.'),
            _buildBulletPoint(
                'Residency: You can join if you live in Nigeria or are a Nigerian living abroad (diaspora Nigerians).'),
            _buildBulletPoint(
                'Verification: You need to provide valid ID, proof of address, and other documents during registration.'),
            const SizedBox(height: 10),
            const Text(
              'Special Terms for Diaspora Nigerians\n\nDiaspora Nigerians may face processing delays due to international remittance timelines or exchange rate fluctuations.\n\nAll deposits and refunds for diaspora users will be processed in Naira, and any exchange rate losses or remittance charges will be borne by the user.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),
            const Text(
              '3. How Does the KWIK Savings Plan Work?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              '3.1 Contractual and Voluntary Savings',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            _buildBulletPoint(
                'Contractual Savings: Mandatory monthly savings contributions made on each monthly anniversary date. These form the primary basis for building the 30% down payment.'),
            _buildBulletPoint(
                'Voluntary Savings: Optional savings made beyond the required contractual savings. Voluntary savings:'),
            _buildSubBulletPoint(
                'Are tracked separately from contractual savings.'),
            _buildSubBulletPoint(
                'Enhance the user’s financial profile and improve their chances of mortgage approval.'),
            const SizedBox(height: 20),
            const Text(
              '3.2 Monthly Deposits',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            _buildBulletPoint(
                'You’ll deposit money monthly toward your 30% down payment.'),
            _buildBulletPoint(
                'The first deposit is required when you sign up.'),
            const SizedBox(height: 20),
            const Text(
              '3.3 Interest Rates',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            _buildBulletPoint(
                'Months 1–5: You’ll earn 4% monthly interest on your savings.'),
            _buildBulletPoint(
                'After 6 Months: You’ll earn 6% monthly interest.'),
            const SizedBox(height: 20),
            const Text(
              '3.4 Withdrawal Rules',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            _buildBulletPoint(
                'First 6 Months: You can withdraw once, but there’s a 3% penalty, and it takes 48 hours to process.'),
            _buildBulletPoint(
                'After 6 Months: Withdrawals require 30 days’ notice and may incur penalties if they affect your program eligibility.'),
            const SizedBox(height: 20),
            const Text(
              '3.5 Missed Payments',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            _buildBulletPoint(
                'Users have a 7-day grace period to make up missed payments without penalties.'),
            _buildBulletPoint(
                'After the grace period, missing a payment will:'),
            _buildSubBulletPoint('Extend your savings plan by 3 months.'),
            _buildSubBulletPoint('Delay your loan eligibility by 1 month.'),
            const SizedBox(height: 20),
            const Text(
              '3.6 Exiting the Program',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'If you leave the program early:',
              style: TextStyle(fontSize: 14),
            ),
            _buildBulletPoint('You will lose all earned interest.'),
            _buildBulletPoint(
                'Submit a written request via the platform or email. The remaining balance, minus applicable penalties, will be processed and returned within 14 business days.'),
            const SizedBox(height: 20),
            const Text(
              '4. Property Selection Rules',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              '4.1 AGMB’s Marketplace',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            _buildBulletPoint(
                'You can choose from verified properties in AGMB’s Marketplace. These properties are high-quality, structurally sound, and have clear ownership records.'),
            const SizedBox(height: 20),
            const Text(
              '4.2 External Properties',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'If you want to buy a property outside AGMB’s Marketplace:',
              style: TextStyle(fontSize: 14),
            ),
            _buildBulletPoint(
                'The property must go through a verification process.'),
            _buildBulletPoint(
                'A non-refundable verification fee will be charged upfront before the process begins.'),
            _buildBulletPoint(
                'The fee amount will depend on the property’s location and complexity of verification.'),
            const SizedBox(height: 20),
            const Text(
              '4.3 Exceptional Locations Policy',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'To protect the bank, AGMB may restrict funding for properties in areas with low property values or high risks. Only properties in approved locations will be eligible for funding under the KWIK program.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),
            const Text(
              '5. Referral Program',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              '5.1 Who Can Refer?',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Both users in Nigeria and Nigerians in the diaspora can refer others to the program.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),
            const Text(
              '5.2 How the Program Works',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            _buildBulletPoint(
                'There’s no limit to how many people you can refer, as long as you follow the referral rules.'),
            _buildBulletPoint(
                'A referral is successful when the referred person:'),
            _buildSubBulletPoint('Signs up for the KWIK program.'),
            _buildSubBulletPoint(
                'Maintains six consecutive monthly savings and locks down their deposit for homeownership.'),
            const SizedBox(height: 20),
            const Text(
              '5.3 Definition of Lockdown',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Lockdown occurs when a referred person, after completing six consecutive monthly savings, formally signs to lock their savings for homeownership and continues with the KWIK program.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),
            const Text(
              '5.4 Referral Rewards',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            _buildBulletPoint(
                'Accumulation: Referral credits will be held in a referral wallet.'),
            _buildBulletPoint(
                'True Value: Referral credits are added to the beneficiary’s savings balance only after the referred person locks down their deposit.'),
            _buildBulletPoint(
                'Non-Withdrawal: Referral credits cannot be withdrawn as cash.'),
            _buildBulletPoint(
                'Ownership: Referral credits are tied to the beneficiary’s account and cannot be transferred.'),
            const SizedBox(height: 20),
            const Text(
              '6. Fees and Penalties',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              '6.1 Verification Fees for External Properties',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            _buildBulletPoint(
                'Charged upfront before the verification process begins.'),
            _buildBulletPoint('Non-refundable.'),
            const SizedBox(height: 20),
            const Text(
              '6.2 Penalties for Withdrawals and Missed Payments',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            _buildBulletPoint(
                'Early Withdrawals: During the first 6 months, withdrawals incur a 3% penalty.'),
            _buildBulletPoint('Missed Payments: Missing a payment will:'),
            _buildSubBulletPoint('Extend your savings plan by 3 months.'),
            _buildSubBulletPoint('Delay your loan eligibility by 1 month.'),
            const SizedBox(height: 20),
            const Text(
              '7. How to Use the KWIK Platform',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            _buildBulletPoint(
                'Use the platform to monitor your savings, build mortgage credibility, choose properties, and manage your mortgage application.'),
            _buildBulletPoint(
                'The platform will be updated regularly. Install updates to enjoy all features.'),
            _buildBulletPoint(
                'AGMB will communicate via SMS and email. Keep your contact details accurate.'),
            const SizedBox(height: 20),
            const Text(
              '8. Consequences for Non-Compliance with Lockdown Rules',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            _buildBulletPoint(
                'Failure to lock down savings after six consecutive monthly deposits may result in AGMB reclassifying the savings as voluntary savings.'),
            const SizedBox(height: 20),
            const Text(
              '9. Data Privacy',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            _buildBulletPoint(
                'AGMB may share user data with trusted third parties for property verification, credit checks, or regulatory compliance.'),
            _buildBulletPoint(
                'Third parties comply with strict data protection standards.'),
            const SizedBox(height: 20),
            const Text(
              '10. Dispute Resolution',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Disputes will first be addressed by AGMB’s customer service. Unresolved disputes will proceed to arbitration under Nigerian law.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),
            const Text(
              '11. Force Majeure',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'AGMB is not liable for delays caused by natural disasters, strikes, wars, pandemics, regulatory changes, or financial system disruptions.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),
            const Text(
              '12. Contact Us',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Email: support@agmbplc.com',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 10),
            const Text(
              'Phone: +234 (0) 800 AGMB KWIK',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Decline',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w600),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: baseColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, "/register");
                  },
                  child: const Text(
                    'Accept',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Row(
      children: [
        const Icon(Icons.circle, size: 6, color: Colors.black),
        const SizedBox(width: 8),
        Expanded(child: Text(text)),
      ],
    );
  }

  Widget _buildSubBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• '),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
