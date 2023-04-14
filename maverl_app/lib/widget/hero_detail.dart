import 'package:flutter/material.dart';
import '../podo/Hero.dart';
import 'hero_avatar.dart';


class SuperHero extends StatelessWidget {
  final Heros hero;

  SuperHero({
    Key? key,
    required this.hero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return InkWell(
      // onTap: () {
      //   var router = new MaterialPageRoute(builder: (BuildContext context) {
      //     return Details(
      //       hero: hero,
      //     );
      //   });

      //   Navigator.of(context).push(router);
      // },
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  width: 12.0,
                ),
                Hero(
                  tag: hero.id,
                  child: HeroAvatar(img: hero.thumbnailUrl),
                ),
                const SizedBox(
                  width: 24.0,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        hero.name,
                        style: textTheme.titleLarge,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}