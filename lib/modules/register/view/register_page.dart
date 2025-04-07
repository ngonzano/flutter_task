import 'package:flutter/material.dart';
import 'package:flutter_task/core/auth/repository/user_repository.dart';
import 'package:flutter_task/core/network/api_service.dart';
import 'package:flutter_task/modules/register/controller/register_controller.dart';
import 'package:flutter_task/modules/register/view/register_view.dart';

import 'package:flutter_task/shared/widget/app_scaffold.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  factory RegisterPage.routeBuilder(_, __) {
    return RegisterPage(key: const Key('register_page'));
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RegisterController>(
      create:
          (_) => RegisterController(
            userRepository: UserRepository(apiService: ApiService()),
          ),
      child: AppScaffold(body: RegisterView()),
    );
  }
}
