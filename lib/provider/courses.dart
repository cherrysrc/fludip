import 'package:fludip/net/webclient.dart';
import 'package:flutter/material.dart';

class CoursesProvider extends ChangeNotifier {
  Map<String,dynamic> _data;
  final WebClient _client = WebClient();
  String _userID;
  
  void setUserID(String userID){
    _userID = userID;
  }
  
  bool initialized(){
    return _data != null;
  }

  void update() async {
    if (_data == null){
      _data = Map<String,dynamic>();
    }

    _data = await _client.getRoute("/user/" + _userID + "/courses");
    notifyListeners();
  }

  Map<String,dynamic> getData(){
    return _data;
  }
}