import 'package:flutter/material.dart';

class DrawerOption extends StatelessWidget {

  const DrawerOption({
    Key key,
    @required this.icon,
    @required this.title,
    this.showBadge = false,
    this.route,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final bool showBadge;
  final String route;

  @override
  Widget build(BuildContext context) {

    final TextStyle tStyle = TextStyle(fontSize: 16.0);

    return InkWell(
      onTap: () {
        Navigator.pop(context);
        if(route != null)
          Navigator.pushReplacementNamed(context, route);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 6.0),
        child: Row(children: [
          Icon(
            icon,
          ),
          SizedBox(width: 12.0),
          Text(
            title,
            style: tStyle,
          ),
          Spacer(),
          if (showBadge)
            Material(
              color: Colors.deepOrange,
              elevation: 5.0,
              shadowColor: Colors.red,
              borderRadius: BorderRadius.circular(5.0),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.deepOrange,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Text(
                  '+15',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
        ]),
      ),
    );
  }
}
