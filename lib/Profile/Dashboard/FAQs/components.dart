import 'package:ag_mortgage/Profile/Dashboard/component.dart';
import 'package:flutter/material.dart';

class FAQPage extends StatefulWidget {
  const FAQPage({super.key});

  @override
  _FAQPageState createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabs = [
    'Mortgage',
    'Rent to Own',
    'Construction Finance',
    'Investment',
  ];
  final Color _activeColor = Colors.orange;
  final Color _inactiveColor = Colors.grey;

  List<Map<String, String>> _faqs = [];
  List<bool> _isExpanded = [];
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _answerController = TextEditingController();
@override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(() {
      setState(() {}); // Refresh UI when tab changes
    });
    _faqs = [
      {
        'question': 'What is Mortgage?',
        'answer':
            'It is a legal agreement by which a bank or building society lends money at interest and gives them the right to take your property if you don’t repay the money you’ve borrowed.'
      },
      {
        'question': 'What is Rent to Own?',
        'answer':
            'Rent to Own is a system where tenants rent a property with the option to purchase later.'
      },
      {
        'question': 'What is Mortgage?',
        'answer':
            'It is a legal agreement by which a bank or building society lends money at interest and gives them the right to take your property if you don’t repay the money you’ve borrowed.'
      },
      {
        'question': 'What is Rent to Own?',
        'answer':
            'Rent to Own is a system where tenants rent a property with the option to purchase later.'
      },
      {
        'question': 'What is Mortgage?',
        'answer':
            'It is a legal agreement by which a bank or building society lends money at interest and gives them the right to take your property if you don’t repay the money you’ve borrowed.'
      },
      {
        'question': 'What is Rent to Own?',
        'answer':
            'Rent to Own is a system where tenants rent a property with the option to purchase later.'
      },{
        'question': 'What is Mortgage?',
        'answer':
            'It is a legal agreement by which a bank or building society lends money at interest and gives them the right to take your property if you don’t repay the money you’ve borrowed.'
      },
      {
        'question': 'What is Rent to Own?',
        'answer':
            'Rent to Own is a system where tenants rent a property with the option to purchase later.'
      }
    ];
    _isExpanded = List<bool>.filled(_faqs.length, false);
  }

  void _addFAQ(String question, String answer) {
    setState(() {
      _faqs.add({'question': question, 'answer': answer});
      _isExpanded.add(false);
    });
    _questionController.clear();
    _answerController.clear();
  }
 
  

  Widget buildCustomTabBar() {
    return Align(
      alignment: Alignment.centerLeft,
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        indicator: const BoxDecoration(),
         splashFactory: NoSplash.splashFactory,
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        labelPadding: const EdgeInsets.symmetric(horizontal: 4), 
        tabs: _tabs.asMap().entries.map((entry) {
          int index = entry.key;
          String tab = entry.value;
          bool isActive = _tabController.index == index;

            return Tab(
                        child: Column(
                          children: [
                            Container(
                            
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(horizontal: 7),
                              height: isActive
                                  ? 40
                                  : 40, // Increased height for active tab
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: isActive
                                      ? Colors.white
                                      : Colors.orange, // Border color
                                ),
                                borderRadius: BorderRadius.circular(
                                    40), // Rounded corners
                                color: isActive
                                    ? Colors.orange // Active background
                                    : Colors
                                        .transparent, // Inactive tab background color
                              ),
                              child: Center(
                                child: Text(
                                  tab, // Tab text
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: isActive
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    color:
                                        isActive ? Colors.white : Colors.orange,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FAQ'),
        centerTitle: true,
         leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    const AccountPage(), // Start with MortgagePage
              ),
            ),
          },
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          buildCustomTabBar(),
          const SizedBox(height: 10),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: List.generate(
                _tabs.length,
                (index) => ListView.builder(
                  itemCount: _faqs.length,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 2,
                        surfaceTintColor: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _faqs[i]['question']!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                _isExpanded[i]
                                    ? _faqs[i]['answer']!
                                    : '${_faqs[i]['answer']!.substring(0, 50)}...',
                                style: const TextStyle(fontSize: 14),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _isExpanded[i] = !_isExpanded[i];
                                    });
                                  },
                                  child: Text(
                                      _isExpanded[i] ? 'Show Less' : 'Read More'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      
    );
  }
}
