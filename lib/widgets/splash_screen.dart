import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    Key? key, required this.navigateAfterFuture, this.showLoading = false,
    required this.logo, this.logoSize = const Size(200, 200)
  }) : super(key: key);

  /// returns the path of the destination page
  final Future<String> Function() navigateAfterFuture;
  final bool showLoading;
  final Image logo;
  final Size logoSize;

  @override
  State<StatefulWidget> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    widget.navigateAfterFuture().then((path) {
      Navigator.of(context).pushReplacementNamed(path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: widget.logoSize.width,
                height: widget.logoSize.height,
                child: widget.logo,
              ),
              if(widget.showLoading)
                const CircularProgressIndicator()
            ],
          ),
        )
    );
  }
}
