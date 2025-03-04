import 'package:ag_mortgage/Profile/profile.dart';
import 'package:ag_mortgage/Profile/profile_All_controller.dart';
import 'package:ag_mortgage/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

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
  bool isEditingMail = false;

  final controller = Get.put(Profile_Controller());

  @override
  void initState() {
    super.initState();
    // Initialize with default values
  }

  @override
  void dispose() {
    // usernameController.dispose();
    // passwordController.dispose();
    // confirmPasswordController.dispose();
    super.dispose();
  }
 void _onBackPressed(BuildContext context) {
    // Custom logic for back navigation
    if (Navigator.of(context).canPop()) {

         Navigator.pushNamed(context, "/editProfile");
    } else {
      // Show exit confirmation dialog if needed
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Exit App"),
          content: const Text("Do you want to exit the app?"),
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
    return
    WillPopScope(
      onWillPop: () async {
        // Handle custom back navigation logic
        _onBackPressed(context);
        return false; // Prevent default back behavior
      },
    child:  Scaffold(
      appBar: AppBar(
        title: const Text("Login Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: controller.phoneNumber,
              readOnly:
                  !isEditingUsername, // This determines if the field is editable

              decoration: InputDecoration(
                labelText: "Phone Number",
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
              controller: controller.email,
              readOnly:
                  !isEditingMail, // This determines if the field is editable

              decoration: InputDecoration(
                labelText: "Email",
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      isEditingMail = true; // Enable editing mode
                    });
                  },
                  child: Icon(
                    isEditingMail
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
              controller: controller.passwordController,
              readOnly:
                  !isEditingPassword, // This determines if the field is editable

              decoration: InputDecoration(
                labelText: "New Password",
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
                controller: controller.confirmPasswordController,
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
            if (isEditingPassword || isEditingUsername)
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
                  controller.logInDetails(context);
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
     ) );
  }
}
