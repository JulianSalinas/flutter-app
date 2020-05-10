import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:letsattend/blocs/settings_bloc.dart';
import 'package:letsattend/router/routes.dart';
import 'package:letsattend/views/drawer/drawer_option.dart';
import 'package:letsattend/views/settings/section_title.dart';
import 'package:letsattend/views/browser/browser_view.dart';
import 'package:letsattend/widgets/custom/formal_text.dart';
import 'package:letsattend/widgets/custom/colored_flex.dart';
import 'package:letsattend/views/drawer/drawer_view.dart';
import 'package:provider/provider.dart';

class AboutView extends StatefulWidget {
  @override
  _AboutViewState createState() => _AboutViewState();
}

class _AboutViewState extends State<AboutView> {

  @override
  Widget build(BuildContext context) {

    SettingsBloc settings = Provider.of<SettingsBloc>(context);

    final content = ListView(
      children: <Widget>[
        SectionTitle('Patrocinadores'),
        InkWell(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: DrawerOption(
              icon: Icon(FontAwesome.user_o),
              title: 'Greivin Ramírez',
            ),
          ),
          onTap: () => {},
        ),
        InkWell(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: DrawerOption(
              icon: Icon(Entypo.graduation_cap),
              title: 'Escuela de Matemática, ITCR',
            ),
          ),
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BrowserView(
                initialUrl: 'https://www.facebook.com/EDEPA-341307349313857',
              )),
          ),
        ),
        SectionTitle('Programadores'),
        InkWell(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: DrawerOption(
              icon: Icon(FontAwesome.user_circle),
              title: 'Julian Salinas',
            ),
          ),
          onTap: () => {},
        ),
        Divider(height: 1, thickness: 1,),
        InkWell(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: DrawerOption(
              icon: Icon(FontAwesome.user_circle_o),
              title: 'Brandon Dinarte',
            ),
          ),
          onTap: () => {},
        ),
        SectionTitle('Versión de la Aplicación'),
        Padding(
          padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: DrawerOption(
            icon: Icon(Icons.android),
            title: 'Versión 2.0.0',
          ),
        ),
        Divider(height: 1, thickness: 1,),
        InkWell(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: DrawerOption(
              icon: Icon(AntDesign.github),
              title: 'Repositorio en Github',
            ),
          ),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BrowserView(
              initialUrl: 'https://github.com/JulianSalinas/edepa-app/blob/master/README.md',
            )),
          ),
        ),
        Divider(height: 1, thickness: 1,),
        InkWell(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: DrawerOption(
              icon: Icon(Icons.message),
              title: 'Envíanos un comentario',
            ),
          ),
          onTap: () => {},
        ),
        Divider(height: 1, thickness: 1,),
        InkWell(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: DrawerOption(
              icon: Icon(Entypo.google_play, color: Color(0xFF4DB6AC),),
              title: 'Puntúanos en Google Play',
            ),
          ),
          onTap: () => {},
        ),
      ],
    );

    final body = Container(
      child: content,
    );

    final appBar = AppBar(
      title: FormalText('Acerca de'),
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      flexibleSpace: ColoredFlex(),
    );

    return Scaffold(
      drawer: DrawerView(Routes.aboutRoute),
      appBar: appBar,
      body: body,
    );
  }
}
