import 'package:flutter/material.dart';
import 'package:serve_now/widgets/custom_icon_button.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Inter',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromRGBO(24, 52, 92, 1),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(15, 30, 15, 30),
                color: const Color.fromRGBO(24, 52, 92, 1),
                child: const Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage('assets/isk.jpg'),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Iskandar Rosmi',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'vvvviskvvvv@gmail.com',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(15, 30, 15, 30),
                      child: Column(
                        children: [
                          CustomIconButton(
                              text: 'My Profile',
                              onPressed: () {
                                Navigator.pushNamed(context, '/my_profile');
                              },
                              bgColor: Colors.white,
                              fgColor: const Color.fromARGB(255, 100, 100, 100),
                              borderRadius: 12,
                              icon: const Icon(Icons.account_circle)),
                          CustomIconButton(
                              text: 'Settings',
                              onPressed: () {},
                              bgColor: Colors.white,
                              fgColor: const Color.fromARGB(255, 100, 100, 100),
                              borderRadius: 12,
                              icon: const Icon(Icons.settings)),
                          CustomIconButton(
                              text: 'Notifications',
                              onPressed: () {},
                              bgColor: Colors.white,
                              fgColor: const Color.fromARGB(255, 100, 100, 100),
                              borderRadius: 12,
                              icon: const Icon(
                                Icons.notifications,
                              )),
                          CustomIconButton(
                              text: 'FAQ',
                              onPressed: () {},
                              bgColor: Colors.white,
                              fgColor: const Color.fromARGB(255, 100, 100, 100),
                              borderRadius: 12,
                              icon: const Icon(Icons.question_answer)),
                          CustomIconButton(
                              text: 'About App',
                              onPressed: () {},
                              bgColor: Colors.white,
                              fgColor: const Color.fromARGB(255, 100, 100, 100),
                              borderRadius: 12,
                              icon: const Icon(Icons.info)),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(15, 30, 15, 30),
                      child: CustomIconButton(
                          text: 'Logout',
                          onPressed: () {},
                          bgColor: Colors.white,
                          fgColor: Colors.red,
                          borderRadius: 12,
                          icon: const Icon(Icons.logout)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
