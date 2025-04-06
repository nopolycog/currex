import 'package:auto_route/auto_route.dart';
import 'package:currex/ui/router/router.gr.dart';
import 'package:flutter/material.dart';

@RoutePage()
class TabBarScreen extends StatefulWidget {
  const TabBarScreen({super.key});

  @override
  State<TabBarScreen> createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen> {
  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [RatesRoute(), ConvertRoute()],
      transitionBuilder: (context, child, animation) => FadeTransition(opacity: animation, child: child),
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          body: child,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: tabsRouter.activeIndex,
            onTap: tabsRouter.setActiveIndex,
            items: const [
              BottomNavigationBarItem(label: 'Rates', icon: Icon(Icons.paid_outlined)),
              BottomNavigationBarItem(label: 'Convert', icon: Icon(Icons.swap_horiz_rounded)),
            ],
          ),
        );
      },
    );
  }
}
