import 'package:flutter/material.dart';
import 'package:flutter_task/core/config/color/app_color_scheme.dart';
import 'package:flutter_task/core/constants/routes.dart' show Routes;
import 'package:flutter_task/modules/home/controller/home_controller.dart';
import 'package:flutter_task/modules/home/widget/widget.dart' show ItemMenu;
import 'package:flutter_task/shared/controller/base_controller.dart';
import 'package:go_router/go_router.dart';

class DrawerContent extends StatelessWidget {
  const DrawerContent({super.key, required this.con});
  final HomeController con;

  @override
  Widget build(BuildContext context) {
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;

    if (isIOS) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ItemMenu(
            title: 'Dashboard',
            onTap: () {
              context.go(
                Routes.dashboard.description,
                extra: con.listTaskDashboard,
              );
            },
          ),
          ItemMenu(
            title: context.loc.setting,
            onTap: () {
              context.go(Routes.setting.description);
            },
          ),
        ],
      );
    } else {
      return ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: AppColorScheme.of(context).primary,
            ),
            child: Text(
              'Menú',
              style: TextStyle(
                color: AppColorScheme.of(context).secundary,
                fontSize: 24,
              ),
            ),
          ),

          ItemMenu(
            title: 'Dashboard',
            onTap: () {
              context.go(
                Routes.dashboard.description,
                extra: con.listTaskDashboard,
              );
            },
          ),
          ItemMenu(
            title: context.loc.setting,
            onTap: () {
              context.go(Routes.setting.description);
            },
          ),
        ],
      );
    }
  }
}
