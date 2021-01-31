import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:url_launcher/url_launcher.dart';

const assets = <String>['cpp.svg', 'dart.png', 'flutter.png'];

class SocialItem {
  final IconData icon;
  final String url;
  const SocialItem({this.icon, this.url});
}

const kGithubUrl = 'https://www.github.com/jpnurmi';
const kLinkedInUrl = 'https://www.linkedin.com/in/jpnurmi';
const kTwitterUrl = 'https://www.twitter.com/jpnurmi';
const kEmailUrl = 'mailto:jpnurmi@gmail.com';

const socialItems = <SocialItem>[
  SocialItem(icon: FlutterIcons.github_face_mco, url: kGithubUrl),
  SocialItem(icon: FlutterIcons.linkedin_mco, url: kLinkedInUrl),
  SocialItem(icon: FlutterIcons.twitter_mco, url: kTwitterUrl),
  SocialItem(icon: FlutterIcons.email_mco, url: kEmailUrl),
];

void main() {
  runApp(MaterialApp(home: HomePage(), debugShowCheckedModeBanner: false));
}

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (final item in socialItems) SocialWidget(item: item),
          ],
        ),
      ],
    );
  }
}

class SocialWidget extends StatelessWidget {
  const SocialWidget({
    Key key,
    @required this.item,
  }) : super(key: key);

  final SocialItem item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => launch(item.url),
          child: Icon(item.icon, color: Colors.grey),
        ),
      ),
    );
  }
}
