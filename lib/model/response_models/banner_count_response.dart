import 'package:expenses_mobile/model/banner_count_model.dart';

class BannerCountResponseModel {
  BannerCountModel model;
  int statusCode = 200;

  bool get isSuccess {
    return statusCode == 200;
  }

  bool get isCreated {
    return statusCode == 201;
  }

  BannerCountResponseModel({this.model, this.statusCode});

  factory BannerCountResponseModel.fromStatusCode(int statusCode) {
    return BannerCountResponseModel(statusCode: statusCode);
  }
}
