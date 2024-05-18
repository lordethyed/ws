import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<String> users = [
    '@eburras1q',
    '@omarslandly',
    '@rstrettle1v',
    '@bpickering1k'
  ];

  List<String> messages = [
    'This is some awesome thinking!',
    "What terrific math skills you're showing!",
    "It was a pleasure to grade",
    "You're showing inventive ideas!"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: const Text(
          'Notifications',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          const Row(),
          const Text(
            'Messages',
            style: TextStyle(
              color: Colors.red,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            'Please enter your information',
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(
            width: MediaQuery.sizeOf(context).width,
            height: 500,
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) => ListTile(
                leading: const Column(
                  children: [
                    Icon(Icons.person),
                    Icon(Icons.mail),
                  ],
                ),
                title: Text(users[index]),
                subtitle: Text(messages[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
