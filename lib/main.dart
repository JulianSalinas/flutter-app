import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:letsattend/theme/theme_app.dart';
import 'package:letsattend/screens/login.dart';
import 'package:letsattend/providers/palette.dart';


void main() => runApp(Main());

class Main extends StatelessWidget {

    @override
    Widget build(BuildContext context) {

        return MultiProvider(
            providers: [
                ChangeNotifierProvider<Palette>(builder: (context) => Palette())
            ],
            child: ThemeApp(Login())
        );

    }

}