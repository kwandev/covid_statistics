import 'package:covid_statistics/src/canvas/arrow_clip_path.dart';
import 'package:covid_statistics/src/components/covid_statistics_viewer.dart';
import 'package:covid_statistics/src/controller/covid_statistics_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/covid_chart.dart';

class App extends GetView<CovidStatisticsController> {
  App({Key? key}) : super(key: key);

  late double headerTopZone;

  Widget infoWidget(String title, String value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(title,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          Text(": ${value}", style: const TextStyle(fontSize: 15))
        ],
      ),
    );
  }

  List<Widget> _background() {
    return [
      Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                colors: [Color(0xff3c727c), Color(0xff33656e)])),
      ),
      Positioned(
        top: headerTopZone + 40,
        left: -110,
        child: Image.asset('assets/covid_img.png', width: Get.size.width * 0.7),
      ),
      Positioned(
        top: headerTopZone + 10,
        left: 0,
        right: 0,
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xff195f68)),
            child: Obx(() => Text(controller.todayData.statndardDayString,
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold))),
          ),
        ),
      ),
      Positioned(
        top: headerTopZone + 60,
        right: 40,
        child: Obx(() => CovidStatisticsViewer(
              title: '확진자',
              titleColor: Colors.white,
              addedCount: controller.todayData.calcDecideCnt,
              totalCount: controller.todayData.decideCnt ?? 0,
              upDown: controller.calcUpDown(controller.todayData.calcDecideCnt),
              subValueColor: Colors.white,
            )),
      )
    ];
  }

  Widget _todayStatistics() {
    return Obx(() => Row(children: [
          Expanded(
            child: CovidStatisticsViewer(
              title: '격리해제',
              addedCount: controller.todayData.calcClearCnt,
              totalCount: controller.todayData.clearCnt ?? 0,
              upDown: controller.calcUpDown(controller.todayData.calcClearCnt),
              dense: true,
            ),
          ),
          const SizedBox(
              height: 60,
              child: VerticalDivider(
                color: Colors.black38,
              )),
          Expanded(
            child: CovidStatisticsViewer(
              title: '검사중',
              addedCount: controller.todayData.calcExamCnt,
              totalCount: controller.todayData.examCnt ?? 0,
              upDown: controller.calcUpDown(controller.todayData.calcExamCnt),
              dense: true,
            ),
          ),
          const SizedBox(
              height: 60,
              child: VerticalDivider(
                color: Colors.black38,
              )),
          Expanded(
            child: CovidStatisticsViewer(
              title: '사망자',
              addedCount: controller.todayData.calcDeathCnt,
              totalCount: controller.todayData.deathCnt ?? 0,
              upDown: controller.calcUpDown(controller.todayData.calcDeathCnt),
              dense: true,
            ),
          ),
        ]));
  }

  Widget _covidTrendsChart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('확진자 추이',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        Obx(() => controller.weekDatas.isNotEmpty
            ? CovidChart(
                covidDatas: controller.weekDatas,
                maxY: controller.maxDecideValue)
            : Container())
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    headerTopZone = Get.mediaQuery.padding.top + AppBar().preferredSize.height;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
          title: const Text("코로나 일별 현황", style: TextStyle(color: Colors.white)),
          elevation: 0,
          centerTitle: true,
          actions: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: const Icon(
                Icons.notifications,
                color: Colors.white,
              ),
            )
          ],
        ),
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            ..._background(),
            Positioned(
                top: headerTopZone + 200,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40))),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(25),
                      child: Column(
                        children: [
                          _todayStatistics(),
                          const SizedBox(
                            height: 20,
                          ),
                          _covidTrendsChart()
                        ],
                      ),
                    )))
          ],
        ));
  }
}
