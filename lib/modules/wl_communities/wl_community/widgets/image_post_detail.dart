import 'package:flutter/material.dart';

class MyImageDetial extends StatelessWidget {
  final String id;
  final Widget image;

  const MyImageDetial({
    super.key,
    required this.id,
    required this.image,
  });

  /// image bubble builder method
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * .9,
          maxHeight: MediaQuery.of(context).size.height * .5),
      child: GestureDetector(
        child: Hero(
          tag: id,
          child: image,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) {
                return DetailScreen(
                  tag: id,
                  image: image,
                );
              },
            ),
          );
        },
      ),
    );
  }
}

/// detail screen of the image, display when tap on the image bubble
class DetailScreen extends StatefulWidget {
  final String tag;
  final Widget image;

  const DetailScreen({super.key, required this.tag, required this.image});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

/// created using the Hero Widget
class _DetailScreenState extends State<DetailScreen> {
  @override
  initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Hero(
              tag: widget.tag,
              child: widget.image,
            ),
          ),
        ),
      ),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }
}
