import 'dart:convert';
import 'dart:async';

import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';

mixin ConnectedModel on Model{
  bool _isLoading = false;
}

mixin UserModel on ConnectedModel{
  //   Future<String> login(String userid, String password) async {
  //   final http.Response response = await http.post(
  //       'https://webapi20190116075956.azurewebsites.net/api/demo/signin',
  //       headers: {
  //         "Accept": "application/json",
  //         "content-type": "application/json",
  //         "UserId": userid,
  //         "Password": password
  //       });
  //   final String responseData = json.decode(response.body);
  //   if (responseData != "no") {
  //     return "yes";
  //   } else {
  //     return "no";
  //   }
  // }

  String login(String userid,password){
    if(userid == "eric" && password == "eric1"){
      return "yes";
    }
    else{
      return "no";
    }
  }
  
    Future<Map<String, dynamic>> signup(
      String userId, String userPw, String fullName, String email) {
    notifyListeners();
    final Map<String, dynamic> userData = {
      'UserId': userId,
      'userPw': userPw,
      'FullName': fullName,
      'Email': email
    };
    print(userData);
    return http.post(
        'https://webapi20190116075956.azurewebsites.net/api/demo/signup',
        body: json.encode(userData),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        }).then((http.Response response) {
      print(response.statusCode);
      return {'success': true, 'message': 'Authentication succeeded!'};
    });
  }
}