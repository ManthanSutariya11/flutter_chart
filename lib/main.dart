import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Chart'),
      ),
      body: Column(
        children: [
          Container(
            height: size.height - 150,
            padding: EdgeInsets.all(20),
            color: Colors.grey,
            child: BarChart(
              BarChartData(
                maxY: 100,
                minY: 0,
                barGroups: [
                  BarChartGroupData(
                    x: 0,
                    barRods: [
                      BarChartRodData(y: 10, width: 3),
                      BarChartRodData(y: 20, width: 3),
                      BarChartRodData(
                        y: 30,
                        width: 3,
                        backDrawRodData: BackgroundBarChartRodData(
                          colors: [Colors.yellow, Colors.green],
                          show: true,
                          y: 70,
                        ),
                        rodStackItems: [
                          BarChartRodStackItem(
                            10,
                            40,
                            Colors.purple,
                          )
                        ],
                      ),
                      BarChartRodData(
                        y: 40,
                        width: 12,
                        backDrawRodData: BackgroundBarChartRodData(
                          colors: [Colors.white],
                          show: true,
                          y: 100,
                        ),
                      ),
                      BarChartRodData(y: 50, width: 3),
                      BarChartRodData(y: 60, width: 3),
                      BarChartRodData(y: 70, width: 3),
                      BarChartRodData(y: 80, width: 3),
                      BarChartRodData(y: 90, width: 3),
                    ],
                    barsSpace: 20,
                  ),
                  BarChartGroupData(
                    x: 0,
                    barRods: [
                      BarChartRodData(y: 9, width: 3, colors: [Colors.red]),
                      BarChartRodData(
                        y: 19,
                        width: 3,
                        colors: [Colors.red],
                      ),
                    ],
                    barsSpace: 20,
                  ),
                ],
                // groupsSpace: 20,
                gridData: FlGridData(
                  show: true,
                ),
              ),
              swapAnimationDuration: Duration(milliseconds: 150), // Optional
              swapAnimationCurve: Curves.linear,
            ),
          ),
          //line chart
          if (false)
            Container(
              height: 600,
              padding: EdgeInsets.all(20),
              color: Colors.grey,
              child: LineChart(
                LineChartData(
                  maxX: 100,
                  maxY: 100,
                  minX: 0,
                  minY: 0,
                  titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 10,
                        getTextStyles: (context, value) => const TextStyle(
                          color: Colors.black,
                        ),
                        getTitles: (value) {
                          switch (value.toInt()) {
                            case 20:
                              return 'Fab';
                            case 40:
                              return 'Mar';
                            case 60:
                              return 'Apr';
                            case 80:
                              return 'May';
                            case 100:
                              return 'Jun';
                            default:
                              return 'Jan';
                          }
                        },
                      ),
                      leftTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 25,
                        getTextStyles: (context, value) => const TextStyle(
                          color: Colors.black,
                        ),
                        getTitles: (value) {
                          return value.toInt().toString();
                        },
                        // that define margin between between value and chart
                        margin: 5,
                      ),
                      topTitles: SideTitles(
                        showTitles: false,
                      ),
                      rightTitles: SideTitles(showTitles: false)),
                  borderData: FlBorderData(
                    border: Border.all(color: Colors.red),
                  ),
                  gridData: FlGridData(
                    show: true,
                    horizontalInterval: 10,
                    getDrawingHorizontalLine: (line) {
                      return FlLine(
                        color: Colors.red,
                        strokeWidth: 1,
                        dashArray: [5],
                      );
                    },
                    getDrawingVerticalLine: (line) {
                      return FlLine(
                        color: Colors.red,
                        strokeWidth: 1,
                        dashArray: [5],
                      );
                    },
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        FlSpot(0, 0),
                        FlSpot(20, 20),
                        FlSpot(30, 10),
                        FlSpot(50, 40),
                        FlSpot(60, 20),
                        FlSpot(80, 30),
                        FlSpot(100, 10),
                      ],
                      isCurved: true,
                      colors: [
                        Color(0xFFffafcc),
                        Color(0xFFa2d2ff),
                      ],
                      barWidth: 2,
                      belowBarData: BarAreaData(
                        show: true,
                        colors: [
                          Color(0xFFffafcc).withOpacity(0.5),
                          Color(0xFFa2d2ff).withOpacity(0.5),
                        ],
                      ),
                      dotData: FlDotData(show: false),
                    ),
                    LineChartBarData(
                      spots: [
                        FlSpot(0, 50),
                        FlSpot(20, 40),
                        FlSpot(50, 60),
                        FlSpot(70, 60),
                        FlSpot(90, 40),
                        FlSpot(100, 50),
                      ],
                      // aboveBarData: BarAreaData(
                      //   show: true,
                      //   colors: [
                      //     Color(0xFFffafcc).withOpacity(0.5),
                      //     Color(0xFFa2d2ff).withOpacity(0.5),
                      //   ],
                      // ),
                      isCurved: true,
                      colors: [
                        Color(0xFFffafcc),
                        Color(0xFFa2d2ff),
                      ],
                      barWidth: 2,
                      dotData: FlDotData(show: false),
                    ),
                  ],
                ),

                swapAnimationDuration: Duration(milliseconds: 150), // Optional
                swapAnimationCurve: Curves.linear, // Optional
              ),
            ),
        ],
      ),
    );
  }
}
