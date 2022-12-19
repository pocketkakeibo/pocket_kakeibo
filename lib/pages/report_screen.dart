import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pocket_kakeibo/components/indicator.dart';
import 'package:pocket_kakeibo/data/database.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<StatefulWidget> createState() => ReportState();
}

class ReportState extends State {
  final _localBox = Hive.box('localBox');
  Database db = Database();

  int touchedIndex = -1;

  @override
  void initState() {
    _localBox.clear();
    if (_localBox.get('exCategories') == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1.3,
            child: Card(
              elevation: 0,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  const SizedBox(
                    height: 18,
                  ),
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: PieChart(
                        PieChartData(
                          pieTouchData: PieTouchData(
                            touchCallback:
                                (FlTouchEvent event, pieTouchResponse) {
                              setState(() {
                                if (!event.isInterestedForInteractions ||
                                    pieTouchResponse == null ||
                                    pieTouchResponse.touchedSection == null) {
                                  touchedIndex = -1;
                                  return;
                                }
                                touchedIndex = pieTouchResponse
                                    .touchedSection!.touchedSectionIndex;
                              });
                            },
                          ),
                          borderData: FlBorderData(
                            show: false,
                          ),
                          sectionsSpace: 0,
                          centerSpaceRadius: 40,
                          sections: showingSections(),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget>[
                      Indicator(
                        color: Color(0xff0293ee),
                        text: 'Survival',
                        isSquare: true,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Indicator(
                        color: Color(0xfff8b250),
                        text: 'Optional',
                        isSquare: true,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Indicator(
                        color: Color(0xff845bef),
                        text: 'Culture',
                        isSquare: true,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Indicator(
                        color: Color(0xff13d38e),
                        text: 'Extra',
                        isSquare: true,
                      ),
                      SizedBox(
                        height: 18,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff0293ee),
            value: (db.exCategories[0]['total'] /
                    (db.exCategories[0]['total'] +
                        db.exCategories[1]['total'] +
                        db.exCategories[2]['total'] +
                        db.exCategories[3]['total']) *
                    100)
                .roundToDouble(),
            title: (db.exCategories[0]['total'] /
                        (db.exCategories[0]['total'] +
                            db.exCategories[1]['total'] +
                            db.exCategories[2]['total'] +
                            db.exCategories[3]['total']) *
                        100)
                    .roundToDouble()
                    .toString() +
                '%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: db.exCategories[1]['total'] /
                (db.exCategories[0]['total'] +
                    db.exCategories[1]['total'] +
                    db.exCategories[2]['total'] +
                    db.exCategories[3]['total']) *
                100,
            title: (db.exCategories[1]['total'] /
                        (db.exCategories[0]['total'] +
                            db.exCategories[1]['total'] +
                            db.exCategories[2]['total'] +
                            db.exCategories[3]['total']) *
                        100)
                    .roundToDouble()
                    .toString() +
                '%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xff845bef),
            value: db.exCategories[2]['total'] /
                (db.exCategories[0]['total'] +
                    db.exCategories[1]['total'] +
                    db.exCategories[2]['total'] +
                    db.exCategories[3]['total']) *
                100,
            title: (db.exCategories[2]['total'] /
                        (db.exCategories[0]['total'] +
                            db.exCategories[1]['total'] +
                            db.exCategories[2]['total'] +
                            db.exCategories[3]['total']) *
                        100)
                    .roundToDouble()
                    .toString() +
                '%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        case 3:
          return PieChartSectionData(
            color: const Color(0xff13d38e),
            value: db.exCategories[3]['total'] /
                (db.exCategories[0]['total'] +
                    db.exCategories[1]['total'] +
                    db.exCategories[2]['total'] +
                    db.exCategories[3]['total']) *
                100,
            title: (db.exCategories[3]['total'] /
                        (db.exCategories[0]['total'] +
                            db.exCategories[1]['total'] +
                            db.exCategories[2]['total'] +
                            db.exCategories[3]['total']) *
                        100)
                    .roundToDouble()
                    .toString() +
                '%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        default:
          throw Error();
      }
    });
  }
}
