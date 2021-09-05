import 'package:covid_statistics/src/model/covid_statistics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xml/xml.dart';

void main() {
  final bookshelfXml =
      '''<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<response>
    <header>
        <resultCode>00</resultCode>
        <resultMsg>NORMAL SERVICE.</resultMsg>
    </header>
    <body>
        <items>
            <item>
                <accDefRate>2.0285026332</accDefRate>
                <accExamCnt>13015918</accExamCnt>
                <accExamCompCnt>12253324</accExamCompCnt>
                <careCnt>27554</careCnt>
                <clearCnt>218726</clearCnt>
                <createDt>2021-08-29 09:30:47.611</createDt>
                <deathCnt>2279</deathCnt>
                <decideCnt>248559</decideCnt>
                <examCnt>762594</examCnt>
                <resutlNegCnt>12004765</resutlNegCnt>
                <seq>618</seq>
                <stateDt>20210829</stateDt>
                <stateTime>00:00</stateTime>
                <updateDt>2021-09-02 11:16:51.761</updateDt>
            </item>
            <item>
                <accDefRate>2.0174655735</accDefRate>
                <accExamCnt>12983485</accExamCnt>
                <accExamCompCnt>12240308</accExamCompCnt>
                <careCnt>27679</careCnt>
                <clearCnt>216989</clearCnt>
                <createDt>2021-08-28 09:51:58.552</createDt>
                <deathCnt>2276</deathCnt>
                <decideCnt>246944</decideCnt>
                <examCnt>743177</examCnt>
                <resutlNegCnt>11993364</resutlNegCnt>
                <seq>617</seq>
                <stateDt>20210828</stateDt>
                <stateTime>00:00</stateTime>
                <updateDt>2021-09-02 11:14:01.554</updateDt>
            </item>
        </items>
        <numOfRows>10</numOfRows>
        <pageNo>1</pageNo>
        <totalCount>7</totalCount>
    </body>
</response>''';

  test('코로나 전체 통계', () {
    final document = XmlDocument.parse(bookshelfXml);
    final items = document.findAllElements('item');

    var covid19statistcs = <Covid19StatisticsModel>[];

    items.forEach((node) {
      covid19statistcs.add(Covid19StatisticsModel.fromXml(node));
    });

    covid19statistcs.forEach((element) {
      print('${element.stateDt} : ${element.decideCnt}');
    });
  });
}
