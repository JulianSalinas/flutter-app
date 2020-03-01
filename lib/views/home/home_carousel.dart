import 'package:flutter/cupertino.dart';
import 'package:letsattend/locator.dart';
import 'package:letsattend/models/post.dart';
import 'package:letsattend/services/news_service.dart';
import 'package:letsattend/blocs/auth_bloc.dart';
import 'package:letsattend/blocs/news_bloc.dart';
import 'package:letsattend/views/home/home_circle.dart';
import 'package:letsattend/views/home/home_option.dart';
import 'package:letsattend/views/news/news_view.dart';
import 'package:letsattend/views/news/post_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'package:letsattend/router/router.dart';
import 'package:letsattend/shared/colors.dart';
import 'package:letsattend/views/drawer/drawer_view.dart';
import 'package:letsattend/blocs/settings_bloc.dart';

class CarouselOption  {

  final String name;
  final String image;
  final Function onTap;

  CarouselOption({this.name, this.image, this.onTap});

}

class HomeCarousel extends StatefulWidget {
  @override
  HomeCarouselState createState() => HomeCarouselState();
}

/// A simple colored screen with a centered text
class HomeCarouselState extends State<HomeCarousel> {

  final options = <CarouselOption> [
    CarouselOption(
      name: 'Cronograma',
      image: 'assets/business_planning.png',
      onTap: () {},
    ),
    CarouselOption(
      name: 'Expositores',
      image: 'assets/Man_phone.png',
      onTap: () {},
    ),
    CarouselOption(
      name: 'Mensajes',
      image: 'assets/lecture_preview.jpg',
      onTap: () {},
    ),
    CarouselOption(
      name: 'Configuración',
      image: 'assets/Fine-tune.png',
      onTap: () {},
    ),
  ];

  @override
  Widget build(BuildContext context) {

    final optionsList = ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: options.length,
      itemBuilder: (_, index) => buildOption(_, index, options[index]),
      separatorBuilder: (_, index) => SizedBox(width: 16),
    );

    final optionsContainer = Container(
      height: 200,
      alignment: Alignment.center,
      child: optionsList,
    );

    return optionsContainer;
  }

  Widget buildOption(BuildContext context, int index, CarouselOption option) {
    return Container(
      padding: EdgeInsets.only(
        left: index == 0 ? 16 : 0,
        right: index == options.length - 1 ? 16 : 0,
        bottom: 20,
      ),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
              child: Image.asset(
                option.image,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(12),
                  ),
                ),
                padding: EdgeInsets.all(16),
                child: Text(
                  option.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
