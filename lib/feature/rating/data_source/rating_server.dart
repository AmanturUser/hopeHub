import 'dart:convert';
import '../../../core/apiService/apiService.dart';
import '../domain/rating_model.dart';
import '../domain/rating_schools_model.dart';

ApiService apiService = ApiService();

Future<RatingModel> getRatings(int page) async {
  final response = await apiService.get('/rating/all?page=$page&limit=10');
  if (response.statusCode == 201 || response.statusCode == 200) {
    return RatingModel.fromJson(jsonDecode(response.body));
  } else {
    throw Error();
  }
}

Future<RatingSchoolsModel> getRatingSchools(int page) async {
  final response = await apiService.get('/rating/allSchool?page=$page&limit=10');
  if (response.statusCode == 201 || response.statusCode == 200) {
    return RatingSchoolsModel.fromJson(jsonDecode(response.body));
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
