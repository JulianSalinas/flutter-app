import 'package:flutter/foundation.dart';


class Palette with ChangeNotifier {

    bool darkMode = true;

    void onChangeDarkMode(value){
        darkMode = value;
        notifyListeners();
    }

}