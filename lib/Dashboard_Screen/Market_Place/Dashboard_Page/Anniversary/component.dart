import 'package:ag_mortgage/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
// ignore: depend_on_referenced_packages
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  void _onBackPressed(BuildContext context) {
    // Custom logic for back navigation
    if (Navigator.of(context).canPop()) {
      print("its working");
      Navigator.pushNamed(context, "/editProfile");
    } else {
      // Show exit confirmation dialog if needed
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Exit App"),
          content: Text("Do you want to exit the app?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("No"),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text("Yes"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          // Handle custom back navigation logic
          _onBackPressed(context);
          return false; // Prevent default back behavior
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Anniversary'),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Center(
                    child: Text(
                      'Set your anniversary for payment..',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ),
                  const Center(
                    child: Text(
                      '(An anniversary date is your last day to receive your payment every month)',
                      style: TextStyle(fontSize: 8, color: Colors.grey),
                    ),
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Your next anniversary date is:",
                      style: TextStyle(fontSize: 15, height: 5),
                    ),
                  ),
                  Text(
                    ' ${DateFormat('dd-MM-yyyy').format(_selectedDay)}',
                    style: const TextStyle(fontSize: 25, color: Colors.black),
                  ),
                  TableCalendar(
                    focusedDay: _focusedDay,
                    firstDay: DateTime(2000),
                    lastDay: DateTime(2100),
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDay, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay; // Update focusedDay
                      });
                    },
                    enabledDayPredicate: (day) {
                      // Disable past dates
                      final now = DateTime.now();
                      return !day
                          .isBefore(DateTime(now.year, now.month, now.day));
                    },
                    calendarStyle: CalendarStyle(
                      selectedDecoration: BoxDecoration(
                        color: baseColor,
                        shape: BoxShape.circle,
                      ),
                      todayDecoration: const BoxDecoration(
                        color: Colors.orange,
                        shape: BoxShape.circle,
                      ),
                      markerDecoration: const BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      disabledTextStyle:
                          const TextStyle(color: Colors.grey), // Optional
                    ),
                    headerStyle: const HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigator.pushReplacement(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => const Investment(startIndex: 7),
                        //   ),
                        // );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: baseColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        minimumSize: const Size(200, 50),
                      ),
                      child: const Text(
                        "Change",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
