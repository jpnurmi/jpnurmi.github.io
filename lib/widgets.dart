import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

import 'types.dart';

const kDelay = Duration(milliseconds: 750);
const kInterval = Duration(milliseconds: 100);

class FavoriteWidget extends StatelessWidget {
  const FavoriteWidget({
    super.key,
    required this.name,
    required this.icon,
    required this.url,
    required this.onLaunch,
  });

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
    super.key,
    required this.name,
    required this.icon,
    required this.url,
    required this.onLaunch,
  });

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
  double get height => mediaQuery.size.height;

  ThemeData get theme => Theme.of(this);
  Color get textColor => theme.hintColor;
  Color get iconColor => theme.colorScheme.primary;
  TextStyle get textStyle => theme.textTheme.headline6!;
}

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({
    super.key,
    required this.name,
    required this.image,
  });

  final String name;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FadeAnimation(
          delay: kDelay,
          child: SizedBox.square(
            dimension: 160,
            child: CircleAvatar(
              backgroundImage: AssetImage(image),
              backgroundColor: Color(0xff181a1b),
            ),
          ),
        ),
        FadeAnimation(
          delay: kDelay + kInterval,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(
              name,
              style: context.textStyle.apply(color: context.textColor),
            ),
          ),
        ),
      ],
    );
  }
}

class FavoriteListView extends StatelessWidget {
  const FavoriteListView({
    super.key,
    required this.items,
    required this.onLaunch,
  });

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
          for (var i = 0; i < items.length; ++i)
            FadeAnimation(
              delay: kDelay * 3 + kInterval * i,
              child: FavoriteWidget(
                name: items[i].name,
                icon: items[i].icon,
                url: items[i].url,
                onLaunch: () => onLaunch(items[i].url),
              ),
            ),
        ],
      ),
    );
  }
}

class SocialRow extends StatelessWidget {
  const SocialRow({
    super.key,
    required this.items,
    required this.onLaunch,
  });

  final List<ItemData> items;
  final LaunchCallback onLaunch;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        for (var i = 0; i < items.length; ++i)
          FadeAnimation(
            delay: kDelay * 2 + kInterval * i,
            child: SocialWidget(
              name: items[i].name,
              icon: items[i].icon,
              url: items[i].url,
              onLaunch: () => onLaunch(items[i].url),
            ),
          ),
      ],
    );
  }
}

enum FadeProperties { opacity, translate }

class FadeAnimation extends StatelessWidget {
  final Duration delay;
  final Duration duration;
  final double distance;
  final Widget child;

  const FadeAnimation({
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 175),
    this.distance = 25.0,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final tween = MultiTween<FadeProperties>()
      ..add(FadeProperties.opacity, 0.0.tweenTo(1.0), duration)
      ..add(FadeProperties.translate, distance.tweenTo(0.0), duration,
          Curves.easeOut);

    return PlayAnimation<MultiTweenValues<FadeProperties>>(
      delay: delay,
      duration: tween.duration,
      tween: tween,
      child: child,
      builder: (context, child, value) => Opacity(
        opacity: value.get(FadeProperties.opacity),
        child: Transform.translate(
          offset: Offset(0, value.get(FadeProperties.translate)),
          child: child,
        ),
      ),
    );
  }
}
