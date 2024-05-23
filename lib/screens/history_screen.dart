import 'package:flutter/material.dart';
import 'package:smart_door_lock/models/history.dart';
import 'package:smart_door_lock/services/history_service.dart';
import 'package:smart_door_lock/widget/date_range_time_picker.dart';
import 'package:smart_door_lock/widget/history_item.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<History>? histories;
  final HistoryService historyService = HistoryService();
  DateTimeRange? selectedDateRange;

  @override
  void initState() {
    super.initState();
    fetchAllHistoryData();
  }

  void fetchAllHistoryData() async {
    histories = await historyService.fetchAllHistoryData(context);
    setState(() {});
  }

  void onDateRangeChanged(DateTimeRange newDateRange) {
    setState(() {
      selectedDateRange = newDateRange;
    });
  }

  @override
  Widget build(BuildContext context) {
    final start = selectedDateRange?.start ??
        DateTime.now().subtract(const Duration(days: 30));
    final end = selectedDateRange?.end ?? DateTime.now();

    List<History> filteredHistories = histories?.where((history) {
          return history.time.isAfter(start) && history.time.isBefore(end);
        }).toList() ??
        [];

    return Scaffold(
      backgroundColor: Colors.indigo.shade50,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            margin: const EdgeInsets.only(top: 18, left: 24, right: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.indigo,
                      ),
                    ),
                    const RotatedBox(
                      quarterTurns: 135,
                      child: Icon(
                        Icons.bar_chart_rounded,
                        color: Colors.indigo,
                        size: 28,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                DateRangeTimePicker(
                  onDateRangeChanged: onDateRangeChanged,
                ),
                const SizedBox(
                  height: 5,
                ),
                histories != null
                    ? ListView.builder(
                        itemCount: filteredHistories.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return HistoryItem(history: filteredHistories[index]);
                        },
                      )
                    : const Center(
                        child: CircularProgressIndicator(
                          color: Colors.indigo,
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
