import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContentContainerWidget extends StatelessWidget {
  final List<Widget> children;

  const ContentContainerWidget({Key key, this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 32.0),
        ...children
            .map((e) => Padding(
                  padding: const EdgeInsets.only(bottom: 32),
                  child: e,
                ))
            .toList(),
      ],
    );
  }
}

class CustomAppBarWidget extends StatelessWidget {
  final String title;
  final Widget child;

  const CustomAppBarWidget({Key key, this.title, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
            style: GoogleFonts.openSans(
                color: Colors.black, fontWeight: FontWeight.w600, fontSize: 28),
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
      ),
      body: child,
    );
  }
}

class AppBarWidget extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const AppBarWidget({Key key, @required this.title, this.children = const []})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomAppBarWidget(
      title: title,
      child: ContentContainerWidget(children: children),
    );
  }
}
