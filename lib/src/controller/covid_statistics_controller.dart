import 'package:covid_statistics/src/canvas/arrow_clip_path.dart';
import 'package:covid_statistics/src/model/covid_statistics.dart';
import 'package:covid_statistics/src/repository/covid_statistics_repository.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CovidStatisticsController extends GetxController {
  late CovidStatisticsRepository _covidStatisticsRepository;
  Rx<Covid19StatisticsModel> _todayData = Covid19StatisticsModel().obs;
  RxList<Covid19StatisticsModel> _weekDatas = <Covid19StatisticsModel>[].obs;
  double maxDecideValue = 0;

  @override
  void onInit() {
    super.onInit();

    _covidStatisticsRepository = CovidStatisticsRepository();

    fetchCovidState();
  }

  void fetchCovidState() async {
    var startDate = DateFormat('yyyyMMdd')
        .format(DateTime.now().subtract(const Duration(days: 8)));
    var endDate = DateFormat('yyyyMMdd').format(DateTime.now());

    var result = await _covidStatisticsRepository.fetchCovid19Statistics(
        startDate, endDate);

    if (result.isNotEmpty) {
      for (var i = 0; i < result.length; i++) {
        if (i < result.length - 1) {
          result[i].calcYesterday(result[i + 1]);

          if (result[i].calcDecideCnt > maxDecideValue) {
            maxDecideValue = result[i].calcDecideCnt;
          }
        }
      }

      _weekDatas.addAll(result.sublist(0, result.length - 1).reversed);
      _todayData(_weekDatas.last);
    }
  }

  Covid19StatisticsModel get todayData => _todayData.value;
  List<Covid19StatisticsModel> get weekDatas => _weekDatas;

  ArrowDirection calcUpDown(value) {
    if (value == 0) {
      return ArrowDirection.MIDDLE;
    } else if (value > 0) {
      return ArrowDirection.UP;
    } else {
      return ArrowDirection.DOWN;
    }
  }
}
