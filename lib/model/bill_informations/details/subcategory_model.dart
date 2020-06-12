import 'package:expenses_mobile/model/bill_informations/details/id_value_model.dart';

class SubCategoryModel extends IdValueModel {
  var categoryValue = '';
  var numberOfPerson = 0;
  var attendees = '';
  var numberOfTravelledDay = 0;

  SubCategoryModel();

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    var result = SubCategoryModel();
    result.fromJson(json);
    result.numberOfPerson = json['numberOfPerson'] as int ?? 0;

    return result;
  }
}

//Id: 161, Value: Restaurant, CategoryValue: , NumberOfPerson: 2, Attendees: Myself,MBU, NumberOfTravelledDay: null
