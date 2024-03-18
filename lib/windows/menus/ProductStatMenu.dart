// ignore_for_file: public_member_api_docs, sort_constructors_first, file_names
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ProductStat extends StatefulWidget {
  const ProductStat({
    super.key,
    required this.productList,
  });
  final dynamic productList;

  List<Color> get availableColors => const <Color>[
        Colors.purple,
        Colors.yellow,
        Colors.green,
        Colors.blue,
        Colors.orange,
        Colors.pink,
        Colors.red,
      ];

  @override
  State<ProductStat> createState() => _ProductStatState();
}

class _ProductStatState extends State<ProductStat> {
  int touchedIndex = -1;

  final Duration animDuration = const Duration(milliseconds: 250);

  bool isPlaying = false;
  late double monday;
  late double tuesday;
  late double wednesday;
  late double thursday;
  late double friday;
  late double saturday;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print((widget.productList as List)
        .toList()
        .where((element) => element["date"] == "dimanche")
        .toList()
        .map((e) => e["salePrice"])
        .toList()
        .fold<double>(0, (previousValue, element) => previousValue + element));
    // print((widget.productList as List)
    //     .toList()
    //     .map((e) => e["date"])
    //     .skipWhile((element) => element != "dimanche"));
    monday = (widget.productList as List)
        .toList()
        .where((element) => element["date"] == "lundi")
        .toList()
        .map((e) => e["salePrice"])
        .toList()
        .fold<double>(0, (previousValue, element) => previousValue + element)
        .toDouble();
    tuesday = (widget.productList as List)
        .toList()
        .where((element) => element["date"] == "mardi")
        .toList()
        .map((e) => e["salePrice"])
        .toList()
        .fold<double>(0, (previousValue, element) => previousValue + element)
        .toDouble();
    wednesday = (widget.productList as List)
        .toList()
        .where((element) => element["date"] == "mercredi")
        .toList()
        .map((e) => e["salePrice"])
        .toList()
        .fold<double>(0, (previousValue, element) => previousValue + element)
        .toDouble();
    thursday = (widget.productList as List)
        .toList()
        .where((element) => element["date"] == "jeudi")
        .toList()
        .map((e) => e["salePrice"])
        .toList()
        .fold<double>(0, (previousValue, element) => previousValue + element)
        .toDouble();
    friday = (widget.productList as List)
        .toList()
        .where((element) => element["date"] == "vendredi")
        .toList()
        .map((e) => e["salePrice"])
        .toList()
        .fold<double>(0, (previousValue, element) => previousValue + element)
        .toDouble();
    saturday = (widget.productList as List)
        .toList()
        .where((element) => element["date"] == "samedi")
        .toList()
        .map((e) => e["salePrice"])
        .toList()
        .fold<double>(0, (previousValue, element) => previousValue + element)
        .toDouble();
    return SingleChildScrollView(
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Statistiques des produits",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                    fontSize: 20),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Status de la semaine",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  ),
                  Row(
                    children: [
                      Statwidget(
                        color: Colors.purple,
                        title: "Valeur",
                        value: monday,
                      ),
                      Statwidget(
                        color: Colors.yellow,
                        title: "Valeur",
                        value: tuesday,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Statwidget(
                        color: Colors.green,
                        title: "Valeur",
                        value: wednesday,
                      ),
                      Statwidget(
                        color: Colors.blue,
                        title: "Valeur",
                        value: thursday,
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Statwidget(
                        color: Colors.orange,
                        title: "Valeur",
                        value: friday,
                      ),
                      Statwidget(
                        color: Colors.pink,
                        title: "Valeur",
                        value: saturday,
                      ),
                    ],
                  ),
                  // Statwidget(
                  //   color: Colors.red,
                  //   title: "Valeur",
                  //   value: 10000.000,
                  // ),
                  //           Colors.orange,
                  // Colors.pink,
                  // Colors.red,
                ],
              ),
              Container(
                // color: Colors.black,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                height: 250,
                width: 250,
                child: PieChart(
                  PieChartData(
                      sections: showingSections(),
                      pieTouchData: PieTouchData(
                        enabled: false,
                        touchCallback: (FlTouchEvent event, pieTouchResponse) {
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
                      )),
                ),
              ),
            ],
          ),
          // const SizedBox(height: 20),
          Container(
            color: Colors.blue.withAlpha(20),
            height: size.height * 0.3,
            width: size.width,
            child: BarChart(mainBarData()),
          ),
          const Text(
            "Statistiques des produits",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w600, fontSize: 14),
          ),
        ],
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color? barColor,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    barColor ??= Colors.amber.withAlpha(200);
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y + 1 : y,
          color: isTouched ? Colors.amber : barColor,
          width: width,
          borderSide: isTouched
              ? BorderSide(color: Colors.green.withAlpha(80))
              : const BorderSide(color: Colors.white, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 20,
            color: Colors.blueAccent,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(6, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, 8, isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(1, 6.5, isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(2, 5, isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(3, 5, isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(4, 5, isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(5, 5, isTouched: i == touchedIndex);
          // case 6:
          //   return makeGroupData(6, 5, isTouched: i == touchedIndex);
          default:
            return throw Error();
        }
      });

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.blueGrey,
          tooltipHorizontalAlignment: FLHorizontalAlignment.right,
          tooltipMargin: -10,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            String weekDay;
            switch (group.x) {
              case 0:
                weekDay = 'Lundi';
                break;
              case 1:
                weekDay = 'Mardi';
                break;
              case 2:
                weekDay = 'Mercredi';
                break;
              case 3:
                weekDay = 'Jeudi';
                break;
              case 4:
                weekDay = 'Vendredi';
                break;
              case 5:
                weekDay = 'Samedi';
                break;
              case 6:
                weekDay = 'Dimanche';
                break;
              default:
                throw Error();
            }
            return BarTooltipItem(
              '$weekDay\n',
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: (rod.toY - 1).toString(),
                  style: const TextStyle(
                    color: Colors.green,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          },
        ),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 38,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
      gridData: const FlGridData(show: false),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.blue,
      fontWeight: FontWeight.bold,
      fontSize: 14,
      backgroundColor: Colors.white,
    );

    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('Lundi', style: style);
        break;
      case 1:
        text = const Text('Mardi', style: style);
        break;
      case 2:
        text = const Text('Mercredi', style: style);
        break;
      case 3:
        text = const Text('Jeudi', style: style);
        break;
      case 4:
        text = const Text('Vendredi', style: style);
        break;
      case 5:
        text = const Text('Samedi', style: style);
        break;
      // case 6:
      //   text = const Text('D', style: style);
      //   break;
      default:
        text = const Text('', style: style);
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }

  BarChartData randomData() {
    return BarChartData(
      barTouchData: BarTouchData(
        enabled: false,
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 38,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: List.generate(6, (i) {
        switch (i) {
          case 0:
            return makeGroupData(
              0,
              Random().nextInt(15).toDouble() + 6,
              barColor: widget.availableColors[
                  Random().nextInt(widget.availableColors.length)],
            );
          case 1:
            return makeGroupData(
              1,
              Random().nextInt(15).toDouble() + 6,
              barColor: widget.availableColors[
                  Random().nextInt(widget.availableColors.length)],
            );
          case 2:
            return makeGroupData(
              2,
              Random().nextInt(15).toDouble() + 6,
              barColor: widget.availableColors[
                  Random().nextInt(widget.availableColors.length)],
            );
          case 3:
            return makeGroupData(
              3,
              Random().nextInt(15).toDouble() + 6,
              barColor: widget.availableColors[
                  Random().nextInt(widget.availableColors.length)],
            );
          case 4:
            return makeGroupData(
              4,
              Random().nextInt(15).toDouble() + 6,
              barColor: widget.availableColors[
                  Random().nextInt(widget.availableColors.length)],
            );
          case 5:
            return makeGroupData(
              5,
              Random().nextInt(15).toDouble() + 6,
              barColor: widget.availableColors[
                  Random().nextInt(widget.availableColors.length)],
            );
          // case 6:
          //   return makeGroupData(
          //     6,
          //     Random().nextInt(15).toDouble() + 6,
          //     barColor: widget.availableColors[
          //         Random().nextInt(widget.availableColors.length)],
          //   );
          default:
            return throw Error();
        }
      }),
      gridData: const FlGridData(show: false),
    );
  }

  // List<BarChartGroupData> showingGroups() => List.generate(7, (i) {
  //       switch (i) {
  //         case 0:
  //           return makeGroupData(0, 5, isTouched: i == touchedIndex);
  //         case 1:
  //           return makeGroupData(1, 6.5, isTouched: i == touchedIndex);
  //         case 2:
  //           return makeGroupData(2, 5, isTouched: i == touchedIndex);
  //         case 3:
  //           return makeGroupData(3, 7.5, isTouched: i == touchedIndex);
  //         case 4:
  //           return makeGroupData(4, 9, isTouched: i == touchedIndex);
  //         case 5:
  //           return makeGroupData(5, 11.5, isTouched: i == touchedIndex);
  //         case 6:
  //           return makeGroupData(6, 6.5, isTouched: i == touchedIndex);
  //         default:
  //           return throw Error();
  //       }
  //     });

  List<PieChartSectionData> showingSections() {
    return List.generate(6, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
              badgePositionPercentageOffset: .98,
              color: Colors.purple,
              value: 40,
              title: '40%',
              radius: radius,
              titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: shadows,
              ),
              badgeWidget: isTouched ? const CircleAvatar() : null);
        case 1:
          return PieChartSectionData(
              badgePositionPercentageOffset: .98,
              color: Colors.yellow,
              value: 30,
              title: '30%',
              radius: radius,
              titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: shadows,
              ),
              badgeWidget: isTouched ? const CircleAvatar() : null);
        case 2:
          return PieChartSectionData(
              badgePositionPercentageOffset: .98,
              color: Colors.green,
              value: 15,
              title: '15%',
              radius: radius,
              titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: shadows,
              ),
              badgeWidget: isTouched ? const CircleAvatar() : null);
        case 3:
          return PieChartSectionData(
              badgePositionPercentageOffset: .98,
              color: Colors.blue,
              value: 15,
              title: '15%',
              radius: radius,
              titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: shadows,
              ),
              badgeWidget: isTouched ? const CircleAvatar() : null);
        case 4:
          return PieChartSectionData(
              badgePositionPercentageOffset: .98,
              color: Colors.orange,
              value: 15,
              title: '15%',
              radius: radius,
              titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: shadows,
              ),
              badgeWidget: isTouched ? const CircleAvatar() : null);
        case 5:
          return PieChartSectionData(
              badgePositionPercentageOffset: .98,
              color: Colors.pink,
              value: 15,
              title: '15%',
              radius: radius,
              titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: shadows,
              ),
              badgeWidget: isTouched ? const CircleAvatar() : null);
        // case 6:
        //   return PieChartSectionData(
        //       badgePositionPercentageOffset: .98,
        //       color: Colors.red,
        //       value: 15,
        //       title: '15%',
        //       radius: radius,
        //       titleStyle: TextStyle(
        //         fontSize: fontSize,
        //         fontWeight: FontWeight.bold,
        //         color: Colors.white,
        //         shadows: shadows,
        //       ),
        //       badgeWidget: isTouched ? const CircleAvatar() : null);
        default:
          throw Error();
      }
    });
  }
}

class Statwidget extends StatelessWidget {
  const Statwidget({
    super.key,
    required this.color,
    required this.title,
    required this.value,
  });
  final Color color;
  final String title;
  final double value;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      margin: const EdgeInsets.only(bottom: 5, left: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withAlpha(50),
                spreadRadius: 2,
                blurRadius: 0.2,
                offset: const Offset(0, 3)),
          ]),
      child: Row(
        children: [
          Container(
            height: 30,
            width: 30,
            margin: const EdgeInsets.only(right: 30),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Column(
            children: [
              Text(title),
              RichText(
                text: TextSpan(
                    text: "$value",
                    style: const TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontSize: 12,
                        fontWeight: FontWeight.w800),
                    children: const [
                      TextSpan(
                        text: " F CFA",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w800),
                      )
                    ]),
              ),
            ],
          )
          // const Text(

          // ),
        ],
      ),
    );
  }
}
