import 'package:flutter/material.dart';
import '../../../core/constant/imageasset.dart';

class LogoAuth extends StatefulWidget {
  const LogoAuth({Key? key}) : super(key: key);

  @override
  State<LogoAuth> createState() => _LogoAuthState();
}

class _LogoAuthState extends State<LogoAuth> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _visible = true;
        });
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 800),
      opacity: _visible ? 1.0 : 0.0,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.6,
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10.0,
                spreadRadius: 2.0,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Image.asset(
            AppImageAsset.logo,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
