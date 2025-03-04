import 'package:ag_mortgage/All_Cards/Get_all_Cards/controller.dart';
import 'package:ag_mortgage/All_Cards/Select_Amount/select_Amount.dart';
import 'package:ag_mortgage/Authentication/Login/login.dart';
import 'package:ag_mortgage/Authentication/Registration/Components/rigister.dart';
import 'package:ag_mortgage/Botam_Tab/bottam_tap.dart';
import 'package:ag_mortgage/Dashboard_Screen/Construction/construction.dart';
import 'package:ag_mortgage/Dashboard_Screen/Investment/investment.dart';
import 'package:ag_mortgage/Dashboard_Screen/Market_Place/Dashboard_Page/controller.dart';
import 'package:ag_mortgage/Dashboard_Screen/Market_Place/Details_Page/component.dart';
import 'package:ag_mortgage/Dashboard_Screen/Market_Place/Details_Page/models.dart';
import 'package:ag_mortgage/Dashboard_Screen/Market_Place/Most_view/component.dart';
import 'package:ag_mortgage/Dashboard_Screen/Market_Place/New_House/component.dart';
import 'package:ag_mortgage/Dashboard_Screen/Market_Place/Today_Deal/component.dart';
import 'package:ag_mortgage/Dashboard_Screen/Market_Place/main.dart';
import 'package:ag_mortgage/Dashboard_Screen/Mortgage/MortgageHome.dart';

import 'package:ag_mortgage/Dashboard_Screen/Mortgage/MortgagePage.dart';
import 'package:ag_mortgage/Dashboard_Screen/Mortgage/controller.dart';
import 'package:ag_mortgage/Dashboard_Screen/Rent-To-own/rent_To_Own.dart';
import 'package:ag_mortgage/Main_Dashboard/dashboard/Investment/compontent.dart';
import 'package:ag_mortgage/NotificationScreen/notification.dart';
import 'package:ag_mortgage/Profile/Dashboard/FAQs/components.dart';
import 'package:ag_mortgage/Profile/Dashboard/Help_desk/compontent.dart';
import 'package:ag_mortgage/Profile/Dashboard/How_We_Work/component.dart';
import 'package:ag_mortgage/Profile/Dashboard/My_Cards/component.dart';
import 'package:ag_mortgage/Profile/Dashboard/Terms_Condition/component.dart';
import 'package:ag_mortgage/Profile/Dashboard/component.dart';
import 'package:ag_mortgage/Profile/profile.dart';

import 'package:ag_mortgage/Dashboard_Screen/dashboard_Screen.dart';
import 'package:ag_mortgage/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:ag_mortgage/onboarding_pages/first_page.dart';
import 'package:ag_mortgage/onboarding_pages/second_page.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'Authentication/Login_Controller/controller.dart';
import 'Main_Dashboard/dashboard/Dashboard/component.dart';
import 'Profile/Edit_Profile/Profile_Details/component.dart';
// Import the BottomNavBar

void main() {
  Get.lazyPut(() => ProfileController());
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Market_Place_controller()),
        // ChangeNotifierProvider(
        //     create: (_) => MortgagController()), // Provide MortgageProvider
      ],
      child: const MyApp(),
    ),
  );
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       initialRoute: '/',
//       onGenerateRoute: (settings) {
//         print("Navigating to: ${settings.name}");
//         switch (settings.name) {
//           case '/':
//             return MaterialPageRoute(
//                 builder: (context) => const LandingPage(startIndex: 0));
//           case '/second':
//             return MaterialPageRoute(
//                 builder: (context) => const MortgagePageHome(startIndex: 0));
//           case '/register':
//             return MaterialPageRoute(
//                 builder: (context) => const RegisterScreen());
//           case '/login':
//             return MaterialPageRoute(builder: (context) => const Login());
//           case '/dashBoardPage':
//             return MaterialPageRoute(
//                 builder: (context) => const LandingPage(startIndex: 1));
//           case '/dashBoardPage/mortgage':
//             return MaterialPageRoute(
//                 builder: (context) => const MortgagePageHome(startIndex: 0));
//           case '/main_page':
//             return MaterialPageRoute(
//                 builder: (context) => const MortgagePageHome());
//           case 'login/propertyView':
//             final argument = settings.arguments as int?;

