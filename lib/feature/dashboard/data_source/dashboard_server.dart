import 'dart:convert';
import '../../../core/apiService/apiService.dart';
import '../domain/dashboard_model.dart';

ApiService apiService = ApiService();

Future<DashboardModel> getUserDashboard() async {
  final response = await apiService.get('/users/userDashboard');
  if(response.statusCode==201 || response.statusCode==200){
    return DashboardModel.fromJson(jsonDecode(response.body));
  }else{
    throw Error();
  }
}

Future<bool> ideaSubmission(data) async {
  final response = await apiService.post('/userIdea/createIdea',data);
  if(response.statusCode==201 || response.statusCode==200){
    return true;
  }else{
    return false;
  }
}