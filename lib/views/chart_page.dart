import 'package:alarm_test/model/opened_notif.dart';
import 'package:charts_flutter/flutter.dart' as chart;
import 'package:flutter/material.dart';

class ChartPage extends StatelessWidget {
  final String? payload;
  const ChartPage({Key? key, this.payload}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 3,
        title: const Text('Notification Chart Bar'),
      ),
      body: SingleChildScrollView(
        //get time payload from notification and pass data to chart
        child: ChartDetail(data: [
          OpenedNotif(
            payload,
            DateTime.now().difference(DateTime.parse(payload!)).inSeconds,
            chart.ColorUtil.fromDartColor(
              Colors.amber,
            ),
          )
        ]),
      ),
    );
  }
}

class ChartDetail extends StatelessWidget {
  final List<OpenedNotif> data;
  const ChartDetail({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<chart.Series<OpenedNotif, String>> series = [
      chart.Series(
        id: "notif",
        data: data,
        domainFn: (OpenedNotif series, _) => series.notif!,
        measureFn: (OpenedNotif series, _) => series.range,
        colorFn: (OpenedNotif series, _) => series.color,
      )
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            child: chart.BarChart(
              series,
              animate: true,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            '*The x-axis indicates the time the alarm is set and the y-axis indicates the time (in second) that alarm is ringing until the user click those alarm',
            style: TextStyle(fontSize: 12),
          )
        ],
      ),
    );
  }
}
