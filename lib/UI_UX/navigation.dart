import 'package:cuancerdas/my_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:navigation_view/item_navigation_view.dart';
import 'package:navigation_view/navigation_view.dart';

class AppBBN extends StatelessWidget {
  const AppBBN({
    super.key,
    // required this.func,
    required bool atBottom,
  }) : _atBottom = atBottom;

  // final Function(int) func;
  final bool _atBottom;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MyController());
    final ThemeData theme = Theme.of(context);

    return NavigationView(
      
      onChangePage: (c){
        controller.setDisplay(c);
      },
      curve: Curves.fastEaseInToSlowEaseOut,
      durationAnimation: const Duration(milliseconds: 400),
      backgroundColor: Color.fromARGB(255, 32, 41, 54),
      borderTopColor: Theme.of(context).brightness == Brightness.light
          ? _atBottom
              ? theme.primaryColor
              : null
          : null,
      color: Color.fromARGB(255, 0, 83, 151),
      items: [
        ItemNavigationView(
            childAfter: Icon(
              IconlyBold.profile,
              color: Color.fromARGB(255, 0, 83, 151),
              size: 35,
            ),
            childBefore: Icon(
              IconlyBroken.profile,
              color: Colors.white,
              size: 30,
            )),
        ItemNavigationView(
            childAfter: Icon(
              IconlyBold.chat,
              color: Color.fromARGB(255, 0, 83, 151),
              size: 35,
            ),
            childBefore: Icon(
              IconlyBroken.chat,
              color: Colors.white,
              size: 30,
            )),
        ItemNavigationView(
            childAfter: Icon(
              IconlyBold.buy,
              color: Color.fromARGB(255, 0, 83, 151),
              size: 45,
            ),
            childBefore: Icon(
              IconlyBroken.buy,
              color: Colors.white,
              size: 40,
            )),
        ItemNavigationView(
            childAfter: Icon(
              IconlyBold.category,
              color: Color.fromARGB(255, 0, 83, 151),
              size: 35,
            ),
            childBefore: Icon(
              IconlyBroken.category,
              color: Colors.white,
              size: 30,
            )),
        ItemNavigationView(
            childAfter: Icon(
              IconlyBold.home,
              color: Color.fromARGB(255, 0, 83, 151),
              size: 35,
            ),
            childBefore: Icon(
              IconlyBroken.home,
              color:Colors.white,
              size: 30,
            )),
      ],
    );
  }
}

class AppFaderEffect extends StatelessWidget {
  const AppFaderEffect({
    super.key,
    required bool atBottom,
  }) : _atBottom = atBottom;

  final bool _atBottom;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: AnimatedOpacity(
        opacity: _atBottom ? 1 : 0,
        duration: const Duration(milliseconds: 400),
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              end: Alignment.topCenter,
              begin: Alignment.bottomCenter,
              colors: [
                      Colors.indigo.withOpacity(0.8),
                      Colors.indigo.withOpacity(0.6),
                      Colors.indigo.withOpacity(0.4),
                      Colors.indigo.withOpacity(0.2),
                      Colors.transparent,
                    ],
                  // : [
                  //     Colors.red.withOpacity(0.8),
                  //     Colors.red.withOpacity(0.6),
                  //     Colors.red.withOpacity(0.4),
                  //     Colors.red.withOpacity(0.2),
                  //     Colors.transparent,
                  //   ],
              stops: const [0.1, 0.3, 0.5, 0.7, 1.0],
            ),
          ),
        ),
      ),
    );
  }
}
