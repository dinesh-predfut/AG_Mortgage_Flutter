import 'package:flutter/material.dart';
import 'package:ag_mortgage/const/image.dart'; // Import Images class.
import 'package:ag_mortgage/onboarding_pages/termsandcondition.dart';
void main() {
  runApp(const LandingScreen());
}

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnboardingScreen(),
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Widget> _pages = [
    const OnboardingPage(
      title: "Mortgages",
      description:
          "Make your consistent saving habits a part of your collateral! Save consistently over 18 months and build your own payment to qualify for an instant mortgage. Start your homeownership journey today!",
      imagePath: Images.keyIcon,
    ),
    const OnboardingPage(
      title: "Rent to Own",
      description:
          "With a minimum of 40% down payment in an interest-bearing account, move into your dream property within 30 days and convert to a mortgage in 12 months. T&Cs apply.",
      imagePath: Images.rendtoHome,
    ),
    const OnboardingPage(
      title: "Construction Finance",
      description:
          "Are you stuck halfway through your home construction? Unlock the funds you need to complete your project and bring your dream home to life. T&Cs apply.",
      imagePath: Images.constraction,
    ),
    const OnboardingPage(
      title: "Investment",
      description:
          "Invest in high-growth real estate opportunities starting from just ₦500,000. Build your wealth with secure, property-backed returns. T&Cs apply.",
      imagePath: Images.investment,
    ),
  ];

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Termsandcondition(),)
      ); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: _pages,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: () {
                    _pageController.jumpToPage(_pages.length - 1);
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(width: 1.0, color: Colors.deepPurple),
                  ),
                  child: const Text(
                    "Skip",
                    style: TextStyle(color: Colors.deepPurple),
                  ),
                ),
                ElevatedButton(
                
                  onPressed: _nextPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                  
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      
                      
                    ),
                    minimumSize: const Size(200, 50),
                  ),
                  
                  child: Text(
                    _currentPage == _pages.length - 1 ? "Get Started" : "Next",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;

  const OnboardingPage({
    required this.title,
    required this.description,
    required this.imagePath,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imagePath, height: 100, fit: BoxFit.contain),
          const SizedBox(height: 30),
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Welcome to the App!"),
      ),
    );
  }
}