//             return MaterialPageRoute(
//               builder: (context) => PropertyDetailsPage(id: argument),
//             );
//           case '/rent-to-own':
//             return MaterialPageRoute(
//               builder: (context) => const Rent_To_Own(),
//             );
//           case '/construction':
//             return MaterialPageRoute(
//               builder: (context) => const ConstructionPage(),
//             );
//           case '/seemoretodaydeals':
//             return MaterialPageRoute(
//               builder: (context) => const MarketMain(startIndex: 2),
//             );
//                case '/seemoremostview':
//             return MaterialPageRoute(
//               builder: (context) => const MarketMain(startIndex: 1),
//             );
//                 case '/seemorenewhouse':
//             return MaterialPageRoute(
//               builder: (context) => const MarketMain(startIndex: 3),
//             );
//                 case '/filterPage':
//             return MaterialPageRoute(
//               builder: (context) => const MarketMain(startIndex: 5),
//             );
//              case '/marketMain':
//             return MaterialPageRoute(
//               builder: (context) => const LandingPage(startIndex: 2),
//             );
//               case '/favoritePage':
//             return MaterialPageRoute(
//               builder: (context) => const MarketMain(startIndex: 6),
//             );
//             case '/investment':
//             return MaterialPageRoute(
//               builder: (context) => const Investment(),
//             );
//              case '/investmentmore':
//             return MaterialPageRoute(
//               builder: (context) => const Investment_Forms(),
//             );
//           default:
//             return MaterialPageRoute(
//                 builder: (context) =>
//                     const Login()); // Handle unknown routes
//         }
//       },
//     );
//   }
// }

// class LandingPage extends StatefulWidget {
//   final int startIndex;
//   const LandingPage({super.key, this.startIndex = 0});
//   @override
//   _LandingPageState createState() => _LandingPageState();
// }

// class _LandingPageState extends State<LandingPage> {
//   int _currentIndex = 1;

//   @override
//   void initState() {
//     super.initState();
//     _currentIndex = widget.startIndex; // ✅ Initialize with provided index
//   }

//   // ✅ Corrected List of Pages (Should be Widgets, not Routes)
//   final List<Widget> _pages = [
//     const Logo_Screen(),
//     const DashboardPage(),
//     const MarketMain(),
//     const NotificationsPage(),
//     const ProfilePagewidget(startIndex: 0),
//     const MortgagePageHome(startIndex: 0)
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final bool showBottomNavBar = _currentIndex != 0;

//     return Scaffold(
//         body: _pages[_currentIndex],
//         bottomNavigationBar: showBottomNavBar
//             ? BottomNavBar(
//                 currentIndex: _currentIndex - 1,
//                 onTap: (index) => _onItemTapped(index + 1),
//                 items: const [], // Adjust for LandingPage
//               )
//             : null,
//       );

