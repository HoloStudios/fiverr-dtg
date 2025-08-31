import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:discover_the_gospel/sharedstate.dart';
import 'package:flutter/services.dart';


// Import screens
import 'package:discover_the_gospel/gui/screens/navigation/pdf.dart';
import 'package:discover_the_gospel/gui/screens/navigation/share.dart';
import 'package:discover_the_gospel/gui/screens/navigation/youtube.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(const NavigationBarApp());
}

// Root application
class NavigationBarApp extends StatelessWidget {
  const NavigationBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Playfair",
        brightness: Brightness.dark,
        colorScheme: ColorScheme.dark(
          primary: Color.fromRGBO(50, 50, 50, 1),
          inversePrimary: Color.fromRGBO(89, 89, 89, 1),
          secondary: Color.fromRGBO(250,237,218, 1),
          primaryContainer: Color.fromRGBO(17, 17, 17, 1),
          secondaryContainer: Color.fromRGBO(32, 32, 32, 1),
        ),
        textTheme: TextTheme(
          
        )
      ),

      home: NavigationController()
    );
  }
}

// Navigation Controller
class NavigationController extends StatefulWidget {
  const NavigationController({super.key});

  @override
  State<NavigationController> createState() => _NavigationControllerState();
}

// Navigation bar
class _NavigationControllerState extends State<NavigationController> {
  int currentPageIndex = 0;
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return _buildNavbar(context);
  }

  Widget _buildNavbar(context) {
    bool isiOS = Theme.of(context).platform == TargetPlatform.iOS;
    final ThemeData theme = Theme.of(context);

    return isiOS 
      // iOS
      ? iosNavbar(theme)
      // Android
      : androidNavbar(theme);
  }

  // iOS navbar
  Widget iosNavbar(theme) {
    return ValueListenableBuilder<bool>(
      valueListenable: showNavBar,
      builder: (context, visible, _) {
        double navHeight = MediaQuery.of(context).size.height * 0.1;

        return Column(
          children: [
            Expanded(
              child: PageView(
                controller: pageController,
                onPageChanged: (index) {
                  setState(() {
                    currentPageIndex = index;
                  });
                },
                children: [
                  PDFPage(),
                  YoutubePage(),
                  SharePage(),
                ],
              ),
            ),
            SizedBox(
              height: visible ? navHeight : 0,
              child: CupertinoTabBar(
                currentIndex: currentPageIndex,
                onTap: (index) {
                  setState(() {
                    currentPageIndex = index;
                    pageController.jumpToPage(currentPageIndex);
                  });
                },
                backgroundColor: visible ? theme.colorScheme.primaryContainer : Colors.transparent,
                activeColor: Colors.blueAccent,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.book),
                    activeIcon: Icon(CupertinoIcons.book_fill),
                    label: 'Read',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.videocam),
                    activeIcon: Icon(CupertinoIcons.videocam_fill),
                    label: 'YouTube',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.paperplane),
                    label: 'Share',
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  Widget androidNavbar(theme) {
    return ValueListenableBuilder<bool>(
      valueListenable: showNavBar,
      builder: (context, visible, _) {
        double navHeight = MediaQuery.of(context).size.height * 0.1;

        return AnimatedContainer(
          duration: Duration(milliseconds: 300),
          height: visible ? navHeight : 0.0,

          child: Scaffold(
            bottomNavigationBar: SafeArea(
              child: NavigationBar(
                height: visible ? navHeight : 0.0,
                onDestinationSelected: (int index) {
                  setState(() {
                    currentPageIndex = index;
                    pageController.jumpToPage(index);
                  });
                },
                backgroundColor: theme.colorScheme.primaryContainer,
                indicatorColor: Colors.blueAccent,
                selectedIndex: currentPageIndex,
                destinations: const <Widget>[
                  NavigationDestination(
                    selectedIcon: Icon(Icons.book),
                    icon: Icon(Icons.book_outlined),
                    label: 'Read',
                  ),
                  NavigationDestination(
                    selectedIcon: Icon(Icons.videocam),
                    icon: Icon(Icons.videocam_outlined),
                    label: 'Watch',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.share),
                    label: 'Share',
                  ),
                ],
              ),
            ),

            // Use PageView for swipe gestures
            body: PageView(
              controller: pageController,
              onPageChanged: (index) {
                setState(() {
                  currentPageIndex = index;
                });
              },
              children: [
                PDFPage(),
                YoutubePage(),
                SharePage(),
              ],
            ),
          ),
        );
      },
    );
  }
}