class BannerCountModel {
  var totalDraftExpenses = 0;
  var totalAmountDraftExpenses = 0.0;
  var totalDraftCurrencies = 0;
  var totalUncompliantDraftExpenses = 0;
  var totalPendingATeamCorpHRExpenses = 0;
  var totalAmountPendingATeamCorpHRExpenses = 0.0;
  var totalPendingATeamCurrencies = 0;
  var totalPendingManagerExpenses = 0;
  var totalAmountPendingManagerExpenses = 0.0;
  var totalPendingManagerCurrencies = 0;
  var totalPendingPaymentExpenses = 0;
  var totalAmountPendingPaymentExpenses = 0.0;
  var totalPendingPaymentCurrencies = 0;
  var totalValidatedByManagerExpenses = 0;
  var totalAmountValidatedByManagerExpenses = 0.0;
  var totalValidatedByManagerCurrencies = 0;
  var totalRefusedExpenses = 0;
  var totalPendingManageesExpenses = 0;
  var totalPendingComplianceExpenses = 0;
  var draftCurrency = '';
  var pendingATeamCurrency = '';
  var pendingManagerCurrency = '';
  var pendingPaymentCurrency = '';
  var validatedByManagerCurrency = '';

  BannerCountModel();

  factory BannerCountModel.fromResponseJson(Map<String, dynamic> json) {
    var model = BannerCountModel();
    model.draftCurrency = json['DraftCurrency'] as String ?? '';
    model.pendingATeamCurrency = json['PendingATeamCurrency'] as String ?? '';
    model.pendingManagerCurrency =
        json['PendingManagerCurrency'] as String ?? '';
    model.pendingPaymentCurrency =
        json['PendingPaymentCurrency'] as String ?? '';
    model.validatedByManagerCurrency =
        json['ValidatedByManagerCurrency'] as String ?? '';

    model.validatedByManagerCurrency =
        json['ValidatedByManagerCurrency'] as String ?? '';

    model.totalDraftExpenses = json['TotalDraftExpenses'] as int ?? 0;
    model.totalAmountDraftExpenses =
        json['TotalAmountDraftExpenses'] as double ?? 0;
    model.totalDraftCurrencies = json['TotalDraftCurrencies'] as int ?? 0;
    model.totalUncompliantDraftExpenses =
        json['TotalUncompliantDraftExpenses'] as int ?? 0;
    model.totalPendingATeamCorpHRExpenses =
        json['TotalPendingATeamCorpHRExpenses'] as int ?? 0;
    model.totalAmountPendingATeamCorpHRExpenses =
        json['TotalAmountPendingATeamCorpHRExpenses'] as double ?? 0;
    model.totalPendingATeamCurrencies =
        json['TotalPendingATeamCurrencies'] as int ?? 0;
    model.totalPendingManagerExpenses =
        json['TotalPendingManagerExpenses'] as int ?? 0;
    model.totalAmountPendingManagerExpenses =
        json['TotalAmountPendingManagerExpenses'] as double ?? 0;
    model.totalPendingManagerCurrencies =
        json['TotalPendingManagerCurrencies'] as int ?? 0;
    model.totalPendingPaymentExpenses =
        json['TotalPendingPaymentExpenses'] as int ?? 0;
    model.totalAmountPendingPaymentExpenses =
        json['TotalAmountPendingPaymentExpenses'] as double ?? 0;
    model.totalPendingPaymentCurrencies =
        json['TotalPendingPaymentCurrencies'] as int ?? 0;
    model.totalValidatedByManagerExpenses =
        json['TotalValidatedByManagerExpenses'] as int ?? 0;
    model.totalAmountValidatedByManagerExpenses =
        json['TotalAmountValidatedByManagerExpenses'] as double ?? 0;
    model.totalValidatedByManagerCurrencies =
        json['TotalValidatedByManagerCurrencies'] as int ?? 0;
    model.totalRefusedExpenses = json['TotalRefusedExpenses'] as int ?? 0;
    model.totalPendingManageesExpenses =
        json['TotalPendingManageesExpenses'] as int ?? 0;
    model.totalPendingComplianceExpenses =
        json['TotalPendingComplianceExpenses'] as int ?? 0;

    return model;
  }
}
