import 'package:flutter/material.dart';
import 'package:Todos/core/theme/base_color.dart';
import 'package:Todos/core/widgets/fab_homepage.dart';
import 'package:Todos/core/widgets/fab_profile_page.dart';
import 'package:Todos/feat/screens/home_page.dart';
import 'package:Todos/feat/screens/profile_page.dart';

class PersistentBottomNavPage extends StatelessWidget {
  static const routeName = "/home_page"; // akses homepage via navbar
  final _tab1navigatorKey = GlobalKey<NavigatorState>();
  final _tab2navigatorKey = GlobalKey<NavigatorState>();

  PersistentBottomNavPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PersistentBottomBarScaffold(
      items: [
        PersistentTabItem(
          tab: const HomePage(),
          icon: Icons.home_rounded,
          title: 'Home',
          navigatorkey: _tab1navigatorKey,
        ),
        PersistentTabItem(
          tab: const ProfilePage(),
          icon: Icons.person,
          title: 'Profile',
          navigatorkey: _tab2navigatorKey,
        ),
      ],
    );
  }
}

class PersistentBottomBarScaffold extends StatefulWidget {
  final List<PersistentTabItem> items;

  const PersistentBottomBarScaffold({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  State<PersistentBottomBarScaffold> createState() =>
      _PersistentBottomBarScaffoldState();
}

class _PersistentBottomBarScaffoldState
    extends State<PersistentBottomBarScaffold> {
  int _selectedTab = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double bottomPadding = MediaQuery.of(context).padding.bottom;
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedTab = index;
          });
        },
        children: const [HomePage(), ProfilePage()],
      ),
      extendBody: true,
      bottomNavigationBar: Stack(
        clipBehavior: Clip.none,
        alignment: const Alignment(0, 1),
        children: [
          _buildBottomNavigationBar(bottomPadding),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Center(
              child: _selectedTab == 0 ? FABHomePage() : const FABProfilePage(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar(double bottomPadding) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildNavItem(Icons.home_rounded, 'Home', 0),
          const SizedBox(width: 10),
          _buildNavItem(Icons.person, 'Profile', 1),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String title, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTab = index;
          _pageController.jumpToPage(index);
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon,
              color: _selectedTab == index ? BaseColors.purple : Colors.grey),
          Text(
            title,
            style: TextStyle(
                color: _selectedTab == index ? BaseColors.purple : Colors.grey),
          ),
        ],
      ),
    );
  }
}

class PersistentTabItem {
  final Widget tab;
  final GlobalKey<NavigatorState>? navigatorkey;
  final String title;
  final IconData icon;

  PersistentTabItem(
      {required this.tab,
      this.navigatorkey,
      required this.title,
      required this.icon});
}
