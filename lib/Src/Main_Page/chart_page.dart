import 'package:exptracker/Constant/colors.dart';
import 'package:exptracker/Src/Main_Page/BarGraph/expenseBar.dart';
import 'package:flutter/material.dart';
import 'BarGraph/incomeBar.dart';

class ChartPage extends StatefulWidget {
  const ChartPage({super.key});

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
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
                indicatorPadding: EdgeInsets.symmetric(horizontal: 60),
                unselectedLabelColor: grey,
                labelStyle: TextStyle(),
                indicatorColor: Colors.cyanAccent,
                labelColor: Colors.cyanAccent,
                tabs: [
                  Tab(
                    child: Text(
                      "Income",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Expenses",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  IncomesBar(),
                  ExpenseBar(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
