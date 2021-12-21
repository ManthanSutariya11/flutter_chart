import 'dart:math';

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
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      // home: BarChartSample1(),
      home: BarChartExample3(),
    );
  }
}

class BarChartExample extends StatefulWidget {
  const BarChartExample({Key? key}) : super(key: key);

  @override
  State<BarChartExample> createState() => _BarChartExampleState();
}

class _BarChartExampleState extends State<BarChartExample> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: 700,
        width: 500,
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              color: const Color(0xff81e5cd),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Bar Chart Example',
                      style: TextStyle(
                          color: Color(0xff0f4a3c),
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 500,
                      width: 500,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: BarChart(
                          BarChartData(
                            barTouchData: BarTouchData(
                              touchTooltipData: BarTouchTooltipData(
                                  tooltipBgColor: Colors.blueGrey,
                                  getTooltipItem:
                                      (group, groupIndex, rod, rodIndex) {
                                    String weekDay;
                                    switch (group.x.toInt()) {
                                      case 0:
                                        weekDay = 'Monday';
                                        break;
                                      case 1:
                                        weekDay = 'Tuesday';
                                        break;
                                      case 2:
                                        weekDay = 'Wednesday';
                                        break;
                                      case 3:
                                        weekDay = 'Thursday';
                                        break;
                                      case 4:
                                        weekDay = 'Friday';
                                        break;
                                      case 5:
                                        weekDay = 'Saturday';
                                        break;
                                      case 6:
                                        weekDay = 'Sunday';
                                        break;
                                      default:
                                        throw Error();
                                    }
                                    return BarTooltipItem(
                                      weekDay + '\n',
                                      const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: (rod.y - 1).toString(),
                                          style: const TextStyle(
                                            color: Colors.yellow,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                              touchCallback:
                                  (FlTouchEvent event, barTouchResponse) {
                                setState(() {
                                  if (!event.isInterestedForInteractions ||
                                      barTouchResponse == null ||
                                      barTouchResponse.spot == null) {
                                    touchedIndex = -1;
                                    return;
                                  }
                                  touchedIndex = barTouchResponse
                                      .spot!.touchedBarGroupIndex;
                                });
                              },
                            ),
                            titlesData: FlTitlesData(
                              show: true,
                              rightTitles: SideTitles(showTitles: false),
                              topTitles: SideTitles(showTitles: false),
                              bottomTitles: SideTitles(
                                showTitles: true,
                                getTextStyles: (context, value) =>
                                    const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                margin: 16,
                                getTitles: (double value) {
                                  switch (value.toInt()) {
                                    case 0:
                                      return 'M';
                                    case 1:
                                      return 'T';
                                    case 2:
                                      return 'W';
                                    case 3:
                                      return 'T';
                                    case 4:
                                      return 'F';
                                    case 5:
                                      return 'S';
                                    case 6:
                                      return 'S';
                                    default:
                                      return '';
                                  }
                                },
                              ),
                              leftTitles: SideTitles(
                                showTitles: false,
                              ),
                            ),
                            borderData: FlBorderData(
                              show: false,
                            ),
                            barGroups: showingGroups(),
                            gridData: FlGridData(show: false),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = Colors.blue,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: isTouched ? y + 1 : y,
          colors: isTouched ? [Colors.yellow] : [barColor],
          width: width,
          borderSide: isTouched
              ? BorderSide(color: Colors.yellow, width: 1)
              : const BorderSide(color: Colors.white, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: 20,
            colors: [Colors.white],
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(7, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, 5, isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(1, 6.5, isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(2, 5, isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(3, 7.5, isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(4, 9, isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(5, 11.5, isTouched: i == touchedIndex);
          case 6:
            return makeGroupData(6, 6.5, isTouched: i == touchedIndex);
          default:
            return throw Error();
        }
      });
}

class BarChartExample2 extends StatefulWidget {
  const BarChartExample2({Key? key}) : super(key: key);

  @override
  _BarChartExample2State createState() => _BarChartExample2State();
}

class _BarChartExample2State extends State<BarChartExample2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: 700,
        width: 500,
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              color: const Color(0xff81e5cd),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Bar Chart Example',
                      style: TextStyle(
                          color: Color(0xff0f4a3c),
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 500,
                      width: 500,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: BarChart(
                          BarChartData(
                            barTouchData: barTouchData,
                            titlesData: titlesData,
                            borderData: borderData,
                            barGroups: barGroups,
                            alignment: BarChartAlignment.spaceAround,
                            maxY: 30,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: true,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: const EdgeInsets.all(0),
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.y.toString(),
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (context, value) => const TextStyle(
            color: Color(0xff7589a2),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          margin: 20,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return 'Mn';
              case 1:
                return 'Te';
              case 2:
                return 'Wd';
              case 3:
                return 'Tu';
              case 4:
                return 'Fr';
              case 5:
                return 'St';
              case 6:
                return 'Sn';
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
        rightTitles: SideTitles(showTitles: false),
      );

  FlBorderData get borderData => FlBorderData(
        show: true,
      );

  List<BarChartGroupData> get barGroups => [
        BarChartGroupData(
          x: 0,
          barRods: [
            BarChartRodData(
                y: 10, colors: [Colors.lightBlueAccent, Colors.greenAccent])
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(
                y: 10, colors: [Colors.lightBlueAccent, Colors.greenAccent])
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 2,
          barRods: [
            BarChartRodData(
                y: 14, colors: [Colors.lightBlueAccent, Colors.greenAccent])
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(
                y: 15, colors: [Colors.lightBlueAccent, Colors.greenAccent])
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(
                y: 13, colors: [Colors.lightBlueAccent, Colors.greenAccent])
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(
                y: 10, colors: [Colors.lightBlueAccent, Colors.greenAccent])
          ],
          showingTooltipIndicators: [0],
        ),
      ];
}

class BarChartExample3 extends StatefulWidget {
  const BarChartExample3({Key? key}) : super(key: key);

  @override
  _BarChartExample3State createState() => _BarChartExample3State();
}

class _BarChartExample3State extends State<BarChartExample3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chart Screen'),
      ),
      body: SizedBox(
        height: 700,
        width: 500,
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              color: const Color(0xff81e5cd),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Bar Chart Example',
                      style: TextStyle(
                          color: Color(0xff0f4a3c),
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 500,
                      width: 500,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: BarChart(
                          BarChartData(
                              barTouchData: barTouchData,
                              titlesData: titlesData,
                              borderData: borderData,
                              barGroups: barGroups,
                              alignment: BarChartAlignment.spaceAround,
                              maxY: 30,
                              minY: -30),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: true,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: const EdgeInsets.all(0),
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.y.toString(),
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (context, value) => const TextStyle(
            color: Color(0xff7589a2),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          margin: 20,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return 'Mn';
              case 1:
                return 'Te';
              case 2:
                return 'Wd';
              case 3:
                return 'Tu';
              case 4:
                return 'Fr';
              case 5:
                return 'St';
              case 6:
                return 'Sn';
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
        rightTitles: SideTitles(showTitles: false),
      );

  FlBorderData get borderData => FlBorderData(
        show: true,
      );

  List<BarChartGroupData> get barGroups => [
        BarChartGroupData(
          x: 0,
          barRods: [
            BarChartRodData(
                y: 10, colors: [Colors.lightBlueAccent, Colors.greenAccent])
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(
                y: -10, colors: [Colors.lightBlueAccent, Colors.greenAccent])
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 2,
          barRods: [
            BarChartRodData(
                y: 14, colors: [Colors.lightBlueAccent, Colors.greenAccent])
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(
                y: 15, colors: [Colors.lightBlueAccent, Colors.greenAccent])
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(
                y: -13, colors: [Colors.lightBlueAccent, Colors.greenAccent])
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(
                y: 10, colors: [Colors.lightBlueAccent, Colors.greenAccent])
          ],
          showingTooltipIndicators: [0],
        ),
      ];
}




// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Flutter Chart'),
//       ),
//       body: Column(
//         children: [
//           Container(
//             height: size.height - 150,
//             padding: EdgeInsets.all(20),
//             color: Colors.grey,
//             child: BarChart(
//               BarChartData(
//                 maxY: 100,
//                 minY: 0,
//                 barGroups: [
//                   BarChartGroupData(
//                     x: 50,
//                     barRods: [
//                       BarChartRodData(y: 10, width: 3),
//                       BarChartRodData(y: 20, width: 3),
//                       BarChartRodData(
//                         y: 30,
//                         width: 3,
//                         backDrawRodData: BackgroundBarChartRodData(
//                           colors: [Colors.yellow, Colors.green],
//                           show: true,
//                           y: 70,
//                         ),
//                         rodStackItems: [
//                           BarChartRodStackItem(
//                             10,
//                             40,
//                             Colors.purple,
//                           )
//                         ],
//                       ),
//                       BarChartRodData(
//                         y: 40,
//                         width: 12,
//                         backDrawRodData: BackgroundBarChartRodData(
//                           colors: [Colors.white],
//                           show: true,
//                           y: 100,
//                         ),
//                       ),
//                       BarChartRodData(y: 50, width: 3),
//                       BarChartRodData(y: 60, width: 3),
//                       BarChartRodData(y: 70, width: 3),
//                       BarChartRodData(y: 80, width: 3),
//                       BarChartRodData(y: 90, width: 3),
//                     ],
//                     barsSpace: 20,
//                   ),
//                   BarChartGroupData(
//                     x: 10,
//                     barRods: [
//                       BarChartRodData(y: 9, width: 3, colors: [Colors.red]),
//                       BarChartRodData(
//                         y: 19,
//                         width: 3,
//                         colors: [Colors.red],
//                       ),
//                     ],
//                     barsSpace: 20,
//                   ),
//                 ],
//                 // groupsSpace: 20,
//                 gridData: FlGridData(
//                   show: true,
//                 ),
//                 titlesData: FlTitlesData(
//                   rightTitles: SideTitles(showTitles: false),
//                   topTitles: SideTitles(showTitles: false),
//                   bottomTitles: SideTitles(
//                     showTitles: true,
//                     getTextStyles: (context, value) => const TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 14),
//                     margin: 16,
//                     getTitles: (double value) {
//                       switch (value.toInt()) {
//                         case 0:
//                           return 'M';
//                         case 1:
//                           return 'T';
//                         case 2:
//                           return 'W';
//                         case 3:
//                           return 'T';
//                         case 4:
//                           return 'F';
//                         case 5:
//                           return 'S';
//                         case 6:
//                           return 'S';
//                         default:
//                           return '';
//                       }
//                     },
//                   ),
//                 ),
//               ),

//               swapAnimationDuration: Duration(milliseconds: 150), // Optional
//               swapAnimationCurve: Curves.linear,
//             ),
//           ),
//           //line chart
//           if (false)
//             Container(
//               height: 600,
//               padding: EdgeInsets.all(20),
//               color: Colors.grey,
//               child: LineChart(
//                 LineChartData(
//                   maxX: 100,
//                   maxY: 100,
//                   minX: 0,
//                   minY: 0,
//                   titlesData: FlTitlesData(
//                       show: true,
//                       bottomTitles: SideTitles(
//                         showTitles: true,
//                         reservedSize: 10,
//                         getTextStyles: (context, value) => const TextStyle(
//                           color: Colors.black,
//                         ),
//                         getTitles: (value) {
//                           switch (value.toInt()) {
//                             case 20:
//                               return 'Fab';
//                             case 40:
//                               return 'Mar';
//                             case 60:
//                               return 'Apr';
//                             case 80:
//                               return 'May';
//                             case 100:
//                               return 'Jun';
//                             default:
//                               return 'Jan';
//                           }
//                         },
//                       ),
//                       leftTitles: SideTitles(
//                         showTitles: true,
//                         reservedSize: 25,
//                         getTextStyles: (context, value) => const TextStyle(
//                           color: Colors.black,
//                         ),
//                         getTitles: (value) {
//                           return value.toInt().toString();
//                         },
//                         // that define margin between between value and chart
//                         margin: 5,
//                       ),
//                       topTitles: SideTitles(
//                         showTitles: false,
//                       ),
//                       rightTitles: SideTitles(showTitles: false)),
//                   borderData: FlBorderData(
//                     border: Border.all(color: Colors.red),
//                   ),
//                   gridData: FlGridData(
//                     show: true,
//                     horizontalInterval: 10,
//                     getDrawingHorizontalLine: (line) {
//                       return FlLine(
//                         color: Colors.red,
//                         strokeWidth: 1,
//                         dashArray: [5],
//                       );
//                     },
//                     getDrawingVerticalLine: (line) {
//                       return FlLine(
//                         color: Colors.red,
//                         strokeWidth: 1,
//                         dashArray: [5],
//                       );
//                     },
//                   ),
//                   lineBarsData: [
//                     LineChartBarData(
//                       spots: [
//                         FlSpot(0, 0),
//                         FlSpot(20, 20),
//                         FlSpot(30, 10),
//                         FlSpot(50, 40),
//                         FlSpot(60, 20),
//                         FlSpot(80, 30),
//                         FlSpot(100, 10),
//                       ],
//                       isCurved: true,
//                       colors: [
//                         Color(0xFFffafcc),
//                         Color(0xFFa2d2ff),
//                       ],
//                       barWidth: 2,
//                       belowBarData: BarAreaData(
//                         show: true,
//                         colors: [
//                           Color(0xFFffafcc).withOpacity(0.5),
//                           Color(0xFFa2d2ff).withOpacity(0.5),
//                         ],
//                       ),
//                       dotData: FlDotData(show: false),
//                     ),
//                     LineChartBarData(
//                       spots: [
//                         FlSpot(0, 50),
//                         FlSpot(20, 40),
//                         FlSpot(50, 60),
//                         FlSpot(70, 60),
//                         FlSpot(90, 40),
//                         FlSpot(100, 50),
//                       ],
//                       // aboveBarData: BarAreaData(
//                       //   show: true,
//                       //   colors: [
//                       //     Color(0xFFffafcc).withOpacity(0.5),
//                       //     Color(0xFFa2d2ff).withOpacity(0.5),
//                       //   ],
//                       // ),
//                       isCurved: true,
//                       colors: [
//                         Color(0xFFffafcc),
//                         Color(0xFFa2d2ff),
//                       ],
//                       barWidth: 2,
//                       dotData: FlDotData(show: false),
//                     ),
//                   ],
//                 ),

//                 swapAnimationDuration: Duration(milliseconds: 150), // Optional
//                 swapAnimationCurve: Curves.linear, // Optional
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

// class BarChartSample1 extends StatefulWidget {
//   final List<Color> availableColors = const [
//     Colors.purpleAccent,
//     Colors.yellow,
//     Colors.lightBlue,
//     Colors.orange,
//     Colors.pink,
//     Colors.redAccent,
//   ];

//   const BarChartSample1({Key? key}) : super(key: key);

//   @override
//   State<StatefulWidget> createState() => BarChartSample1State();
// }

// class BarChartSample1State extends State<BarChartSample1> {
//   final Color barBackgroundColor = const Color(0xff72d8bf);
//   final Duration animDuration = const Duration(milliseconds: 250);

//   int touchedIndex = -1;

//   bool isPlaying = false;

//   @override
//   Widget build(BuildContext context) {
//     return AspectRatio(
//       aspectRatio: 1,
//       child: Card(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
//         color: const Color(0xff81e5cd),
//         child: Stack(
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.max,
//                 children: <Widget>[
//                   const Text(
//                     'Mingguan',
//                     style: TextStyle(
//                         color: Color(0xff0f4a3c),
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(
//                     height: 4,
//                   ),
//                   const Text(
//                     'Grafik konsumsi kalori',
//                     style: TextStyle(
//                         color: Color(0xff379982),
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(
//                     height: 38,
//                   ),
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                       child: BarChart(
//                         isPlaying ? randomData() : mainBarData(),
//                         swapAnimationDuration: animDuration,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 12,
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Align(
//                 alignment: Alignment.topRight,
//                 child: IconButton(
//                   icon: Icon(
//                     isPlaying ? Icons.pause : Icons.play_arrow,
//                     color: const Color(0xff0f4a3c),
//                   ),
//                   onPressed: () {
//                     setState(() {
//                       isPlaying = !isPlaying;
//                       if (isPlaying) {
//                         refreshState();
//                       }
//                     });
//                   },
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   BarChartGroupData makeGroupData(
//     int x,
//     double y, {
//     bool isTouched = false,
//     Color barColor = Colors.white,
//     double width = 22,
//     List<int> showTooltips = const [],
//   }) {
//     return BarChartGroupData(
//       x: x,
//       barRods: [
//         BarChartRodData(
//           y: isTouched ? y + 1 : y,
//           colors: isTouched ? [Colors.yellow] : [barColor],
//           width: width,
//           borderSide: isTouched
//               ? BorderSide(color: Colors.yellow, width: 1)
//               : const BorderSide(color: Colors.white, width: 0),
//           backDrawRodData: BackgroundBarChartRodData(
//             show: true,
//             y: 20,
//             colors: [barBackgroundColor],
//           ),
//         ),
//       ],
//       showingTooltipIndicators: showTooltips,
//     );
//   }

//   List<BarChartGroupData> showingGroups() => List.generate(7, (i) {
//         switch (i) {
//           case 0:
//             return makeGroupData(0, 5, isTouched: i == touchedIndex);
//           case 1:
//             return makeGroupData(1, 6.5, isTouched: i == touchedIndex);
//           case 2:
//             return makeGroupData(2, 5, isTouched: i == touchedIndex);
//           case 3:
//             return makeGroupData(3, 7.5, isTouched: i == touchedIndex);
//           case 4:
//             return makeGroupData(4, 9, isTouched: i == touchedIndex);
//           case 5:
//             return makeGroupData(5, 11.5, isTouched: i == touchedIndex);
//           case 6:
//             return makeGroupData(6, 6.5, isTouched: i == touchedIndex);
//           default:
//             return throw Error();
//         }
//       });

//   BarChartData mainBarData() {
//     return BarChartData(
//       barTouchData: BarTouchData(
//         touchTooltipData: BarTouchTooltipData(
//             tooltipBgColor: Colors.blueGrey,
//             getTooltipItem: (group, groupIndex, rod, rodIndex) {
//               String weekDay;
//               switch (group.x.toInt()) {
//                 case 0:
//                   weekDay = 'Monday';
//                   break;
//                 case 1:
//                   weekDay = 'Tuesday';
//                   break;
//                 case 2:
//                   weekDay = 'Wednesday';
//                   break;
//                 case 3:
//                   weekDay = 'Thursday';
//                   break;
//                 case 4:
//                   weekDay = 'Friday';
//                   break;
//                 case 5:
//                   weekDay = 'Saturday';
//                   break;
//                 case 6:
//                   weekDay = 'Sunday';
//                   break;
//                 default:
//                   throw Error();
//               }
//               return BarTooltipItem(
//                 weekDay + '\n',
//                 const TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 18,
//                 ),
//                 children: <TextSpan>[
//                   TextSpan(
//                     text: (rod.y - 1).toString(),
//                     style: const TextStyle(
//                       color: Colors.yellow,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ],
//               );
//             }),
//         touchCallback: (FlTouchEvent event, barTouchResponse) {
//           setState(() {
//             if (!event.isInterestedForInteractions ||
//                 barTouchResponse == null ||
//                 barTouchResponse.spot == null) {
//               touchedIndex = -1;
//               return;
//             }
//             touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
//           });
//         },
//       ),
//       titlesData: FlTitlesData(
//         show: true,
//         rightTitles: SideTitles(showTitles: false),
//         topTitles: SideTitles(showTitles: false),
//         bottomTitles: SideTitles(
//           showTitles: true,
//           getTextStyles: (context, value) => const TextStyle(
//               color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
//           margin: 16,
//           getTitles: (double value) {
//             switch (value.toInt()) {
//               case 0:
//                 return 'M';
//               case 1:
//                 return 'T';
//               case 2:
//                 return 'W';
//               case 3:
//                 return 'T';
//               case 4:
//                 return 'F';
//               case 5:
//                 return 'S';
//               case 6:
//                 return 'S';
//               default:
//                 return '';
//             }
//           },
//         ),
//         leftTitles: SideTitles(
//           showTitles: false,
//         ),
//       ),
//       borderData: FlBorderData(
//         show: false,
//       ),
//       barGroups: showingGroups(),
//       gridData: FlGridData(show: false),
//     );
//   }

//   BarChartData randomData() {
//     return BarChartData(
//       barTouchData: BarTouchData(
//         enabled: false,
//       ),
//       titlesData: FlTitlesData(
//           show: true,
//           bottomTitles: SideTitles(
//             showTitles: true,
//             getTextStyles: (context, value) => const TextStyle(
//                 color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
//             margin: 16,
//             getTitles: (double value) {
//               switch (value.toInt()) {
//                 case 0:
//                   return 'M';
//                 case 1:
//                   return 'T';
//                 case 2:
//                   return 'W';
//                 case 3:
//                   return 'T';
//                 case 4:
//                   return 'F';
//                 case 5:
//                   return 'S';
//                 case 6:
//                   return 'S';
//                 default:
//                   return '';
//               }
//             },
//           ),
//           leftTitles: SideTitles(
//             showTitles: false,
//           ),
//           topTitles: SideTitles(
//             showTitles: false,
//           ),
//           rightTitles: SideTitles(
//             showTitles: false,
//           )),
//       borderData: FlBorderData(
//         show: false,
//       ),
//       barGroups: List.generate(7, (i) {
//         switch (i) {
//           case 0:
//             return makeGroupData(0, Random().nextInt(15).toDouble() + 6,
//                 barColor: widget.availableColors[
//                     Random().nextInt(widget.availableColors.length)]);
//           case 1:
//             return makeGroupData(1, Random().nextInt(15).toDouble() + 6,
//                 barColor: widget.availableColors[
//                     Random().nextInt(widget.availableColors.length)]);
//           case 2:
//             return makeGroupData(2, Random().nextInt(15).toDouble() + 6,
//                 barColor: widget.availableColors[
//                     Random().nextInt(widget.availableColors.length)]);
//           case 3:
//             return makeGroupData(3, Random().nextInt(15).toDouble() + 6,
//                 barColor: widget.availableColors[
//                     Random().nextInt(widget.availableColors.length)]);
//           case 4:
//             return makeGroupData(4, Random().nextInt(15).toDouble() + 6,
//                 barColor: widget.availableColors[
//                     Random().nextInt(widget.availableColors.length)]);
//           case 5:
//             return makeGroupData(5, Random().nextInt(15).toDouble() + 6,
//                 barColor: widget.availableColors[
//                     Random().nextInt(widget.availableColors.length)]);
//           case 6:
//             return makeGroupData(6, Random().nextInt(15).toDouble() + 6,
//                 barColor: widget.availableColors[
//                     Random().nextInt(widget.availableColors.length)]);
//           default:
//             return throw Error();
//         }
//       }),
//       gridData: FlGridData(show: false),
//     );
//   }

//   Future<dynamic> refreshState() async {
//     setState(() {});
//     await Future<dynamic>.delayed(
//         animDuration + const Duration(milliseconds: 50));
//     if (isPlaying) {
//       await refreshState();
//     }
//   }
// }
