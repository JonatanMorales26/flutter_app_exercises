import 'package:flutter/material.dart';
import 'package:flutter_excersice/screens/chat_gpt_screen.dart';
import 'package:flutter_excersice/screens/google_places_screen.dart';
import 'package:flutter_excersice/utils/constants.dart';

class UiProvider extends ChangeNotifier {
  Widget? uiScreen;
  String? appbarTitle;

  void changeScreen(String selectedPage) {
    switch (selectedPage) {
      case googlePlacesScreen:
        appbarTitle = googlePlacesTitle;
        uiScreen = GooglePlacesScreen();
        break;
      case chatGptScreen:
        appbarTitle = chatGPTTitle;
        uiScreen = ChatGPTScreen();
        break;
    }
    notifyListeners();
  }
}
