import 'package:flutter/material.dart';
import 'package:armirene_rh_app/components/my_botton_nav_bar.dart';
import 'package:armirene_rh_app/constans.dart';
import 'package:armirene_rh_app/Screens/search/components/body.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        elevation: 0,
        backgroundColor: kPrimaryColor,
        title: const Text('Consulta'),
      ),*/
      body: Body(),
      bottomNavigationBar: const MyBottomNavBar(),
    );
  }
}