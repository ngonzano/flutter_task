import 'package:flutter/material.dart';
import 'package:flutter_task/core/config/color/app_colors.dart';
import 'package:flutter_task/modules/dashboard/widget/donutChartPainter.dart';
import 'package:flutter_task/modules/home/models/task_model.dart';
import 'package:flutter_task/shared/controller/base_controller.dart';
import 'package:flutter_task/shared/widget/app_scaffold.dart';
import 'package:go_router/go_router.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key, required this.listTaskModel});

  factory DashboardPage.routeBuilder(_, GoRouterState state) {
    final listTaskModel = state.extra as List<TaskModel>;
    return DashboardPage(
      key: const Key('dashboard_page'),
      listTaskModel: listTaskModel,
    );
  }

  final List<TaskModel> listTaskModel;

  @override
  Widget build(BuildContext context) {
    final completed = listTaskModel.where((t) => t.completed == 1).length;
    final percent =
        listTaskModel.isEmpty ? 0.0 : completed / listTaskModel.length;

    return AppScaffold(
      title: Text('Dashboard'),
      onBackPressed: context.pop,
      body: Column(
        children: [
          const SizedBox(height: 16),
          AppDonutChart(completedPercent: percent),

          const SizedBox(height: 16),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: listTaskModel.length,
              itemBuilder: (context, index) {
                final todo = listTaskModel[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor:
                          todo.completed == 1
                              ? AppColors.success
                              : AppColors.error,
                      child: Icon(
                        todo.completed == 1 ? Icons.check : Icons.close,
                        color: AppColors.white,
                      ),
                    ),
                    title: Text(todo.title),
                    subtitle: Text('${context.loc.user} ID: ${todo.userId}'),
                    trailing: Icon(
                      todo.completed == 1 ? Icons.done : Icons.pending,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
