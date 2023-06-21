import 'package:exptracker/Constant/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartPage extends StatelessWidget {
  const ChartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Center(
          child: Column(
            children: [
              Expanded(
                flex: 10,
                child: Container(
                  decoration: BoxDecoration(
                    color: opBlack,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 350,
                        child: BarChart(
                          BarChartData(
                              backgroundColor: grey.withOpacity(0.1),
                              borderData: FlBorderData(
                                show: false,
                              ),
                              maxY: 100,
                              minY: 0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 145,
                              width: 165,
                              decoration: BoxDecoration(
                                  color: grey.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    "Income",
                                    style:
                                        TextStyle(color: white, fontSize: 18),
                                  ),
                                  Text(
                                    "4000",
                                    style:
                                        TextStyle(color: white, fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: 145,
                              width: 165,
                              decoration: BoxDecoration(
                                  color: grey.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    "Expense",
                                    style:
                                        TextStyle(color: white, fontSize: 18),
                                  ),
                                  Text(
                                    "3000",
                                    style:
                                        TextStyle(color: white, fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Expanded(child: SizedBox()),
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                       color: Theme.of(context).colorScheme.primary,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
