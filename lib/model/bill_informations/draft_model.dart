import 'package:expenses_mobile/model/bill_informations/details/bank_account_model.dart';
import 'package:expenses_mobile/model/bill_informations/details/company_model.dart';
import 'package:expenses_mobile/model/bill_informations/details/currency_model.dart';
import 'package:expenses_mobile/model/bill_informations/details/place_model.dart';
import 'package:expenses_mobile/model/bill_informations/details/subcategory_model.dart';

class DraftModel {
  var id = 0;
  var subCategory = SubCategoryModel();
  var date = DateTime.now();
  var picture = '';
  var costSupportedBy = '';
  var expenseTag = '';
  var isOutOfPolicy = false;
  var isReInvoicable = false;
  var value = 0.0;
  var place = PlaceModel();
  var details = '';
  var currency = CurrencyModel();
  var project = '';
  BankAccountModel bankAccount;
  CompanyModel company;
  var status = '';
  var reason = '';

  // UI Binding
  String get dateText {
    final text = '${date.day}/${date.month}/${date.year}';
    return text;
  }

  String get listItemTitle {
    var subCategoryText = '';
    if (subCategory != null &&
        subCategory.value != null &&
        subCategory.value.isNotEmpty) {
      subCategoryText = ' - ${subCategory.value}';
    }
    final text = '${date.day}/${date.month}/${date.year}$subCategoryText';
    return text;
  }

  String get companyText {
    if (company == null || company.value == null || company.value.isEmpty) {
      return '';
    }
    return company.value;
  }

  String get locationText {
    if (place == null || place.value == null || place.value.isEmpty) {
      return '';
    }
    return place.value;
  }

  String get subCategoryText {
    if (subCategory == null ||
        subCategory.value == null ||
        subCategory.value.isEmpty) {
      return '';
    }
    return subCategory.value;
  }

  String get valueText {
    if (value == null) {
      return '0';
    }
    if (currency == null || currency.id == null || currency.id.isEmpty) {
      return value.toString();
    }
    return '${value.toString()} ${currency.id}';
  }

  String get currencyText {
    if (currency == null || currency.id == null || currency.id.isEmpty) {
      return '';
    }
    return '${currency.value.toString()}';
  }

  String get bankAccountText {
    if (bankAccount == null ||
        bankAccount.value == null ||
        bankAccount.value.isEmpty) {
      return '';
    }
    return '${bankAccount.value.toString()}';
  }

  String get amountText {
    if (value == null) {
      return '0.0';
    }
    return '${value.toString()}';
  }

  DraftModel();

  static List<DraftModel> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<DraftModel>()
        : json.map((value) => new DraftModel.fromJson(value)).toList();
  }

  factory DraftModel.fromJson(Map<String, dynamic> json) {
    var result = DraftModel();
    result.id = json['Id'] as int ?? 0;
    result.value = json['Value'] as double ?? 0.0;
    result.details = json['Details'] as String ?? '';
    result.date = DateTime.parse(json['Date'] as String);
    result.bankAccount = BankAccountModel.fromJson(json['BankAccount']);
    result.subCategory = SubCategoryModel.fromJson(json['SubCategory']);
    result.currency = CurrencyModel.fromJson(json['Currency']);
    result.company = CompanyModel.fromJson(json['Company']);
    result.place = PlaceModel.fromJson(json['Place']);

    return result;
  }

  // 'BankAccount': bankAccount,
//      'Place': place,
//      'Date': date == null ? '' : date.toUtc().toIso8601String(),
//      'Picture': picture,
//      'IsPdf': isPdf,
//      'Details': details,
//      'NewSubcategory': newSubcategory,
//      'IsCompanyBusinessCard': isCompanyBusinessCard,
//      'CostSupportedBy': costSupportedBy,
//      'ExpenseTag': expenseTag,
//      'Company': company,
//      'Project': project,
//      'Status': status,
//      'Reason': reason,
//      'Currency': currency,
//      'Value': value,
//      'Id': id,
//      'SubCategory': subCategory,
//      'IsReInvoicable': isReInvoicable,
//      'IsOutOfPolicy': isOutOfPolicy

}
