import 'package:flutter/material.dart';
import 'package:letsattend/router/routes.dart';
import 'package:letsattend/auth/auth_engine.dart';
import 'package:letsattend/blocs/settings_bloc.dart';
import 'package:letsattend/views/drawer/drawer_view.dart';
import 'package:letsattend/views/settings/section_title.dart';
import 'package:letsattend/widgets/custom/colored_flex.dart';
import 'package:letsattend/widgets/custom/formal_text.dart';
import 'package:provider/provider.dart';

/// A simple colored screen with a centered text
class SettingsView extends StatefulWidget {
  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {

  @override
  Widget build(BuildContext context) {

    SettingsBloc settings = Provider.of<SettingsBloc>(context);

    final body = ListView(
      children: <Widget>[
        SectionTitle('Autenticación'),
        ListTile(
          title: Text('Proveedor'),
          trailing: Container(
            height: 24,
            child: ToggleButtons(
              fillColor: Colors.red,
              selectedColor: Colors.white,
              borderRadius: BorderRadius.circular(8),
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text('Firebase'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text('Amazon'),
                ),
              ],
              onPressed: (int index) => settings.authEngine =
                  index == 0 ? AuthEngine.Firebase : AuthEngine.Amazon,
              isSelected: [
                settings.authEngine == AuthEngine.Firebase,
                settings.authEngine == AuthEngine.Amazon
              ],
            ),
          ),
        ),
      ],
    );

    final appBarLeading = IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: Navigator.of(context).pop,
    );

    final appBar = AppBar(
      title: FormalText('Configuración'),
      centerTitle: true,
      leading: appBarLeading,
      flexibleSpace: ColoredFlex(),
    );

    return Scaffold(
      drawer: DrawerView(Routes.SETTINGS_ROUTE),
      appBar: appBar,
      body: body,
    );

  }
}
