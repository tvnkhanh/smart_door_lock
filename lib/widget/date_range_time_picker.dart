import 'package:flutter/material.dart';

class DateRangeTimePicker extends StatefulWidget {
  final ValueChanged<DateTimeRange> onDateRangeChanged;

  const DateRangeTimePicker({
    super.key,
    required this.onDateRangeChanged,
  });

  @override
  State<DateRangeTimePicker> createState() => _DateRangeTimePickerState();
}

class _DateRangeTimePickerState extends State<DateRangeTimePicker> {
  DateTimeRange dateRange = DateTimeRange(
    start: DateTime.now().subtract(const Duration(days: 30)),
    end: DateTime.now(),
  );

  @override
  Widget build(BuildContext context) {
    final start = dateRange.start;
    final end = dateRange.end;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: pickDateRange,
            child: Text('${start.day}/${start.month}/${start.year}'),
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        Expanded(
          child: ElevatedButton(
            onPressed: pickDateRange,
            child: Text('${end.day}/${end.month}/${end.year}'),
          ),
        ),
      ],
    );
  }

  Future pickDateRange() async {
    DateTimeRange? newDateRange = await showDateRangePicker(
      context: context,
      initialDateRange: dateRange,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (newDateRange == null) return;
    setState(() => dateRange = newDateRange);
    widget.onDateRangeChanged(newDateRange);
  }
}
