import 'package:flutter/material.dart';
import 'package:letsattend/router/routes.dart';
import 'package:letsattend/shared/engine.dart';
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
        SectionTitle('Personal'),
        InkWell(
          child: Container(
            child: ListTile(
              title: Text('Usar foto de perfil'),
              subtitle: Text('Permite a la aplicación usar la foto de perfil si iniciaste con Google.'),
              trailing: Switch(
                value: settings.allowPhoto,
                onChanged: (value) => settings.allowPhoto = value,
              ),
            ),
            padding: EdgeInsets.fromLTRB(0, 16, 0, 8),
          ),
          onTap: () => settings.allowPhoto = !settings.allowPhoto,
        ),
        Divider(height: 1,),
        InkWell(
          child: Container(
            child: ListTile(
              title: Text('Modo oscuro'),
              subtitle: Text('Tema para sitios con poca luz. Consume menos energía.'),
              trailing: Switch(
                value: settings.nightMode,
                onChanged: (value) => settings.nightMode = value,
              ),
            ),
            padding: EdgeInsets.fromLTRB(0, 8, 0, 16),
          ),
          onTap: () => settings.nightMode = !settings.nightMode,
        ),
        SectionTitle('Avanzado'),
        InkWell(
          onTap: () {
            final engine = settings.engine == Engine.Firebase
                ? Engine.Amazon
                : Engine.Firebase;
            settings.engine = engine;
          },
          child: Container(
            child: ListTile(
              title: Text('Autenticación'),
              subtitle: Text('Proveedor de datos'),
              trailing: Container(
                height: 32,
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
                  onPressed: (int index) => settings.engine =
                      index == 0 ? Engine.Firebase : Engine.Amazon,
                  isSelected: [
                    settings.engine == Engine.Firebase,
                    settings.engine == Engine.Amazon
                  ],
                ),
              ),
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
      drawer: DrawerView(Routes.settingsRoute),
      appBar: appBar,
      body: body,
    );

  }
}
