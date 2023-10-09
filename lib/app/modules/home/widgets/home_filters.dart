import 'package:flutter/material.dart';
import 'package:flutter_hands_on_todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:flutter_hands_on_todo_list_provider/app/models/task_filter_enum.dart';
import 'package:flutter_hands_on_todo_list_provider/app/models/total_tasks_model.dart';
import 'package:flutter_hands_on_todo_list_provider/app/modules/home/home_controller.dart';
import 'package:flutter_hands_on_todo_list_provider/app/modules/home/widgets/todo_card_filter.dart';
import 'package:provider/provider.dart';

class HomeFilters extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "FILTROS",
          style: context.titleStyle.copyWith(fontSize: 16),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              TodoCardFilter(
                label: 'HOJE',
                taskFilter: TaskFilterEnum.today,
                totalTasksModel: TotalTasksModel(
                  totalTasks: 10,
                  totalTasksFinisk: 5,
                ),
                selected: context.select<HomeController, TaskFilterEnum>(
                        (value) => value.filterSelected) ==
                    TaskFilterEnum.today,
              ),
              TodoCardFilter(
                label: 'AMANHÃ',
                taskFilter: TaskFilterEnum.tomorrow,
                totalTasksModel: TotalTasksModel(
                  totalTasks: 5,
                  totalTasksFinisk: 1,
                ),
                selected: context.select<HomeController, TaskFilterEnum>(
                        (value) => value.filterSelected) ==
                    TaskFilterEnum.tomorrow,
              ),
              TodoCardFilter(
                label: 'SEMANA',
                taskFilter: TaskFilterEnum.week,
                totalTasksModel: TotalTasksModel(
                  totalTasks: 22,
                  totalTasksFinisk: 14,
                ),
                selected: context.select<HomeController, TaskFilterEnum>(
                        (value) => value.filterSelected) ==
                    TaskFilterEnum.week,
              ),
            ],
          ),
        )
      ],
    );
  }
}
