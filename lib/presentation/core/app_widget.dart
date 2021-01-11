import 'package:ar_post/presentation/nav/navigation_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ArCore",
      theme: ThemeData(
        primaryColor: const Color(0xFF5C178B),
        textTheme: GoogleFonts.openSansTextTheme(),
        tabBarTheme: TabBarTheme(
          labelColor: Theme.of(context).primaryColor,
          unselectedLabelColor: Theme.of(context).accentColor,
          indicatorSize: TabBarIndicatorSize.label,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedIconTheme: IconThemeData(size: 32),
          unselectedIconTheme: IconThemeData(size: 28),
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)
        ),
      ),
      home: const NavigationWidget(),
    );
  }
}
