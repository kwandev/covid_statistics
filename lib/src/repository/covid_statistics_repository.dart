import 'package:covid_statistics/src/model/covid_statistics.dart';
import 'package:dio/dio.dart';
import 'package:xml/xml.dart';

class CovidStatisticsRepository {
  late var _dio;

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
                <accDefRate>2.0713328329</accDefRate>
                <accExamCnt>13350361</accExamCnt>
                <accExamCompCnt>12499826</accExamCompCnt>
                <careCnt>26193</careCnt>
                <clearCnt>230405</clearCnt>
                <createDt>2021-09-04 09:41:36.458</createDt>
                <deathCnt>2315</deathCnt>
                <decideCnt>258913</decideCnt>
                <examCnt>850535</examCnt>
                <resutlNegCnt>12240913</resutlNegCnt>
                <seq>624</seq>
                <stateDt>20210904</stateDt>
                <stateTime>00:00</stateTime>
                <updateDt>null</updateDt>
            </item>
            <item>
                <accDefRate>2.0632295530</accDefRate>
                <accExamCnt>13286681</accExamCnt>
                <accExamCompCnt>12461483</accExamCompCnt>
                <careCnt>26183</careCnt>
                <clearCnt>228618</clearCnt>
                <createDt>2021-09-03 09:44:30.979</createDt>
                <deathCnt>2308</deathCnt>
                <decideCnt>257109</decideCnt>
                <examCnt>825198</examCnt>
                <resutlNegCnt>12204374</resutlNegCnt>
                <seq>623</seq>
                <stateDt>20210903</stateDt>
                <stateTime>00:00</stateTime>
                <updateDt>2021-09-04 15:06:28.146</updateDt>
            </item>
            <item>
                <accDefRate>2.0590916684</accDefRate>
                <accExamCnt>13223515</accExamCnt>
                <accExamCompCnt>12403576</accExamCompCnt>
                <careCnt>26876</careCnt>
                <clearCnt>226222</clearCnt>
                <createDt>2021-09-02 09:37:25.055</createDt>
                <deathCnt>2303</deathCnt>
                <decideCnt>255401</decideCnt>
                <examCnt>819939</examCnt>
                <resutlNegCnt>12148175</resutlNegCnt>
                <seq>622</seq>
                <stateDt>20210902</stateDt>
                <stateTime>00:00</stateTime>
                <updateDt>null</updateDt>
            </item>
            <item>
                <accDefRate>2.0486353666</accDefRate>
                <accExamCnt>13152141</accExamCnt>
                <accExamCompCnt>12371162</accExamCompCnt>
                <careCnt>26829</careCnt>
                <clearCnt>224319</clearCnt>
                <createDt>2021-09-01 09:37:02.395</createDt>
                <deathCnt>2292</deathCnt>
                <decideCnt>253440</decideCnt>
                <examCnt>780979</examCnt>
                <resutlNegCnt>12117722</resutlNegCnt>
                <seq>621</seq>
                <stateDt>20210901</stateDt>
                <stateTime>00:00</stateTime>
                <updateDt>2021-09-02 11:26:21.248</updateDt>
            </item>
            <item>
                <accDefRate>2.0368337206</accDefRate>
                <accExamCnt>13094713</accExamCnt>
                <accExamCompCnt>12343472</accExamCompCnt>
                <careCnt>27430</careCnt>
                <clearCnt>221701</clearCnt>
                <createDt>2021-08-31 09:38:37.509</createDt>
                <deathCnt>2285</deathCnt>
                <decideCnt>251416</decideCnt>
                <examCnt>751241</examCnt>
                <resutlNegCnt>12092056</resutlNegCnt>
                <seq>620</seq>
                <stateDt>20210831</stateDt>
                <stateTime>00:00</stateTime>
                <updateDt>2021-09-02 11:20:18.53</updateDt>
            </item>
            <item>
                <accDefRate>2.0357291030</accDefRate>
                <accExamCnt>13049679</accExamCnt>
                <accExamCompCnt>12282872</accExamCompCnt>
                <careCnt>27404</careCnt>
                <clearCnt>220358</clearCnt>
                <createDt>2021-08-30 09:40:07.28</createDt>
                <deathCnt>2284</deathCnt>
                <decideCnt>250046</decideCnt>
                <examCnt>766807</examCnt>
                <resutlNegCnt>12032826</resutlNegCnt>
                <seq>619</seq>
                <stateDt>20210830</stateDt>
                <stateTime>00:00</stateTime>
                <updateDt>2021-09-02 11:17:07.934</updateDt>
            </item>
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
        <totalCount>9</totalCount>
    </body>
</response>''';

  CovidStatisticsRepository() {
    _dio = Dio(BaseOptions(
        baseUrl: 'http://openapi.data.go.kr',
        queryParameters: {'ServiceKey': ''}));
  }

  Future<List<Covid19StatisticsModel>> fetchCovid19Statistics(
      String? startDate, String? endDate) async {
    var query = <String, String>{};

    if (startDate != null) {
      query.putIfAbsent('startCreateDt', () => startDate);
    }
    if (endDate != null) {
      query.putIfAbsent('endCreateDt', () => endDate);
    }

    var response = await _dio.get(
        '/openapi/service/rest/Covid19/getCovid19InfStateJson',
        queryParameters: query);

    final document = XmlDocument.parse(response.data);
    // final document = XmlDocument.parse(bookshelfXml);
    final results = document.findAllElements('item');

    if (results.isNotEmpty) {
      return results
          .map<Covid19StatisticsModel>((e) => Covid19StatisticsModel.fromXml(e))
          .toList();
    } else {
      return Future.value([]);
    }
  }
}
