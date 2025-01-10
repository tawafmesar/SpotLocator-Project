import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AnimatedImageSwitcher extends StatefulWidget {
  final String networkImageUrl;
  final String assetImagePath;
  final Color backgroundColor;

  const AnimatedImageSwitcher({
    Key? key,
    required this.networkImageUrl,
    required this.assetImagePath,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  _AnimatedImageSwitcherState createState() => _AnimatedImageSwitcherState();
}

class _AnimatedImageSwitcherState extends State<AnimatedImageSwitcher> {
  bool _showNetworkImage = true;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    // Initialize the timer to toggle the image every 3 seconds
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer t) {
      setState(() {
        _showNetworkImage = !_showNetworkImage;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: _showNetworkImage
          ? Container(
              key: const ValueKey('networkImage'),
              color: widget.backgroundColor,
              child: CachedNetworkImage(
                height: 150,
                width: 150,
                fit: BoxFit.cover,
                imageUrl: widget.networkImageUrl,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(
                  Icons.error,
                  size: 30,
                  color: Colors.red,
                ),
              ),
            )
          : Container(
              key: const ValueKey('assetImage'),
              color: widget.backgroundColor,
              child: Image.asset(
                widget.assetImagePath,
                height: 150,
                width: 150,
                fit: BoxFit.cover,
              ),
            ),
    );
  }
}
