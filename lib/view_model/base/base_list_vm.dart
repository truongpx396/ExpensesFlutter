import 'package:expenses_mobile/view_model/base/base_vm.dart';

abstract class BaseListViewModel<T> extends BaseViewModel {
  int currentPageIndex = 1;
  bool isLoadingMore = false;
  List<T> listData = List<T>();

  Future<List<T>> loadListAsync(index);

  Future refreshList() async {
    if (busy || isLoadingMore) return;

    currentPageIndex = 1;
    final result = await loadListAsync(currentPageIndex);
    if (result != null && result is List<T>) {
      listData = result;
      currentPageIndex++;
      notifyListeners();
    }
  }

  Future loadList() async {
    if (busy || isLoadingMore) return;

    setBusy(true);
    currentPageIndex = 1;
    final result = await loadListAsync(currentPageIndex);
    if (result != null && result is List<T>) {
      currentPageIndex++;
      listData = result;
    }
    setBusy(false);
  }

  Future loadMore() async {
    if (busy || isLoadingMore) return;
    isLoadingMore = true;
    notifyListeners();
    final result = await loadListAsync(currentPageIndex);
    if (result != null && result is List<T> && result.length > 0) {
      currentPageIndex++;
      listData.addAll(result);
    }
    isLoadingMore = false;
    notifyListeners();
  }
}
