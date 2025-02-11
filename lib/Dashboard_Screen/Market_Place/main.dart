import 'package:ag_mortgage/Dashboard_Screen/Market_Place/Dashboard_Page/marketing.dart';
import 'package:ag_mortgage/Dashboard_Screen/Market_Place/Details_Page/component.dart';
import 'package:ag_mortgage/Dashboard_Screen/Market_Place/Favorite/component.dart';
import 'package:ag_mortgage/Dashboard_Screen/Market_Place/Filter_Page/component.dart';
import 'package:ag_mortgage/Dashboard_Screen/Market_Place/Most_view/component.dart';
import 'package:ag_mortgage/Dashboard_Screen/Market_Place/New_House/component.dart';
import 'package:ag_mortgage/Dashboard_Screen/Market_Place/Today_Deal/component.dart';
import 'package:ag_mortgage/MarketPlace/component.dart';
import 'package:flutter/material.dart';



// ignore: camel_case_types
class MarketMain extends StatefulWidget {
   final int startIndex;
  final int? id;

  const MarketMain({
    super.key,
    this.startIndex = 0,
    this.id,
  });
  @override
  State<MarketMain> createState() =>
      _MarketMainState();
}

// ignore: camel_case_types
class _MarketMainState extends State<MarketMain> {
  int _currentStepIndex = 0;
  @override
  void initState() {
    super.initState();
    _currentStepIndex = widget.startIndex;
  }

  
List<Widget> get _steps => [
    const MarketplacePage(),
    const MostViewedPage(),
    const TodayDeals(),
    const New_house(), 
     PropertyDetailsPage(id: widget.id),
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
