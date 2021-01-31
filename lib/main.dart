import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:url_launcher/url_launcher.dart';

import 'items.dart';
import 'widgets.dart';

void main() {
  runApp(
    MaterialApp(
      home: Material(child: HomePage()),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SocialRow(
          items: socialItems,
          onLaunch: (url) => launch(url),
        ),
        ProfileWidget(
          name: 'J-P Nurmi',
          image: 'images/profile.png',
        ),
        FavoriteListView(
          items: favoriteItems,
          onLaunch: (url) => launch(url),
        ),
      ],
    );
  }
}
