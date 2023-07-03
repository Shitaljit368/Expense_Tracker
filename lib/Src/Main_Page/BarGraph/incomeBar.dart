import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../Constant/colors.dart';
import 'bar_data.dart';

class IncomesBar extends StatefulWidget {
  const IncomesBar({super.key});

  @override
  State<IncomesBar> createState() => _IncomesBarState();
}

class _IncomesBarState extends State<IncomesBar> {
  List<double> weeklyIncomes = [
    100,
    50,
    20,
    40,
    56,
    90,
    70,
  ];
  @override
  Widget build(BuildContext context) {
    BarData myBarData = BarData(
      sunAmount: weeklyIncomes[0],
      monAmount: weeklyIncomes[1],
      tueAmount: weeklyIncomes[2],
      wedAmount: weeklyIncomes[3],
      thuAmount: weeklyIncomes[4],
      friAmount: weeklyIncomes[5],
      satAmount: weeklyIncomes[6],
    );
    myBarData.initializeBarData();
    return Column(
      children: [
        Container(
          height: 40,
          width: double.infinity,
          color: opBlack,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25, 15, 0, 0),
            child: Row(
              children: [
                const Text(
                  "This week's incomes",
                  style: TextStyle(fontSize: 20, color: white),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  height: 15,
                  width: 15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: hexGreen,
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
          height: 400,
          decoration: BoxDecoration(
              color: opBlack,
              // boxShadow:  [

              //   BoxShadow(color: grey.shade600, offset: const Offset(5, 5),blurRadius: 20),

              // ],
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(50),
                // bottomRight: Radius.circular(50),
              )),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
            child: BarChart(
              BarChartData(
                titlesData: FlTitlesData(
                  show: true,
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: getBottomTitles,
                    ),
                  ),
                ),
                gridData: FlGridData(show: false),
                borderData: FlBorderData(show: false),
                maxY: 100,
                minY: 0,
                barGroups: myBarData.barData
                    .map(
                      (data) => BarChartGroupData(
                        x: data.x,
                        barRods: [
                          BarChartRodData(
                            toY: data.y,
                            color: hexGreen,
                            width: 30,
                            borderRadius: BorderRadius.circular(20),
                            backDrawRodData: BackgroundBarChartRodData(
                                show: true, toY: 100, color: Colors.grey[200]),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 114,
        ),
        Container(
          height: 70,
          width: double.infinity,
          decoration: BoxDecoration(
              color: white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade400.withOpacity(0.1),
                    offset: const Offset(0, -5),
                    blurRadius: 3,
                    spreadRadius: 1)
              ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Income Items",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                Icon(Icons.arrow_forward_ios)
              ],
            ),
          ),
        ),
      ],
    );
  }
}

Widget getBottomTitles(double value, TitleMeta meta) {
  const style =
      TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14);
  Widget text;
  switch (value.toInt()) {
    case 0:
      text = const Text(
        "Sun",
        style: style,
      );
      break;
    case 1:
      text = const Text(
        "Mon",
        style: style,
      );
      break;
    case 2:
      text = const Text(
        "Tue",
        style: style,
      );
      break;
    case 3:
      text = const Text(
        "Wed",
        style: style,
      );
      break;
    case 4:
      text = const Text(
        "Thu",
        style: style,
      );
      break;
    case 5:
      text = const Text(
        "Fri",
        style: style,
      );
      break;
    case 6:
      text = const Text(
        "Sat",
        style: style,
      );
      break;

    default:
      text = const Text("");
      break;
  }
  return SideTitleWidget(axisSide: meta.axisSide, child: text);
}
