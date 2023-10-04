import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hands_on_todo_list_provider/app/core/ui/theme_extensions.dart';

class HomeWeekFilter extends StatefulWidget {
  const HomeWeekFilter({super.key});

  @override
  State<HomeWeekFilter> createState() => _HomeWeekFilterState();
}

class _HomeWeekFilterState extends State<HomeWeekFilter> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
          child: DatePicker(
            DateTime.now(),
            locale: 'PT-br',
            initialSelectedDate: DateTime.now(),
            selectionColor: context.primaryColor,
            selectedTextColor: Colors.white,
            daysCount: 7,
            monthTextStyle: const TextStyle(fontSize: 8),
            dayTextStyle: const TextStyle(fontSize: 13),
            dateTextStyle: const TextStyle(fontSize: 13),

          ),
        )
      ],
    );
  }
}
