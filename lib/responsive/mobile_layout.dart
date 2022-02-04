import 'package:flutter/material.dart';
import 'package:instagram_fullstack_clone/utils/colors.dart';

class MobileLayout extends StatefulWidget {
  const MobileLayout({Key? key}) : super(key: key);

  @override
  State<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout> {
  // ? initState
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  
  void navigationTapped(int pageIndex) => _pageController.jumpToPage(pageIndex);

  // setting _currentIndex here is better "if" you want to swipe besides using the navigation bar
  void _onPageChanged(int pageIndex) =>
      setState(() => _currentIndex = pageIndex);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          Center(child: Text('home')),
          Center(child: Text('search')),
          Center(child: Text('upload')),
          Center(child: Text('favorite')),
          Center(child: Text('profile')),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: mobileBackgroundColor,
        selectedItemColor: primaryColor,
        currentIndex: _currentIndex,
        onTap: navigationTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),
    );
  }
}
