import 'package:expenses_mobile/model/bill_informations/details/id_value_model.dart';

class BankAccountModel extends IdValueModel {
  BankAccountModel() : super();

  factory BankAccountModel.fromJson(Map<String, dynamic> json) {
    var result = BankAccountModel();
    result.fromJson(json);
    return result;
  }
}
