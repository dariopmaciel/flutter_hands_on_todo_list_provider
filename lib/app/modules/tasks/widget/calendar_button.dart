import 'package:flutter/material.dart';
import 'package:flutter_hands_on_todo_list_provider/app/core/ui/theme_extensions.dart';

class CalendarButton extends StatelessWidget {
  const CalendarButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(30)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.calendar_month_outlined,
            color: Colors.grey,
          ),
          const SizedBox(height: 10),
          Text(
            "SELECIoNE UMA DATA",
            //'04/10/2023',
            style: context.titleStyle,
          ),
        ],
      ),
    );
  }
}
