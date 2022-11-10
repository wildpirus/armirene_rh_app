import 'package:flutter/material.dart';
import 'package:armirene_rh_app/components/my_botton_nav_bar.dart';
import 'package:armirene_rh_app/constans.dart';
import 'package:armirene_rh_app/screens/home/components/body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kPrimaryColor,
      ),
      body: Body(),
      bottomNavigationBar: const MyBottomNavBar(),
    );
  }
}