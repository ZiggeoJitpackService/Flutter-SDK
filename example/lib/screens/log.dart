import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ziggeo/ziggeo.dart';
import 'package:ziggeo_example/res/dimens.dart';
import 'package:ziggeo_example/utils/logger.dart';
import 'package:ziggeo_example/widgets/TextLocalized.dart';

class LogScreen extends StatefulWidget {
  static const String routeName = 'title_log';
  final Ziggeo ziggeo;

  LogScreen(this.ziggeo);

  @override
  _LogScreenState createState() => _LogScreenState(ziggeo);
}

class _LogScreenState extends State<LogScreen> {
  List<LogModel> logs = List.empty();
  final Ziggeo ziggeo;

  _LogScreenState(this.ziggeo);

  @override
  void initState() {
    super.initState();
    logs.addAll(Logger.buffer.reversed);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.all(common_margin),
      child: Stack(
        children: <Widget>[
          Align(
              alignment: Alignment.topCenter,
              child: logs.isEmpty
                  ? Container(
                      margin:
                          EdgeInsets.only(top: list_empty_message_margin_top),
                      child: TextLocalized('message_log_empty'))
                  : Container(
                      child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                      itemCount: logs.length,
                      itemBuilder: (context, index) => getListItem(index),
                    ))),
          Align(
            alignment: Alignment.bottomCenter,
            child: RaisedButton(
              onPressed: () => this.onSendReportBtnPressed(),
              child: TextLocalized('btn_send_report'),
            ),
          )
        ],
      ),
    ));
  }

  onSendReportBtnPressed() {
    var l = List.empty() as List<String>;
    for (var log in logs) {
      l.add(log.toString());
    }
    ziggeo.sendReport(l);
  }

  Widget getListItem(index) {
    var item = logs[index];
    return Text(
        "[${DateFormat('dd.MM.yyyy_HH.mm.ss').format(DateTime.fromMillisecondsSinceEpoch(item.timestamp))}]"
        " ${item.name}"
        "${item.details != null ? ":${item.details}" : ""}");
  }
}
