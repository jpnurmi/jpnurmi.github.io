import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:url_launcher/url_launcher.dart';

import 'items.dart';
import 'widgets.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'J-P Nurmi',
      home: Material(
        child: Banner(
          message: 'Powered by Flutter',
          location: BannerLocation.bottomEnd,
          textStyle: TextStyle(fontSize: 8, color: Colors.white),
          child: HomePage(),
        ),
      ),
      theme: ThemeData.dark(),
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
