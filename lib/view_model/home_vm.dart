import 'package:expenses_mobile/model/banner_count_model.dart';
import 'package:expenses_mobile/network/expenses_api_client/expenses_api_client.dart';
import 'package:expenses_mobile/view_model/base/base_vm.dart';

class HomeViewModel extends BaseViewModel {
  var text = '';
  BannerCountModel bannerCountModel;

  int get draftsTotal {
    return bannerCountModel == null ? 0 : bannerCountModel.totalDraftExpenses;
  }

  int get pendingOnATeamExpensesTotal {
    return bannerCountModel == null
        ? 0
        : bannerCountModel.totalPendingATeamCorpHRExpenses;
  }

  int get pendingOnManagerExpensesTotal {
    return bannerCountModel == null
        ? 0
        : bannerCountModel.totalPendingManageesExpenses;
  }

  int get validatedByManagerExpensesTotal {
    return bannerCountModel == null
        ? 0
        : bannerCountModel.totalValidatedByManagerExpenses;
  }

  double get draftsTotalAmount {
    return bannerCountModel == null
        ? 0.0
        : bannerCountModel.totalAmountDraftExpenses;
  }

  double get pendingATeamTotalAmount {
    return bannerCountModel == null
        ? 0.0
        : bannerCountModel.totalAmountPendingATeamCorpHRExpenses;
  }

  double get pendingManagerTotalAmount {
    return bannerCountModel == null
        ? 0.0
        : bannerCountModel.totalAmountPendingManagerExpenses;
  }

  double get validatedByManagerTotalAmount {
    return bannerCountModel == null
        ? 0.0
        : bannerCountModel.totalAmountValidatedByManagerExpenses;
  }

  String get draftsCurrency {
    return bannerCountModel == null ? '' : bannerCountModel.draftCurrency;
  }

  String get pendingOnATeamCurrency {
    return bannerCountModel == null
        ? ''
        : bannerCountModel.pendingATeamCurrency;
  }

  String get pendingOnManagerCurrency {
    return bannerCountModel == null
        ? ''
        : bannerCountModel.pendingManagerCurrency;
  }

  String get validatedByManagerCurrency {
    return bannerCountModel == null
        ? ''
        : bannerCountModel.validatedByManagerCurrency;
  }

  Future loadBannerCount() async {
    final result = await getBannerCount();
    if (result.isSuccess) {
      print('Successfully loaded banner count');
      bannerCountModel = result.model;
    }
    notifyListeners();
  }
}
