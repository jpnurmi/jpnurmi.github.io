import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'types.dart';

class FavoriteWidget extends StatelessWidget {
  const FavoriteWidget({
    Key key,
    @required this.name,
    @required this.icon,
    @required this.url,
    @required this.onLaunch,
  }) : super(key: key);

  final String name;
  final String icon;
  final String url;
  final VoidCallback onLaunch;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Tooltip(
        message: name,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            child: Image.asset('icons/$icon.png'),
            onTap: () => onLaunch(),
          ),
        ),
      ),
    );
  }
}

class SocialWidget extends StatelessWidget {
  const SocialWidget({
    Key key,
    @required this.name,
    @required this.icon,
    @required this.url,
    @required this.onLaunch,
  }) : super(key: key);

  final String name;
  final IconData icon;
  final String url;
  final VoidCallback onLaunch;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Tooltip(
        message: name,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => onLaunch(),
            child: Icon(icon, color: context.iconColor),
          ),
        ),
      ),
    );
  }
}

extension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get size => mediaQuery.size;
  double get width => size.width;
  double get height => size.height;

  ThemeData get theme => Theme.of(this);
  Color get textColor => theme.hintColor;
  Color get iconColor => theme.buttonColor;
  TextStyle get textStyle => theme.textTheme.headline6;
}

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({
    Key key,
    @required this.name,
    @required this.image,
  }) : super(key: key);

  final String name;
  final String image;

  @override
  Widget build(BuildContext context) {
    final double size = math.min(context.width / 5 * 4, context.height / 2);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: size,
          height: size,
          child: Image.asset(image),
        ),
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(
            name,
            style: context.textStyle.apply(color: context.textColor),
          ),
        ),
      ],
    );
  }
}

class FavoriteListView extends StatelessWidget {
  const FavoriteListView({
    Key key,
    @required this.items,
    @required this.onLaunch,
  }) : super(key: key);

  final List<ItemData> items;
  final LaunchCallback onLaunch;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (context.height / 8.0).clamp(64.0, 128.0),
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: [
          for (final item in items)
            FavoriteWidget(
              name: item.name,
              icon: item.icon,
              url: item.url,
              onLaunch: () => onLaunch(item.url),
            ),
        ],
      ),
    );
  }
}

class SocialRow extends StatelessWidget {
  const SocialRow({
    Key key,
    @required this.items,
    @required this.onLaunch,
  }) : super(key: key);

  final List<ItemData> items;
  final LaunchCallback onLaunch;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        for (final item in items)
          SocialWidget(
            name: item.name,
            icon: item.icon,
            url: item.url,
            onLaunch: () => onLaunch(item.url),
          ),
      ],
    );
  }
}
