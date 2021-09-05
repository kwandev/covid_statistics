import 'dart:ffi';

import 'package:covid_statistics/src/model/covid_statistics.dart';
import 'package:covid_statistics/src/utils/data_utils.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CovidChart extends StatelessWidget {
  final List<Covid19StatisticsModel> covidDatas;
  final double maxY;

  const CovidChart({Key? key, required this.covidDatas, required this.maxY})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.7,
      child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          child: BarChart(
            BarChartData(
              barTouchData: barTouchData,
              titlesData: titlesData,
              borderData: borderData,
              barGroups: barGroups(),
              alignment: BarChartAlignment.spaceAround,
              maxY: maxY * 1.4,
            ),
          )),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
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
              rod.y.round().toString(),
              const TextStyle(
                color: Colors.black,
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
            fontSize: 14,
          ),
          margin: 20,
          getTitles: (double value) {
            return DataUtils.simpleDateFormat(
                covidDatas[value.toInt()].stateDt!);
          },
        ),
        leftTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
        rightTitles: SideTitles(showTitles: false),
      );

  FlBorderData get borderData => FlBorderData(show: false);

  List<BarChartGroupData> barGroups() {
    var x = 0;
    return covidDatas.map<BarChartGroupData>((e) {
      return BarChartGroupData(
        x: x++,
        barRods: [
          BarChartRodData(
              y: e.calcDecideCnt,
              colors: [Colors.lightBlueAccent, Colors.greenAccent])
        ],
        showingTooltipIndicators: [0],
      );
    }).toList();
  }
}
