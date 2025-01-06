import 'package:ag_mortgage/Profile/profile.dart';
import 'package:ag_mortgage/const/colors.dart';
import 'package:flutter/material.dart';

class EditLoginDetails extends StatefulWidget {
  const EditLoginDetails({super.key});

  @override
  _EditLoginDetailsState createState() => _EditLoginDetailsState();
}

class _EditLoginDetailsState extends State<EditLoginDetails> {
  bool isEditing = false;
  bool isEnable = false;
  bool isEditingPassword = false;
  bool isEditingUsername = false;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize with default values
    usernameController.text = "Salt";
    passwordController.text = "********";
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: usernameController,
              readOnly:
                  !isEditingUsername, // This determines if the field is editable
              
              decoration: InputDecoration(
                labelText: "Enter Username",
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      isEditingUsername = true; // Enable editing mode
                     
                    });
                  },
                  child: Icon(
                    isEditingUsername
                        ? Icons.check
                        : Icons.edit, // Change icon based on state
                    color: isEditing ? Colors.green : Colors.grey,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              readOnly:
                  !isEditingPassword, // This determines if the field is editable
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Enter Password",
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      isEditingPassword = true; // Enable editing mode
                      isEditing = true;
                    });
                  },
                  child: Icon(
                    isEditingPassword
                        ? Icons.check
                        : Icons.edit, // Change icon based on state
                    color: isEditing ? Colors.green : Colors.grey,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (isEditingPassword) // Show this field only when isEnable is true
              TextField(
                controller: confirmPasswordController,
                readOnly:
                    !isEditingPassword, // This determines if the field is editable
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Confirm Password",
                 
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
            const SizedBox(height: 16),
             if (isEditingPassword || isEditingUsername )
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: baseColor, // Transparent background
                elevation: 0, // Remove shadow
                foregroundColor: Colors.white, // Text and icon color
                padding:
                    const EdgeInsets.symmetric(horizontal: 109, vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), // Rounded corners
                ),
              ),
              onPressed: () {
             setState(() {
                      isEditingPassword = false; // Enable editing mode
                      isEditingUsername = false;
                    });
              },
              child: const Text("Save Changes"),
            ),
          ],
        ),
      ),
    );
  }
}
