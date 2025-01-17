import 'package:ag_mortgage/Main_Dashboard/dashboard/Statement_Page/component.dart';
import 'package:ag_mortgage/Profile/Edit_Profile/Document/component.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class Constuction_StatementPage extends StatelessWidget {
  const Constuction_StatementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Statement"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: Colors.grey, width: 0.5), // Adds bottom border
                ),
              ),
              child: ListTile(
                title: const Text("Statement of Account"),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const StatementOfAccount(),
                      ));
                },
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: Colors.grey, width: 0.5), // Adds bottom border
                ),
              ),
              child: ListTile(
                title: const Text("Statement of Documents"),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  // // Handle navigation
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  DocumentsPage(),
                  ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
