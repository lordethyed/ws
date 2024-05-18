import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key, required this.token});
  final String token;

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final Dio dio = Dio();
  String user = '';

  bool isLoading = true;

  getUser() async {
    try {
      final headers = {'Authorization': 'Bearer ${widget.token}'};
      final response = await dio.get('https://dummyjson.com/auth/me',
          options: Options(headers: headers));

      log(response.data.toString());
      setState(() {
        user =
            '${response.data['firstName']} ${response.data['maidenName']} ${response.data['lastName']}';
        isLoading = false;
      });
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: const Text(
          'User page',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Column(
                    children: [
                      Text(
                        'You loggin by',
                        style: TextStyle(
                            color: Colors.red.shade200,
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      ),
                      Text(
                        user,
                        style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      ),
                      Image.asset('assets/images/Imagen 4.png'),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
