import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:serve_now/services/tasker_auth.dart';
import 'package:serve_now/services/tasker_user.dart';
import 'package:serve_now/widgets/custom_text_field.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  late Future<Map<String, String>> taskerDataFuture;

  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  ///////
  final TextEditingController icController = TextEditingController();
  final TextEditingController addressOneController = TextEditingController();
  final TextEditingController addressTwoController = TextEditingController();
  final TextEditingController addressPoscodeController =
      TextEditingController();
  final TextEditingController addressStateController = TextEditingController();
  final TextEditingController addressAreaController = TextEditingController();
  final TextEditingController workinglocStateController =
      TextEditingController();
  final TextEditingController workinglocAreaController =
      TextEditingController();

  DateTime? selectedDate;

  String selectedGender = 'Male';

  @override
  void initState() {
    super.initState();
    taskerDataFuture = _loadTaskerData();
  }

  Future<Map<String, String>> _loadTaskerData() async {
    TaskerUser taskerUser = TaskerUser();
    try {
      await Future.delayed(const Duration(seconds: 1));
      var data = await taskerUser.getTaskerData();
      firstnameController.text = data[0]['tasker_firstname'] ?? '';
      lastnameController.text = data[0]['tasker_lastname'] ?? '';
      mobileController.text = data[0]['tasker_phoneno'] ?? '';
      emailController.text = data[0]['email'] ?? '';
      bioController.text = data[0]['tasker_bio'] ?? '';
      /////
      icController.text = data[0]['tasker_icno'] ?? '';
      final birthdateController = data[0]['tasker_dob'] ?? '';
      if (birthdateController.isNotEmpty) {
        selectedDate = DateTime.parse(birthdateController);
      }
      /////
      addressOneController.text = data[0]['tasker_address_one'] ?? '';
      addressTwoController.text = data[0]['tasker_address_two'] ?? '';
      addressPoscodeController.text = data[0]['tasker_address_poscode'] ?? '';
      addressStateController.text = data[0]['tasker_address_state'] ?? '';
      addressAreaController.text = data[0]['tasker_address_area'];
      workinglocStateController.text = data[0]['tasker_workingloc_state'] ?? '';
      workinglocAreaController.text = data[0]['tasker_workingloc_area'] ?? '';

      return {
        'tasker_firstname': data[0]['tasker_firstname'] ?? '',
        'tasker_lastname': data[0]['tasker_lastname'] ?? '',
        'tasker_email': data[0]['email'] ?? '',
        'tasker_mobile': data[0]['tasker_phoneno'] ?? '',
        'taskerProfilePhoto': data[0]['tasker_photo'] ?? '',
        'tasker_bio': data[0]['tasker_bio'] ?? '',
        'tasker_icno': data[0]['tasker_icno'] ?? '',
        'tasker_birthdate': birthdateController,
        /////
        'tasker_address_one': data[0]['tasker_address_one'] ?? '',
        'tasker_address_two': data[0]['tasker_address_two'] ?? '',
        'tasker_address_poscode': data[0]['tasker_address_poscode'] ?? '',
        'tasker_address_state': data[0]['tasker_address_state'] ?? '',
        'tasker_address_area': data[0]['tasker_address_area'] ?? '',
        'tasker_workingloc_state': data[0]['tasker_workingloc_state'] ?? '',
        'tasker_workingloc_area': data[0]['tasker_workingloc_area'] ?? '',
      };
    } catch (e) {
      print('Error occurred: $e');
      return {};
    }
  }

  void _saveProfile() async {
    final updatedData = {
      'tasker_firstname': firstnameController.text.trim(),
      'tasker_lastname': lastnameController.text.trim(),
      'tasker_phoneno': mobileController.text.trim(),
      'email': emailController.text.trim(),
      'tasker_bio': bioController.text.trim(),
      'tasker_icno': icController.text.trim(),
      'tasker_dob': selectedDate != null
          ? '${selectedDate!.year.toString().padLeft(4, '0')}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.day.toString().padLeft(2, '0')}'
          : '',
      'tasker_address_one': addressOneController.text,
      'tasker_address_two': addressTwoController.text,
      'tasker_address_poscode': addressPoscodeController.text.trim(),
      'tasker_address_state': addressStateController.text.trim(),
      'tasker_address_area': addressAreaController.text.trim(),
      'tasker_workingloc_state': workinglocStateController.text.trim(),
      'tasker_workingloc_area': workinglocAreaController.text.trim(),
    };

    try {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Saving profile...'),
          duration: Duration(seconds: 2),
        ),
      );

      TaskerUser taskerUser = TaskerUser();
      final taskerData = await taskerUser.getTaskerData();
      String taskerID = taskerData[0]['id'].toString();

      final response = await taskerUser.updateTaskerData(taskerID, updatedData);

      if (response.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile updated successfully!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 3),
          ),
        );
      } else {
        throw Exception('Failed to update profile. Please try again later.');
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${error.toString()}'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  void _savePassword() async {
    final updatedPassword = {
      'oldPass': oldPasswordController.text,
      'newPass': newPasswordController.text,
      'renewPass': confirmPasswordController.text,
    };
    try {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Saving profile...'),
          duration: Duration(seconds: 2),
        ),
      );

      TaskerUser taskerUser = TaskerUser();
      TaskerAuth taskerAuth = TaskerAuth();
      final taskerData = await taskerUser.getTaskerData();
      String taskerID = taskerData[0]['id'].toString();
      final response =
          await taskerAuth.updateTaskerPassword(taskerID, updatedPassword);
      print(response['message']);

      if (response['statusCode'] == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response['data']['message']),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 3),
          ),
        );
      } else if (response['statusCode'] == 301) {
        throw Exception(response['data']['message']);
      } else {
        throw Exception(response['data']['message']);
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${error.toString()}'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  void dispose() {
    firstnameController.dispose();
    lastnameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    bioController.dispose();
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _openDatePicker() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            color: Colors.white,
          ),
          height: 300,
          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                            fontFamily: 'inter',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Done',
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 14,
                            fontFamily: 'inter',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: CupertinoDatePicker(
                  initialDateTime: selectedDate ?? DateTime.now(),
                  mode: CupertinoDatePickerMode.date,
                  onDateTimeChanged: (DateTime newDate) {
                    setState(() {
                      selectedDate = newDate;
                    });
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Two tabs: Personal Info and Change Password
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Edit Profile',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
              fontFamily: 'Inter',
              fontSize: 18,
            ),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Color.fromRGBO(24, 52, 92, 1),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          bottom: TabBar(
            overlayColor: WidgetStateProperty.all(Colors.transparent),
            indicatorColor: Colors.transparent,
            labelColor: const Color.fromRGBO(24, 52, 92, 1),
            unselectedLabelColor: Colors.grey[500],
            labelStyle: const TextStyle(
              fontSize: 14.0,
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 14.0,
            ),
            tabs: const [
              Tab(icon: Icon(Icons.person), text: 'Personal Info'),
              Tab(icon: Icon(Icons.lock), text: 'Change Password'),
            ],
          ),
          actions: [
            TextButton(
              style: const ButtonStyle(
                splashFactory: NoSplash.splashFactory,
              ),
              onPressed: _savePassword,
              child: Text(
                'Save',
                style: TextStyle(
                  fontFamily: 'Inter',
                  color: Colors.deepOrange[600],
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
        body: FutureBuilder<Map<String, String>>(
          future: taskerDataFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                      image: AssetImage('assets/serveNowLogo.png'), width: 100),
                  SpinKitThreeBounce(
                    color: Color.fromRGBO(24, 52, 92, 1),
                    size: 10.0,
                  ),
                ],
              ));
            } else if (snapshot.hasError) {
              return const Center(child: Text('Error loading profile data.'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No profile data available.'));
            } else {
              final data = snapshot.data!;
              return TabBarView(
                children: [
                  // Personal Info Tab
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Center(
                            child: CircleAvatar(
                              radius: 45,
                              backgroundImage: NetworkImage(
                                  'https://servenow.com.my/storage/${data['taskerProfilePhoto']}'),
                            ),
                          ),
                          const SizedBox(height: 30),
                          _buildTextField('First Name', firstnameController),
                          _buildTextField('Last Name', lastnameController),
                          Row(children: [
                            _buildGenderSelector(),
                            const SizedBox(width: 15),
                            _buildDatePicker('Birthdate'),
                          ]),
                          _buildTextField('Email', emailController),
                          _buildTextField('Mobile', mobileController),
                          _buildTextField('Bio', bioController),
                        ],
                      ),
                    ),
                  ),

                  // Change Password Tab
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildTextField('Old Password', oldPasswordController,
                              obscureText: true),
                          _buildTextField('New Password', newPasswordController,
                              obscureText: true),
                          _buildTextField(
                              'Confirm Password', confirmPasswordController,
                              obscureText: true),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {bool obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
              color: Colors.grey[600],
              fontFamily: 'Inter',
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 2.5),
        CustomTextField(
          controller: controller,
          obscureText: obscureText,
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  Widget _buildGenderSelector() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Gender',
            style:
                TextStyle(color: Colors.grey[600], fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 2.5),
          Container(
            padding: const EdgeInsets.all(12.5),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildGenderOption('Male'),
                _buildGenderOption('Female'),
              ],
            ),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

  Widget _buildGenderOption(String gender) {
    return GestureDetector(
      onTap: () => setState(() {
        selectedGender = gender;
      }),
      child: Text(
        gender,
        style: TextStyle(
          fontFamily: 'Inter',
          fontSize: 14,
          color: selectedGender == gender ? Colors.grey[800] : Colors.grey[400],
        ),
      ),
    );
  }

  Widget _buildDatePicker(String label) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style:
                TextStyle(color: Colors.grey[600], fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 2.5),
          GestureDetector(
            onTap: _openDatePicker,
            child: Container(
              padding: const EdgeInsets.all(12.5),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    selectedDate == null
                        ? 'Set Now'
                        : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  Icon(
                    Icons.event,
                    color: Colors.grey[600],
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
