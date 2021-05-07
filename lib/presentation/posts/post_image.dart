import 'package:flutter/material.dart';

class PostImage extends StatelessWidget {
  final String imageUrl;

  const PostImage({Key key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}
