import 'package:flutter/material.dart';

class User {
  final String userId;
  final String userPw;
  final String fullName;
  final String email;

  User(
      {@required this.userId,
      @required this.userPw,
      @required this.fullName,
      @required this.email});
}
