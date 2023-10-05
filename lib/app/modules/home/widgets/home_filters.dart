import 'package:flutter/material.dart';
import 'package:flutter_hands_on_todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:flutter_hands_on_todo_list_provider/app/modules/home/widgets/todo_card_filter.dart';

class HomeFilters extends StatefulWidget {
  const HomeFilters({super.key});

  @override
  State<HomeFilters> createState() => _HomeFiltersState();
}

class _HomeFiltersState extends State<HomeFilters> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "FILTROS",
          style: context.titleStyle.copyWith(fontSize: 16),
        ),
        const SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              TodoCardFilter(),
              TodoCardFilter(),
              TodoCardFilter(),
              TodoCardFilter(),
              TodoCardFilter(),
              TodoCardFilter(),
            ],
          ),
        )
      ],
    );
  }
}
