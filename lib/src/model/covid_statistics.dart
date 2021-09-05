import 'package:covid_statistics/src/utils/data_utils.dart';
import 'package:covid_statistics/src/utils/xml_utils.dart';
import 'package:xml/xml.dart';

class Covid19StatisticsModel {
  double? accDefRate;
  double? accExamCnt;
  double? accExamCompCnt;
  double? careCnt;
  double? clearCnt;
  double calcClearCnt = 0;
  double? deathCnt;
  double calcDeathCnt = 0;
  double? decideCnt;
  double calcDecideCnt = 0;
  double? examCnt;
  double calcExamCnt = 0;
  double? resutlNegCnt;
  double? seq;
  String? createDt;
  DateTime? stateDt;
  String? stateTime;
  String? updateDt;

  Covid19StatisticsModel({
    this.accDefRate,
    this.accExamCnt,
    this.accExamCompCnt,
    this.careCnt,
    this.clearCnt,
    this.createDt,
    this.deathCnt,
    this.decideCnt,
    this.examCnt,
    this.resutlNegCnt,
    this.seq,
    this.stateDt,
    this.stateTime,
    this.updateDt,
  });

  factory Covid19StatisticsModel.empty() {
    return Covid19StatisticsModel();
  }

  factory Covid19StatisticsModel.fromXml(XmlElement xml) {
    return Covid19StatisticsModel(
      accDefRate: XmlUtils.searchResultDouble(xml, 'accDefRate'),
      accExamCnt: XmlUtils.searchResultDouble(xml, 'accExamCnt'),
      accExamCompCnt: XmlUtils.searchResultDouble(xml, 'accExamCompCnt'),
      careCnt: XmlUtils.searchResultDouble(xml, 'careCnt'),
      clearCnt: XmlUtils.searchResultDouble(xml, 'clearCnt'),
      deathCnt: XmlUtils.searchResultDouble(xml, 'deathCnt'),
      decideCnt: XmlUtils.searchResultDouble(xml, 'decideCnt'),
      examCnt: XmlUtils.searchResultDouble(xml, 'examCnt'),
      resutlNegCnt: XmlUtils.searchResultDouble(xml, 'resutlNegCnt'),
      seq: XmlUtils.searchResultDouble(xml, 'seq'),
      createDt: XmlUtils.searchResult(xml, 'createDt'),
      stateDt: XmlUtils.searchResult(xml, 'stateDt') != ''
          ? DateTime.parse(XmlUtils.searchResult(xml, 'stateDt'))
          : null,
      stateTime: XmlUtils.searchResult(xml, 'stateTime'),
      updateDt: XmlUtils.searchResult(xml, 'updateDt'),
    );
  }

  void calcYesterday(Covid19StatisticsModel yesterdayData) {
    _updateCalcDecideCnt(yesterdayData.decideCnt!);
    _updateCalcExamCnt(yesterdayData.examCnt!);
    _updateCalcClearCnt(yesterdayData.clearCnt!);
    _updateCalcDeathCnt(yesterdayData.deathCnt!);
  }

  void _updateCalcDecideCnt(double beforeCnt) {
    calcDecideCnt = decideCnt! - beforeCnt;
  }

  void _updateCalcExamCnt(double beforeCnt) {
    calcExamCnt = examCnt! - beforeCnt;
  }

  void _updateCalcClearCnt(double beforeCnt) {
    calcClearCnt = clearCnt! - beforeCnt;
  }

  void _updateCalcDeathCnt(double beforeCnt) {
    calcDeathCnt = deathCnt! - beforeCnt;
  }

  String get statndardDayString => stateDt == null
      ? ''
      : '${DataUtils.simpleDateFormat(stateDt!)} $stateTime 기준';
}
