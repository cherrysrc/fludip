import 'package:fludip/pages/messages/messageViewer.dart';
import 'package:fludip/provider/messageProvider.dart';
import 'package:fludip/util/str.dart';
import 'package:flutter/material.dart';
import 'package:fludip/navdrawer/navDrawer.dart';
import 'package:provider/provider.dart';

class MessagesPage extends StatefulWidget {
  Map<String, dynamic> _data;

  @override
  _MessagesPageState createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  List<Widget> _buildMessageList() {
    List<Widget> widgets = <Widget>[];
    if (widget._data == null) {
      return widgets;
    }

    widget._data.forEach((messageIdUrl, messageData) {
      widgets.add(ListTile(
        leading: Icon(Icons.mail, size: 30),
        title: Text(messageData["subject"]),
        subtitle: Text(messageData["sender"]["name"]["formatted"]),
        trailing: Text(
          StringUtil.fromUnixTime(int.parse(messageData["mkdate"]) * 1000, "dd.MM.yyyy HH:mm"),
          style: TextStyle(
            fontWeight: FontWeight.w300,
          ),
        ),
        onTap: () {
          Navigator.push(context, navRoute(MessageViewer(messageData: messageData)));
        },
      ));

      widgets.add(Divider());
    });

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    widget._data = Provider.of<MessageProvider>(context).get();

    return Scaffold(
      appBar: AppBar(
        title: Text("Nachrichten"),
      ),
      body: RefreshIndicator(
        child: ListView(
          children: _buildMessageList(),
        ),
        onRefresh: () async {
          Provider.of<MessageProvider>(context, listen: false).update();
        },
      ),
      drawer: NavDrawer(),
    );
  }
}