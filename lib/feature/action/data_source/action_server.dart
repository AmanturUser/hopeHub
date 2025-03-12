import 'dart:convert';
import 'package:hope_hub/feature/action/domain/action_model.dart';

import '../../../core/apiService/apiService.dart';
import '../../dashboard/domain/dashboard_model.dart';

ApiService apiService = ApiService();

Future<ActionsModel> getSurveysAction() async {
  final response = await apiService.get('/users/userAction');
  if (response.statusCode == 201 || response.statusCode == 200) {
    return ActionsModel.fromJson(jsonDecode(response.body));
  } else {
    throw Error();
  }
}

Future<bool> surveySubmit(data) async {
  final response = await apiService.post('/survey/respond', data);
  if (response.statusCode == 201 || response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}
