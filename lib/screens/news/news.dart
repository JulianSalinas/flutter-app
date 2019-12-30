import 'package:flutter/material.dart';
import 'package:letsattend/models/post.dart';
import 'package:letsattend/models/preview.dart';
import 'package:letsattend/screens/news/news_item.dart';
import 'package:letsattend/shared/switch/night_switch.dart';
import 'package:letsattend/shared/text/modern_text.dart';
import 'package:lipsum/lipsum.dart' as lipsum;

class News extends StatefulWidget {

  @override
  NewsState createState() => NewsState();

}

/// A simple colored screen with a centered text
class NewsState extends State<News> {

  List<Post> news = <Post>[];

  @override
  void initState() {
    super.initState();

    news.add(Post(
      title: 'Mapa del Instituto Tecnológico',
      description: 'Una ayuda para encontrar los lugares que vayas a visitar (Toca la imagen)',
      preview: Preview(
        image: 'https://res.cloudinary.com/edepa/image/upload/v1541644312/Edepa/Mapa_actualizado.png'
      ),
    ));

    news.add(Post(
      title: 'Encontranos en Facebook',
      description: 'Podés ver más información en esta red social',
      timestamp: DateTime.now().add(Duration(hours: 5)),
      preview: Preview(
        thumbnail: 'https://res.cloudinary.com/edepa/image/upload/v1534730979/Logos/facebook.png',
        url: 'https://www.facebook.com/EDEPA-341307349313857/',
        title: 'Congreso en Facebook',
        description: lipsum.createSentence(numSentences: 2),
      ),
    ));

    news.add(Post(
      title: 'Nuestro video en Youtube',
      description: lipsum.createSentence(),
      timestamp: DateTime.now().add(Duration(hours: 3)),
      preview: Preview(
        image: 'https://somoskudasai.com/wp-content/uploads/2018/10/touhou-cannonball-1620x800.jpg',
      )
    ));

    news.add(Post(
        title: 'Bienvenidos al congreso',
        description: lipsum.createSentence(),
        timestamp: DateTime.now(),
        preview: Preview(
          thumbnail: 'https://cdn.dribbble.com/users/1303572/screenshots/5788082/mobile_cms_2x.png',
          url: 'https://worldvectorlogo.com/es/logo/angular-icon',
          description: 'Esto es una pequeña descripcion de la preview',
          title: 'Regitrate en esta wea'
        )
    ));

  }

  Widget buildItem(BuildContext context, int i){

    if (i.isOdd) return Divider(height: 16);

    final index = i ~/ 2;

    return NewsItem(post: news[index]);
  }

  @override
  Widget build(BuildContext context) {

    final listView = ListView.builder(
      padding:  EdgeInsets.fromLTRB(10, 16, 16, 16),
      itemBuilder: buildItem,
      itemCount: news.length * 2 - 1, // 1 reserved for dividers
    );

    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(child: listView,),
          NightSwitch(),
        ],
      ),
      appBar: AppBar(
        title: ModernText('Noticias', color: Colors.white,),
        centerTitle: true,
      ),
    );

  }
}
