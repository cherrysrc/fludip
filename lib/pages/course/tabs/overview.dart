import 'package:fludip/pages/course/colorMapper.dart';
import 'package:fludip/util/commonWidgets.dart';
import 'package:fludip/util/str.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class OverviewTab extends StatefulWidget {
  final Map<String, dynamic> _courseData;

  OverviewTab({@required data}) : _courseData = data;

  @override
  _OverviewTabState createState() => _OverviewTabState();
}

class _OverviewTabState extends State<OverviewTab> {
  ///Helper to get list of formatted lecturer names from this course
  List<Widget> _gatherLecturers() {
    List<Widget> widgets = <Widget>[];

    widgets.add(Text(
      "Lecturers",
      textAlign: TextAlign.left,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ));

    Map<String, dynamic> lecturerData = widget._courseData["lecturers"];
    lecturerData.forEach((lecturerID, lecturerData) {
      widgets.add(Text(
        "     \u2022" + lecturerData["name"]["formatted"].toString(),
        textAlign: TextAlign.right,
      ));
    });

    return widgets;
  }

  ///Helper to get list of announcements from this course
  List<Widget> _gatherAnnouncements() {
    List<Widget> widgets = <Widget>[];

    widgets.add(Text(
      "Announcements",
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ));

    Map<String, dynamic> announcementData;
    try {
      announcementData = widget._courseData["announcements"]["collection"];
    } catch (e) {
      return widgets;
    }

    announcementData.forEach((key, value) {
      String topic = value["topic"].toString();
      int timeStamp = int.parse(value["date"].toString()) * 1000;
      String body = StringUtil.removeHTMLTags(value["body"].toString());

      widgets.add(CommonWidgets.announcement(topic, timeStamp, body));
    });

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Overview: " + widget._courseData["title"]),
        backgroundColor: ColorMapper.convert(widget._courseData["group"]),
      ),
      body: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12),
        ),
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Number",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget._courseData["number"] != "" ? "     " + widget._courseData["number"] : "     " + "None",
                ),
              ],
            ),
            Divider(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _gatherLecturers(),
            ),
            Divider(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Semester",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "     " +
                      (widget._courseData["start_semester"] != null
                          ? widget._courseData["start_semester"]["title"]
                          : "unlimited") +
                      " - " +
                      (widget._courseData["end_semester"] != null
                          ? widget._courseData["end_semester"]["title"]
                          : "unlimited"),
                ),
              ],
            ),
            Divider(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Location",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "     " + widget._courseData["location"] != null ? widget._courseData["location"] : "None",
                ),
              ],
            ),
            Divider(),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: _gatherAnnouncements()),
            Divider(),
          ],
        ),
      ),
    );
  }
}
