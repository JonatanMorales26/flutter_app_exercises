import 'package:flutter/material.dart';
import 'package:flutter_excersice/providers/ui_provider.dart';
import 'package:flutter_excersice/screens/google_places_screen.dart';
import 'package:flutter_excersice/utils/constants.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(uiProvider.appbarTitle ?? googlePlacesTitle),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Projects in Flutter',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.map),
              title: const Text(googlePlacesTitle),
              onTap: () {
                setState(() {
                  uiProvider.changeScreen(googlePlacesScreen);
                  Navigator.pop(context);
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text(chatGPTTitle),
              onTap: () {
                setState(() {
                  uiProvider.changeScreen(chatGptScreen);
                  Navigator.pop(context);
                });
              },
            ),
          ],
        ),
      ),
      body: uiProvider.uiScreen ?? GooglePlacesScreen(),
    );
  }
}