//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        print("Navigating to: ${settings.name}");
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(
                builder: (context) => const MainLayout(
                    showBottomNavBar: false, child: Logo_Screen()));
          case '/dashBoardPage':
            return MaterialPageRoute(
                builder: (context) => const MainLayout(
                    showBottomNavBar: true, child: DashboardPage()));
          case '/mortgageForm':
            final argument = settings.arguments as Houseview?;
            return MaterialPageRoute(
                builder: (context) => MainLayout(
                    showBottomNavBar: true,
                    child: MortgageFormPage(
                      house: argument,
                    )));
          case '/mortgageCalendar':
            return MaterialPageRoute(
                builder: (context) => const MainLayout(
                    showBottomNavBar: true, child: CalendarPageMortgage()));
          case '/mortgageTermsheet':
            return MaterialPageRoute(
                builder: (context) => MainLayout(
                      showBottomNavBar: true,
                      child: ChangeNotifierProvider.value(
                        value: Provider.of<MortgagController>(context,
                            listen: false),
                        child: const MortgageTermSheetPage(),
                      ),
                    ));
          case '/marketMain':
            return MaterialPageRoute(
                builder: (context) => const MainLayout(
                    showBottomNavBar: true, child: MarketMain(startIndex: 0)));
          case '/mainDashboard':
          final argument = settings.arguments.toString();
            return MaterialPageRoute(
                builder: (context) =>  MainLayout(
                    showBottomNavBar: true, child: DashboardPageS(argument)));
          case '/marketMain/sponsered':
            final argument = settings.arguments as int?;
            return MaterialPageRoute(
                builder: (context) => MainLayout(
                    showBottomNavBar: true,
                    child: MarketMain(startIndex: 4, id: argument)));
          case '/dashBoardPage/mortgage':
            return MaterialPageRoute(
                builder: (context) => const MainLayout(
                    showBottomNavBar: false,
                    child: MortgagePageHome(startIndex: 0)));
          case '/register':
            return MaterialPageRoute(
                builder: (context) => const MainLayout(
                    showBottomNavBar: false, child: RegisterScreen()));
          case '/login':
            return MaterialPageRoute(
                builder: (context) =>
                    const MainLayout(showBottomNavBar: false, child: Login()));
          case 'login/propertyView':
            final argument = settings.arguments as int?;
            return MaterialPageRoute(
                builder: (context) => MainLayout(
                    showBottomNavBar: false,
                    child: PropertyDetailsPage(id: argument)));
          case '/seemoretodaydeals':
            return MaterialPageRoute(
                builder: (context) => const MainLayout(
                    startIndex: 1,
                    showBottomNavBar: true,
                    child: TodayDeals()));
          case '/seemoremostview':
            return MaterialPageRoute(
                builder: (context) => const MainLayout(
                    startIndex: 1,
                    showBottomNavBar: true,
                    child: MostViewedPage()));
          case '/seemorenewhouse':
            return MaterialPageRoute(
                builder: (context) => const MainLayout(
                    startIndex: 1, showBottomNavBar: true, child: New_house()));
          case '/settings/getallCards':
            return MaterialPageRoute(
                builder: (context) => MainLayout(
                      startIndex: 3,
                      showBottomNavBar: true,
                      child: ChangeNotifierProvider(
                        create: (context) => CardController(),
                        child: const MyCardsPage(),
                      ),
                    ));
          case '/editProfile':
            return MaterialPageRoute(
                builder: (context) => const MainLayout(
                    startIndex: 3,
                    showBottomNavBar: true,
                    child: Edit_Profile()));
          case '/editProfile/profileinFoDetails':
            return MaterialPageRoute(
                builder: (context) => const MainLayout(
                    startIndex: 3,
                    showBottomNavBar: true,
                    child: PersonalDetailsPage()));
          case '/editProfile/employementDetails':
            return MaterialPageRoute(
                builder: (context) => const MainLayout(
                    startIndex: 3,
                    showBottomNavBar: true,
                    child: PersonalDetailsPage()));
          case '/editProfile/homeAddress':
            return MaterialPageRoute(
                builder: (context) => const MainLayout(
                    startIndex: 3,
                    showBottomNavBar: true,
                    child: ProfilePagewidget(startIndex: 5)));
          case '/editProfile/LoginDetails':
            return MaterialPageRoute(
                builder: (context) => const MainLayout(
                    startIndex: 3,
                    showBottomNavBar: true,
                    child: ProfilePagewidget(
                      startIndex: 3,
                    )));
          case '/editProfile/anniversary':
            return MaterialPageRoute(
                builder: (context) => const MainLayout(
                    startIndex: 3,
                    showBottomNavBar: true,
                    child: ProfilePagewidget(startIndex: 7)));
          case '/editProfile/documentUpload':
            return MaterialPageRoute(
                builder: (context) => const MainLayout(
                    startIndex: 3,
                    showBottomNavBar: true,
                    child: ProfilePagewidget(
                      startIndex: 8,
                    )));
          case '/howwearework':
            return MaterialPageRoute(
                builder: (context) => const MainLayout(
                    startIndex: 3,
                    showBottomNavBar: true,
                    child: AccountTermsandcondition()));
          case '/rent-to-own':
            return MaterialPageRoute(
                builder: (context) => const MainLayout(
                    showBottomNavBar: false, child: Rent_To_Own()));
          case '/rent-to-own/terms_condition':
            return MaterialPageRoute(
                builder: (context) => const MainLayout(
                    showBottomNavBar: false,
                    child: Rent_To_Own(startIndex: 7)));
          case '/rent-to-own/term_sheet':
            final argument = settings.arguments as Houseview?;
            return MaterialPageRoute(
                builder: (context) => MainLayout(
                    showBottomNavBar: true,
                    child: RentToOwnForm(house: argument)));
          case '/rent-to-own/calendar':
            return MaterialPageRoute(
                builder: (context) => const MainLayout(
                    showBottomNavBar: true, child: Rent_To_Own(startIndex: 2)));
          case '/rent-to-own/term_sheet_Details':
            return MaterialPageRoute(
                builder: (context) => const MainLayout(
                    showBottomNavBar: true, child: Rent_To_Own(startIndex: 3)));
          case '/rent-to-own/paymentPage':
            return MaterialPageRoute(
                builder: (context) => const MainLayout(
                    showBottomNavBar: false,
                    child: Rent_To_Own(startIndex: 4)));
          case '/rent-to-own/paymentPage/bank':
            return MaterialPageRoute(
                builder: (context) => const MainLayout(
                    showBottomNavBar: false,
                    child: Rent_To_Own(startIndex: 5)));
          case '/helpDisk':
            return MaterialPageRoute(
                builder: (context) => const MainLayout(
                    startIndex: 3,
                    showBottomNavBar: true,
                    child: HeplDeskPage()));
          case '/settings/faq':
            return MaterialPageRoute(
                builder: (context) => const MainLayout(
                    startIndex: 3, showBottomNavBar: true, child: FAQPage()));
          case '/construction':
            return MaterialPageRoute(
                builder: (context) => const MainLayout(
                    showBottomNavBar: false, child: ConstructionPage()));
          case '/construction/term_condition':
            return MaterialPageRoute(
                builder: (context) => const MainLayout(
                    showBottomNavBar: false,
                    child: ConstructionPage(startIndex: 10)));
          case '/construction/termsheet':
            return MaterialPageRoute(
                builder: (context) => const MainLayout(
                    showBottomNavBar: true,
                    child: ConstructionPage(startIndex: 1)));
          case '/construction/termsheet/permissionPage':
            return MaterialPageRoute(
                builder: (context) => const MainLayout(
                    showBottomNavBar: true,
                    child: ConstructionPage(startIndex: 2)));
          case '/settings/termofservice':
            return MaterialPageRoute(
                builder: (context) => const MainLayout(
                    startIndex: 3,
                    showBottomNavBar: true,
                    child: Terms_andcondition()));
          case '/favoritePage':
            return MaterialPageRoute(
                builder: (context) => const MainLayout(
                    showBottomNavBar: true, child: MarketMain(startIndex: 6)));
          case '/investment':
            return MaterialPageRoute(
                builder: (context) => const MainLayout(
                    showBottomNavBar: true, child: Investment()));

          case '/settings':
            return MaterialPageRoute(
                builder: (context) => const MainLayout(
                    startIndex: 3,
                    showBottomNavBar: true,
                    child: ProfilePagewidget(startIndex: 0)));
          case '/investment/card':
            return MaterialPageRoute(
                builder: (context) => const MainLayout(
                    showBottomNavBar: true, child: Investment(startIndex: 1)));
          case '/investment/cardPayment':
            return MaterialPageRoute(
                builder: (context) => const MainLayout(
                    showBottomNavBar: false, child: Investment(startIndex: 2)));
          case '/investment/bankPayment':
            return MaterialPageRoute(
                builder: (context) => const MainLayout(
                    showBottomNavBar: false, child: Investment(startIndex: 9)));
          case '/investmentmore':
            return MaterialPageRoute(
                builder: (context) => const MainLayout(
                    showBottomNavBar: true, child: Investment_Forms()));
          case '/selectedCard':
            final argument = settings.arguments as int?;
            return MaterialPageRoute(
                builder: (context) => MainLayout(
                      showBottomNavBar: true,
                      child: CardPaymentPage(selectedID: argument),
                    ));
          default:
            return MaterialPageRoute(
                builder: (context) =>
                    const MainLayout(showBottomNavBar: false, child: Login()));
        }
      },
    );
  }
}

