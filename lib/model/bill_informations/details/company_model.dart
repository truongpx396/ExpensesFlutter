import 'package:expenses_mobile/model/bill_informations/details/id_value_model.dart';

class CompanyModel extends IdValueModel {
  CompanyModel() : super();

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    var result = CompanyModel();
    result.fromJson(json);
    return result;
  }
}
