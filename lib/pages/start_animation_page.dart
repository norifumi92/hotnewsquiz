import 'package:flutter/material.dart';
import 'dart:async';
import 'quiz_page.dart';

class StartAnimationPage extends StatefulWidget {
  @override
  _StartAnimationPageState createState() => _StartAnimationPageState();
}

class _StartAnimationPageState extends State<StartAnimationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  bool _isReady = true;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );

    // Define the scale animation from 0.5 to 1.0
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.5),
      ),
    );

    // Define the opacity animation from 1.0 to 0.0
    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.5, 1.0),
      ),
    );

    // Add a status listener to the animation controller to listen for changes in the animation state
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Trigger the navigation to the next page when the animation completes
        _navigateToNextPage();
      }
    });

    // Start the animation timer on widget initialization
    Timer(Duration(seconds: 1), () {
      setState(() {
        _isReady = false;
        // Start the animation when the "Go" text appears
        _controller.forward();
      });
    });
  }

  @override
  void dispose() {
    // Dispose the animation controller when the widget is removed from the tree
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Page'),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Opacity(
              opacity: _opacityAnimation.value,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: child,
              ),
            );
          },
          child: _isReady
              ? Text(
                  'Ready?',
                  key: Key('readyKey'),
                  style: TextStyle(fontSize: 72),
                )
              : Text(
                  'Go!',
                  key: Key('goKey'),
                  style: TextStyle(fontSize: 72),
                ),
        ),
      ),
    );
  }

  void _navigateToNextPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => QuizPage()),
    );
  }

  void _onAnimationComplete() {
    // Navigate to the next page when the animation completes
    _navigateToNextPage();
  }
}
