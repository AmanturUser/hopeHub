import 'dart:convert';
import '../../../core/apiService/apiService.dart';
import '../domain/notification_model.dart';

ApiService apiService = ApiService();

Future<NotificationModel> getNotifications(int page) async {
  final response = await apiService.get('/notification/getNotifications?page=$page&limit=15');
  if (response.statusCode == 201 || response.statusCode == 200) {
    return NotificationModel.fromJson(jsonDecode(response.body));
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
