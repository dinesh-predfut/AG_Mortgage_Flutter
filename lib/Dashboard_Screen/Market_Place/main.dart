import 'package:ag_mortgage/Dashboard_Screen/Market_Place/Dashboard_Page/marketing.dart';
import 'package:ag_mortgage/Dashboard_Screen/Market_Place/Details_Page/component.dart';
import 'package:ag_mortgage/Dashboard_Screen/Market_Place/Favorite/component.dart';
import 'package:ag_mortgage/Dashboard_Screen/Market_Place/Filter_Page/component.dart';
import 'package:ag_mortgage/Dashboard_Screen/Market_Place/Most_view/component.dart';
import 'package:ag_mortgage/Dashboard_Screen/Market_Place/New_House/component.dart';
import 'package:ag_mortgage/Dashboard_Screen/Market_Place/Today_Deal/component.dart';
import 'package:ag_mortgage/MarketPlace/component.dart';
import 'package:flutter/material.dart';
class MarketMain extends StatelessWidget {
  const MarketMain({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AG Mortgage',
      home: Market_place_connection(),
    );
  }
}
// ignore: camel_case_types
class Market_place_connection extends StatefulWidget {
  final int startIndex;
  const Market_place_connection({super.key, this.startIndex = 0});

  @override
  State<Market_place_connection> createState() =>
      _Market_place_connectionState();
}

// ignore: camel_case_types
class _Market_place_connectionState extends State<Market_place_connection> {
  int _currentStepIndex = 0;
  @override
  void initState() {
    super.initState();
    _currentStepIndex = widget.startIndex;
  }

  final List<Widget> _steps = [
    const MarketplacePage(),
     const MostViewedPage(),
     const TodayDeals(),
    const New_house(),
     PropertyDetailsPage(),
     const FilterHousePage(),
     const FavoritesPage(),
     
    ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: _steps[_currentStepIndex],
          ),
        ],
      ),
    );
  }
}
