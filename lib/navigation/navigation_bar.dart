import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_navigation_system_flutter/navigation/bloc.dart';
import 'package:go_router_navigation_system_flutter/navigation/events.dart';
import 'package:go_router_navigation_system_flutter/navigation/state.dart';
import 'package:go_router_navigation_system_flutter/screens/home.dart';
import 'package:go_router_navigation_system_flutter/screens/profile.dart';

class ScaffoldWithNavigation extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const ScaffoldWithNavigation({
    required this.navigationShell,
    super.key,
  });

  @override
  State<ScaffoldWithNavigation> createState() => _ScaffoldWithNavigationState();
}

class _ScaffoldWithNavigationState extends State<ScaffoldWithNavigation> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController =
        PageController(initialPage: widget.navigationShell.currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavigationBloc(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: BlocListener<NavigationBloc, NavigationState>(
              listener: (context, state) {
                final index = NavigationTab.values.indexOf(state.currentTab);
                print(state.currentTab);
                // TODO: fix this animation. It doesn't look good.
                // reffer whatsapp app to take a look of what we want.
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.easeInOut,
                );
                widget.navigationShell.goBranch(index);
              },
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  context.read<NavigationBloc>().add(
                        NavigationTabChanged(NavigationTab.values[index]),
                      );
                },
                // TODO: I have tried to take the chidren from the navigationShell, but it doesn't work
                children: const [
                  HomePage(),
                  ProfilePage(),
                ],
              ),
            ),
            bottomNavigationBar: NavigationBar(
              selectedIndex: widget.navigationShell.currentIndex,
              onDestinationSelected: (index) {
                context.read<NavigationBloc>().add(
                      NavigationTabChanged(NavigationTab.values[index]),
                    );
              },
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
