import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SpacedListWidget extends StatelessWidget {
  final List<Widget> children;

  const SpacedListWidget({Key key, this.children}) : super(key: key);

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

class AppBarWidget extends StatelessWidget {
  final String title;
  final Widget child;

  const AppBarWidget({Key key, this.title, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
            style: GoogleFonts.openSans(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 28,
            ),
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
      ),
      body: child,
    );
  }
}

class AppBarListWidget extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const AppBarListWidget(
      {Key key, @required this.title, this.children = const []})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBarWidget(
      title: title,
      child: SpacedListWidget(children: children),
    );
  }
}
