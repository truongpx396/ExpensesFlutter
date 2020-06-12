import 'package:expenses_mobile/model/bill_informations/enum.dart';
import 'package:expenses_mobile/network/expenses_api_client/expenses_api_client.dart';
import 'package:expenses_mobile/view_model/base/base_list_vm.dart';

class PendingOnATeamViewModel<DraftModel>
    extends BaseListViewModel<DraftModel> {
  @override
  Future<List<DraftModel>> loadListAsync(index) async {
    return await getBillInformation(
        pageIndex: index, status: ExpenseStatusEnum.PendingOnATeamValidation);
  }
}
