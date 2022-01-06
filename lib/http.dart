import 'package:dio/dio.dart';

import './main.dart';



getHttp(int tInd) async {
  try {
    if (tInd == 0) {
      response = await Dio().get(
          "http://www.boredapi.com/api/activity?type=${tec[0].text.toString()}");
    }
    if (tInd == 1) {
      response = await Dio().get(
          "http://www.boredapi.com/api/activity?participants=${tec[1].text.toString()}");
    }
    if (tInd == 2) {
      response = await Dio().get(
          "http://www.boredapi.com/api/activity?price=${tec[2].text.toString()}");
    }
    if (tInd == 3) {
      double lowerValue2 = lowerValue / 100;
      double upperValue2 = upperValue / 100;
      response = await Dio().get(
          "http://www.boredapi.com/api/activity?minprice=$lowerValue2&maxprice=$upperValue2");
    }
    if (tInd == 4) {
      response = await Dio()
          .get("http://www.boredapi.com/api/activity?accessibility=$activity");
    }
  } catch (e) {
    print(e);
  }
  return 0;
}
