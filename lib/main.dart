import 'package:flutter/material.dart';
import 'screens/category_list_screen.dart';
import 'screens/favorites_screen.dart';
import 'services/firebase_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseService.init();

  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  final List<Widget> screens = [
    CategoryListScreen(),
    FavoritesScreen(),
  ];

  @override
  void initState() {
    super.initState();


    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("🔥 Foreground Notification Received!");
      print("Title: ${message.notification?.title}");
      print("Body: ${message.notification?.body}");


      if (mounted && message.notification != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              message.notification!.title ??
                  "New message from Recipe of the Day",
            ),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    });


    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("📩 User opened the app through a notification!");
      print("Title: ${message.notification?.title}");
      print("Body: ${message.notification?.body}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: screens[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Categories',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorite',
            ),
          ],
        ),
      ),
    );
  }
}
