import 'package:expenses_mobile/model/bill_informations/details/id_value_model.dart';

class PlaceModel extends IdValueModel {
  var currencyId = '';
  var countryId = '';
  var cityId = 0;

  PlaceModel() : super();

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    var result = PlaceModel();
    if (json == null) {
      return result;
    }
    result.fromJson(json);
    result.currencyId = json['CurrencyId'] as String ?? '';
    result.countryId = json['CountryId'] as String ?? '';
    result.cityId = json['CityId'] as int ?? -1;
    return result;
  }
}

//Place: {Id: null, Value: Genève, SWITZERLAND, CurrencyId: CHF, CountryId: CH, CityId: 43944}
