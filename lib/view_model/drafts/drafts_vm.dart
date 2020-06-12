import 'package:expenses_mobile/model/bill_informations/draft_model.dart';
import 'package:expenses_mobile/network/expenses_api_client/expenses_api_client.dart';
import 'package:expenses_mobile/view_model/base/base_vm.dart';

class DraftsViewModel extends BaseViewModel {
  int currentPageIndex = 1;
  bool isLoadingMore = false;

  List<DraftModel> listData = List<DraftModel>();

  DraftsViewModel() {
    //initMockData();
  }

  Future refreshList() async {
    if (busy || isLoadingMore) return;

    currentPageIndex = 1;
    final result = await getBillInformation(pageIndex: currentPageIndex);
    if (result != null && result is List<DraftModel>) {
      listData = result;
      currentPageIndex++;
      notifyListeners();
    }
  }

  Future loadList() async {
    if (busy || isLoadingMore) return;

    setBusy(true);
    currentPageIndex = 1;
    final result = await getBillInformation(pageIndex: currentPageIndex);
    if (result != null && result is List<DraftModel>) {
      currentPageIndex++;
      listData = result;
    }
    setBusy(false);
  }

  Future loadMore() async {
    if (busy || isLoadingMore) return;
    isLoadingMore = true;
    notifyListeners();
    final result = await getBillInformation(pageIndex: currentPageIndex);
    if (result != null && result is List<DraftModel> && result.length > 0) {
      currentPageIndex++;
      listData.addAll(result);
    }
    isLoadingMore = false;
    notifyListeners();
  }

  void initMockData() {
    listData = [
      DraftModel(),
      DraftModel(),
      DraftModel(),
      DraftModel(),
      DraftModel(),
      DraftModel(),
      DraftModel(),
    ];
  }
}
