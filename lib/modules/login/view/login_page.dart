import 'package:flutter/material.dart';
import 'package:flutter_task/modules/login/view/login_view.dart';
import 'package:flutter_task/shared/widget/app_scaffold.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  factory LoginPage.routeBuilder(_, __) {
    return LoginPage(key: const Key('login_page'));
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(body: LoginView());
  }
}