class MainLayout extends StatefulWidget {
  final Widget child;
  final bool showBottomNavBar;
  final int startIndex;
  const MainLayout(
      {super.key,
      required this.child,
      this.showBottomNavBar = true,
      this.startIndex = 0});

  @override
  _MainLayoutState createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.startIndex; // Set from constructor
  }

  void _onItemTapped(int index) {
    if (index < 0 || index >= 4) return; // Ensure index is within range
    setState(() {
      _selectedIndex = index;
    });
    print("_selectedIndex$_selectedIndex");
    switch (index) {
      case 0:
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => MainLayout(
                    showBottomNavBar: true,
                    startIndex: index,
                    child: const DashboardPage())));
        break;
      case 1:
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => MainLayout(
                    showBottomNavBar: true,
                    startIndex: index,
                    child: const MarketMain())));
        break;
      case 2:
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => MainLayout(
                    showBottomNavBar: true,
                    startIndex: index,
                    child: const NotificationsPage())));
        break;
      case 3:
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => MainLayout(
                    showBottomNavBar: true,
                    startIndex: index,
                    child: const AccountPage())));
        break;
      default:
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => MainLayout(
                    showBottomNavBar: true,
                    startIndex: index,
                    child: const Logo_Screen())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _selectedIndex == 0, // Only allows popping when on Home tab
      onPopInvoked: (didPop) {
        if (!didPop) {
          if (_selectedIndex != 0) {
            _onItemTapped(0);
            setState(() {
              _selectedIndex = 0; // Navigate to Home tab instead of exiting
            });
          }
        }
      },
      child: Scaffold(
        body: widget.child,
        bottomNavigationBar: widget.showBottomNavBar
            ? BottomNavigationBar(
                currentIndex: _selectedIndex,
                onTap: _onItemTapped,
                items: [
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.home),
                    label: 'Home',
                    backgroundColor: baseColor,
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.shopping_cart),
                    label: 'Marketplace',
                    backgroundColor: baseColor,
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.notifications),
                    label: 'Notifications',
                    backgroundColor: baseColor,
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.person),
                    label: 'Account',
                    backgroundColor: baseColor,
                  ),
                ],
              )
            : null,
      ),
    );
  }
}
