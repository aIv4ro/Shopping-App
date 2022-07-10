import 'package:flutter/widgets.dart';
import 'package:shopping/pages/login/login_page.dart';
import 'package:shopping/routes/paths.dart';

final routes = <String, WidgetBuilder>{
  login: (context) {
    return const LoginPage();
  }
};