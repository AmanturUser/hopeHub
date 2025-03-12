

import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hope_hub/core/const/userData.dart';

import '../../../core/apiService/apiService.dart';

ApiService apiService = ApiService();

final storage = const FlutterSecureStorage();

Future<bool> auth(email) async {
  final response = await apiService.post('/auth/register',email);
  if(response.statusCode==201){
    return true;
  }else{
    return false;
  }
}

Future<Map<String, dynamic>> otpVerification(data) async {
  final response = await apiService.post('/verify-otp/login',data);
  if(response.statusCode==201 || response.statusCode==200){
    UserData.token=jsonDecode(response.body)['token'];
    await storage.write(key: 'token', value: UserData.token);

    if(!jsonDecode(response.body)['isRegister']){
      final responseSchools = await apiService.get('/school/getSchoolList');
      if(responseSchools.statusCode==201 || responseSchools.statusCode==200){
        UserData.userId=jsonDecode(response.body)['userId'];
        await storage.write(key: 'userId', value: UserData.userId);
        return {
          'status' : jsonDecode(responseSchools.body)['status'],
          'token' : jsonDecode(response.body)['token'],
          'isRegister' : jsonDecode(response.body)['isRegister'],
          'success' : jsonDecode(responseSchools.body)['success']
        };
      }else{
        return {
          'status' : false
        };
      }
    }else{
      UserData.userId=jsonDecode(response.body)['userId'];
      await storage.write(key: 'userId', value: UserData.userId);
      await storage.write(key: 'fcmToken', value: UserData.fcmToken);
      return {
        'status' : true,
        'token' : jsonDecode(response.body)['token'],
        'isRegister' : jsonDecode(response.body)['isRegister'],
      };
    }
  }else{
    return {
      'status' : false
    };
  }
}

Future<Map<String, dynamic>> getClasses(data) async {
  final response = await apiService.post('/class/getClassList',data);
      if(response.statusCode==201 || response.statusCode==200){
        return {
          'status' : jsonDecode(response.body)['status'],
          'classes' : jsonDecode(response.body)['success']
        };
      }else{
        return {
          'status' : false
        };
      }
}

Future<bool> registerDone(data) async {
  final response = await apiService.post('/auth/registerDetail',data);
  if(response.statusCode==201 || response.statusCode==200){
    return true;
  }else{
    return false;
  }
}