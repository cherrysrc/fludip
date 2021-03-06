import 'package:fludip/provider/course/overview/semesterModel.dart';
import 'package:fludip/util/colorMapper.dart';
import 'package:flutter/material.dart';

class Course {
  String _courseID;

  String _title;
  String _subtitle;
  String _description;

  String _type;
  Color _color;
  String _number;

  String _location;

  Semester _startSemester;
  Semester _endSemester;

  String get courseID => this._courseID;

  String get title => this._title;
  String get subtitle => this._subtitle;
  String get description => this._description;

  String get type => this._type;
  Color get color => this._color;
  String get number => this._number;

  String get location => this._location;

  Semester get startSemester => this._startSemester;
  Semester get endSemester => this._endSemester;

  Course.fromMap(Map<String, dynamic> data, Semester start, Semester end) {
    _courseID = data["course_id"];

    _title = data["title"];
    _subtitle = data["subtitle"];
    _description = data["description"];

    _type = data["type"];
    _color = ColorMapper.convert(data["group"]);
    _number = data["number"];

    _location = data["location"];

    _startSemester = start;
    _endSemester = end;
  }
}
