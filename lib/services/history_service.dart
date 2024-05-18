import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:smart_door_lock/constants/error_handling.dart';
import 'package:smart_door_lock/constants/global_variables.dart';
import 'package:smart_door_lock/models/history.dart';
import 'package:http/http.dart' as http;
import 'package:smart_door_lock/utils/show_snack_bar.dart';

class HistoryService {
  Future<List<History>> fetchAllHistoryData(BuildContext context) async {
    List<History> histories = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/get-history'),
      );

      httpErrorHandler(
        response: res,
        context: context,
        onSuccess: () => {
          for (int i = 0; i < jsonDecode(res.body).length; i++)
            {
              histories.add(
                History.fromJson(
                  jsonDecode(res.body)[i],
                ),
              )
            }
        },
      );
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }

    return histories;
  }
}
