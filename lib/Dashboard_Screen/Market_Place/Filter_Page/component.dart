import 'package:ag_mortgage/Dashboard_Screen/Construction/models.dart';
import 'package:ag_mortgage/Dashboard_Screen/Market_Place/Dashboard_Page/controller.dart';
import 'package:ag_mortgage/Dashboard_Screen/Market_Place/Dashboard_Page/model.dart';
import 'package:ag_mortgage/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterHousePage extends StatefulWidget {
  const FilterHousePage({super.key});

  @override
  _FilterHousePageState createState() => _FilterHousePageState();
}

class _FilterHousePageState extends State<FilterHousePage>
    with SingleTickerProviderStateMixin {
  final controller = Get.put(Market_Place_controller());
  late TabController _tabController;
  List<String> amenities = [
    'Parking Lot',
    'Gym',
    'Beach',
    'Garden',
    'Solar',
    'Back Yard',
    'Furnitures',
    'Field',
    'Fence'
  ];
  void initState() {
    super.initState();

    _tabController = TabController(length: 6, vsync: this);
    _tabController.addListener(() {
      setState(() {}); // Refresh UI when tab changes
    });
  }

  final List<String> _tabs = [
    "All",
    "Lagos",
    "Ogun",
    "Anambra",
    "Abuja",
    "oyo",
    "Kaduna",
    "Kano"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Filter House"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Est pellentesque fermentum cursus curabitur pharetra, vene',
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 10),
              // Align(
              //   alignment: Alignment.centerLeft,
              //   child: TabBar(
              //     controller: _tabController,
              //     isScrollable: true, // Makes the tabs scrollable
              //     labelColor: Colors.white, // Active tab text color
              //     // unselectedLabelColor:
              //     //     Colors.orange, // Inactive tab text color
              //     // indicator: BoxDecoration(
              //     //   borderRadius: BorderRadius.circular(
              //     //       40), // Rounded corners for active tab
              //     //   color: Colors.orange// Active tab background color
              //     // ),
              //     indicator: const BoxDecoration(),
              //     splashFactory:
              //         NoSplash.splashFactory, // Removes ripple effect
              //     overlayColor: MaterialStateProperty.all(Colors.transparent),
              //     tabs: _tabs.asMap().entries.map((entry) {
              //       int index = entry.key;
              //       String tab = entry.value;

              //       bool isActive = _tabController.index ==
              //           index; // Check if the tab is active

              //       return Tab(
              //         child: Column(
              //           children: [
              //             Container(
              //               width: 60,
              //               padding: const EdgeInsets.symmetric(horizontal: 3),
              //               height: isActive
              //                   ? 40
              //                   : 40, // Increased height for active tab
              //               decoration: BoxDecoration(
              //                 border: Border.all(
              //                   color: isActive
              //                       ? Colors.white
              //                       : Colors.orange, // Border color
              //                 ),
              //                 borderRadius:
              //                     BorderRadius.circular(40), // Rounded corners
              //                 color: isActive
              //                     ? Colors.orange // Active background
              //                     : Colors
              //                         .transparent, // Inactive tab background color
              //               ),
              //               child: Center(
              //                 child: Text(
              //                   tab, // Tab text
              //                   style: TextStyle(
              //                     fontSize: 12,
              //                     fontWeight: isActive
              //                         ? FontWeight.bold
              //                         : FontWeight.normal,
              //                     color:
              //                         isActive ? Colors.white : Colors.orange,
              //                   ),
              //                 ),
              //               ),
              //             ),
              //           ],
              //         ),
              //       );
              //     }).toList(),
              //   ),
              // ),
              const SizedBox(height: 16),
              const Text(
                "Choose Location",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              FutureBuilder<List<PostsModel>>(
                future: controller.getALLCityApi(),
                builder: (context, citySnapshot) {
                  // Ensure data is not null
                  List<PostsModel> cityData = citySnapshot.data ?? [];

                  return DropdownButtonFormField<int>(
                    value: controller.selectedCity,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    isExpanded: true,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: cityData.isNotEmpty
                        ? cityData.map((item) {
                            return DropdownMenuItem<int>(
                              value: item.id,
                              child: Text(item.name ?? 'Unknown Name'),
                            );
                          }).toList()
                        : [], // Prevents mapping on null

                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          controller.selectedCity = value;
                        });
                      }
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a city';
                      }
                      return null;
                    },
                  );
                },
              ),
              const SizedBox(height: 16),
              const Text(
                "House Type",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              FutureBuilder<List<Apartment>>(
                future: controller.getApartment(),
                builder: (context, citySnapshot) {
                  // Ensure data is not null
                  List<Apartment> apartmenttype = citySnapshot.data ?? [];

                  return DropdownButtonFormField<int>(
                    value: controller.selectedHouseType,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    isExpanded: true,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: apartmenttype.isNotEmpty
                        ? apartmenttype.map((item) {
                            return DropdownMenuItem<int>(
                              value: item.id,
                              child: Text(item.apartmentType),
                            );
                          }).toList()
                        : [], // Prevents mapping on null

                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          controller.selectedHouseType = value;
                        });
                      }
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a city';
                      }
                      return null;
                    },
                  );
                },
              ),
              const SizedBox(height: 16),
              const Text(
                "Bedrooms",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: "Input Preferred Number of Bedrooms",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                    )),
                onChanged: (value) {
                  setState(() {
                    controller.selectedBedrooms = int.tryParse(value);
                  });
                },
              ),
              const SizedBox(height: 16),
              const Text(
                "Budget",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Input your Budget (NGN)",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    controller.budget = double.tryParse(value) as int?;
                  });
                },
              ),
              const SizedBox(height: 16),
              const Text(
                "Amenities",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Wrap(
                spacing: 8.0,
                children: amenities.map((amenity) {
                  bool isSelected =
                      controller.selectedAmenities.contains(amenity);
                  return ChoiceChip(
                    label: Text(amenity),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          controller.selectedAmenities.add(amenity);
                        } else {
                          controller.selectedAmenities.remove(amenity);
                        }
                      });
                    },
                    selectedColor: Colors.orange,
                    backgroundColor: Colors.grey[200],
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                       controller.clearFields();
                        Navigator.pushNamed(context,
                            "/marketMain"); // Navigates back to the previous screen
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 16),
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                      child: const Text(
                        "Clear filter",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                         controller.fetchnewtViewedHouses();
                        controller.fetchTodayDeals();
                        controller.fetchHouses();
                        controller.fetchmostViewedHouses();
                        Navigator.pushNamed(context,
                            "/marketMain"); // Navigates back to the previous screen
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: baseColor,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 16),
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                      child: const Text(
                        "Apply Filter",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
