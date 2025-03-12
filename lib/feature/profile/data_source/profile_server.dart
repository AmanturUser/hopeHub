import 'dart:convert';
import 'package:hope_hub/feature/action/domain/action_model.dart';
import 'package:hope_hub/feature/profile/domain/profile_model.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/apiService/apiService.dart';
import '../../dashboard/domain/dashboard_model.dart';

ApiService apiService = ApiService();

Future<ProfileModel> getProfile() async {
  final response = await apiService.get('/auth/profile');
  if (response.statusCode == 201 || response.statusCode == 200) {
    return ProfileModel.fromJson(jsonDecode(response.body));
  } else {
    throw Error();
  }
}

Future<bool> deleteAccount() async {
  final response = await apiService.get('/users/deleteUser');
  if (response.statusCode == 201 || response.statusCode == 200) {
    return true;
  } else {
    throw Error();
  }
}

Future<bool> changeProfileImage(XFile data) async {
  final response = await apiService.updateProfileImage(data.path, '/users/photo');
  if (response.statusCode == 201 || response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

Future<bool> editProfile(data) async {
  final response = await apiService.post('/auth/registerDetail',data);
  if(response.statusCode==201 || response.statusCode==200){
    return true;
  }else{
    return false;
  }
}
