import 'package:exptracker/Constant/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartPage extends StatelessWidget {
  const ChartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Column(
          children: [
            Container(
              color: opBlack,
              child: const TabBar(
                indicatorColor: Colors.amber,
                tabs: [
                  Tab(
                    child: Text("Income"),
                  ),
                  Tab(
                    child: Text("Expenses"),
                  ),
                ],
              ),
            ),
            Expanded(
                child: TabBarView(children: [
              Container(
                color: Theme.of(context).colorScheme.background,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 50),
                  child: BarChart(
                    BarChartData(maxY: 100, minY: 0),
                  ),
                ),
              ),
              Container(
                color: Theme.of(context).colorScheme.background,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 50),
                  child: BarChart(
                    BarChartData(maxY: 100, minY: 0),
                  ),
                ),
              )
            ]))
          ],
        ),
      ),
    );
  }
}
