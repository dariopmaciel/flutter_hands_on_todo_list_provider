import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hands_on_todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:flutter_hands_on_todo_list_provider/app/models/task_filter_enum.dart';
import 'package:flutter_hands_on_todo_list_provider/app/modules/home/home_controller.dart';
import 'package:provider/provider.dart';

class HomeWeekFilter extends StatefulWidget {
  const HomeWeekFilter({super.key});

  @override
  State<HomeWeekFilter> createState() => _HomeWeekFilterState();
}

class _HomeWeekFilterState extends State<HomeWeekFilter> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: context.select<HomeController, bool>((controller) =>
          controller.filterSelected ==
          TaskFilterEnum
              .week), //tru mostr oq esta no child, false mostr o replacement
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          Text(
            "DIA DA SEMANA",
            style: context.titleStyle.copyWith(fontSize: 16),
          ),
          // const SizedBox(height: 10),
          SizedBox(
            height: 95,
            child: Selector<HomeController, DateTime>(
              selector: (context, controller) =>
                  controller.initialDateOfWeek ?? DateTime.now(),
              builder: (_, value, __) {
                return DatePicker(
                  // substituido 'DateTime.now()' por 'value' para poder ser definido em seu pai
                  // DateTime.now(),
                  value,
                  locale: 'PT-br',
                  initialSelectedDate: DateTime.now(),
                  // initialSelectedDate: value,
                  selectionColor: context.primaryColor,
                  selectedTextColor: Colors.white,
                  daysCount: 7,
                  monthTextStyle: const TextStyle(fontSize: 8),
                  dayTextStyle: const TextStyle(fontSize: 13),
                  dateTextStyle: const TextStyle(fontSize: 13),
                  onDateChange: (date){
                    context.read<HomeController>().filterByday(date);
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
