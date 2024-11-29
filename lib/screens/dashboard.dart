import 'package:flutter/material.dart';
import 'package:serve_now/services/tasker_user.dart';
import 'package:serve_now/widgets/custom_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String taskerFirstName = '';
  String taskerProfilePhoto = '';

  @override
  void initState() {
    super.initState();
    _loadTaskerData();
  }

  void _loadTaskerData() async {
    TaskerUser taskerUser = TaskerUser();
    try {
      var data = await taskerUser.getTaskerData();
      setState(() {
        taskerFirstName = data[0]['tasker_firstname'];
        taskerProfilePhoto = data[0]['tasker_photo'];
      });
      print('Fetched Data: $data');
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      color: Colors.amber,
                      padding: const EdgeInsets.fromLTRB(17.5, 30, 17.5, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Dashboard',
                                style: TextStyle(
                                  color: Colors.grey[800],
                                  fontFamily: 'Inter',
                                  fontSize: 22.5,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                'Good Afternoon, $taskerFirstName',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                    fontFamily: 'Inter'),
                              ),
                            ],
                          ),

                          CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(
                                'https://servenow.com.my/storage/$taskerProfilePhoto'), // Replace with full image URL
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomCard(
                            cardColor: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Total Earning',
                                            style: TextStyle(
                                                fontFamily: 'Inter',
                                                color: Colors.grey[600])),
                                        Text('RM 129.00',
                                            style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey[800])),
                                      ],
                                    ),
                                    Text(
                                      'Change will take up to 5 minutes',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontFamily: 'Inter',
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                const Opacity(
                                  opacity: 0.5,
                                  child: SizedBox(
                                      width: 75,
                                      child: FaIcon(FontAwesomeIcons.coins,
                                          color: Colors.orange, size: 50.0)),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomCard(
                            cardColor: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Total Upcoming Job',
                                            style: TextStyle(
                                                fontFamily: 'Inter',
                                                color: Colors.grey[600])),
                                        Text('6',
                                            style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey[800])),
                                      ],
                                    ),
                                    Text(
                                      'Change will take up to 5 minutes',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontFamily: 'Inter',
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                Opacity(
                                  opacity: 0.5,
                                  child: SizedBox(
                                      width: 75,
                                      child: FaIcon(FontAwesomeIcons.listCheck,
                                          color: Colors.blueGrey[600],
                                          size: 50.0)),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ), // Border radius
                ),
                child: Container(
                  color: Colors.grey[100],
                  child: Column(
                    children: [
                      CustomCard(
                        cardColor: Colors.white,
                        child: SizedBox(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const FaIcon(FontAwesomeIcons.bell,
                                      color: Colors.orange),
                                  const SizedBox(width: 7.5),
                                  Text(
                                    'Notification',
                                    style: TextStyle(
                                        color: Colors.grey[700],
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'Change will take up to 5 minutes',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontFamily: 'Inter',
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: GridView.count(
                          crossAxisCount: 3,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                          physics: const NeverScrollableScrollPhysics(),
                          children: const [
                            CustomCard(
                              cardColor: Colors.white,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Service Management',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Inter',
                                      fontSize: 12,
                                      color: Color.fromRGBO(24, 52, 92, 1),
                                    ),
                                  ),
                                  Icon(
                                    Icons.home_repair_service,
                                    size: 30,
                                    color: Color.fromRGBO(24, 52, 92, 1),
                                  )
                                ],
                              ),
                            ),
                            CustomCard(
                              cardColor: Colors.white,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Booking Management',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Inter',
                                      fontSize: 12,
                                      color: Color.fromRGBO(24, 52, 92, 1),
                                    ),
                                  ),
                                  Icon(
                                    Icons.event,
                                    size: 30,
                                    color: Color.fromRGBO(24, 52, 92, 1),
                                  ),
                                ],
                              ),
                            ),
                            CustomCard(
                              cardColor: Colors.white,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Reviews',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Inter',
                                      fontSize: 12,
                                      color: Color.fromRGBO(24, 52, 92, 1),
                                    ),
                                  ),
                                  Icon(
                                    size: 30,
                                    Icons.comment,
                                    color: Color.fromRGBO(24, 52, 92, 1),
                                  )
                                ],
                              ),
                            ),
                            CustomCard(
                              cardColor: Colors.white,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'View Transaction',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Inter',
                                      fontSize: 12,
                                      color: Color.fromRGBO(24, 52, 92, 1),
                                    ),
                                  ),
                                  Icon(
                                    Icons.attach_money,
                                    size: 30,
                                    color: Color.fromRGBO(24, 52, 92, 1),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
