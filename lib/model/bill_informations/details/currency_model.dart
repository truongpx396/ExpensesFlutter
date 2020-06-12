import 'package:expenses_mobile/model/bill_informations/details/string_value_model.dart';

class CurrencyModel extends StringValueModel {
  CurrencyModel() : super();

  factory CurrencyModel.fromJson(Map<String, dynamic> json) {
    var result = CurrencyModel();
    result.fromJson(json);
    return result;
  }
}
