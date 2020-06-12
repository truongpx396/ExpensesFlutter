import 'package:community_material_icon/community_material_icon.dart';
import 'package:expenses_mobile/constants/ui_constants.dart';
import 'package:expenses_mobile/view/base/base_widget.dart';
import 'package:expenses_mobile/view/components/empty_background_widget.dart';
import 'package:expenses_mobile/view/components/loading_list_layout_widget.dart';
import 'package:expenses_mobile/view/pages/expense_detail_page.dart';
import 'package:expenses_mobile/view/shared/colors.dart';
import 'package:expenses_mobile/view_model/drafts/drafts_vm.dart';
import 'package:expenses_mobile/view_model/pending_on_ateam/pending_on_ateam_vm.dart';
import 'package:flutter/material.dart';

class PendingOnATeamPage extends StatefulWidget {
  @override
  _PendingOnATeamPageState createState() => _PendingOnATeamPageState();
}

class _PendingOnATeamPageState extends State<PendingOnATeamPage> {
  PendingOnATeamViewModel _vm;
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _vm?.loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<PendingOnATeamViewModel>(
      model: PendingOnATeamViewModel(),
      onModelReady: (model) {
        _vm = model;
        _vm.loadList();
      },
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1.0,
          iconTheme: IconThemeData(color: kTintColor),
          title: Text(
            'Pending on A-Team',
            style: kAppBarTextStyle,
          ),
          actions: <Widget>[
            _buildInfoButton(),
          ],
        ),
        body: _vm.busy ? _buildLoadingView() : _buildListView(),
      ),
    );
  }

  _buildInfoButton() {
    return IconButton(
      icon: Icon(
        Icons.info_outline,
        color: kTintColor,
      ),
    );
  }

  _buildAddButton() {
    return IconButton(
      icon: Icon(
        Icons.add,
        color: kTintColor,
      ),
    );
  }

  _buildListView() {
    if (_vm.listData.length == 0) {
      return EmptyBackgroundWidget(
        onTapped: () {
          _vm.loadList();
        },
      );
    }
    return Container(
      color: Colors.white,
      child: RefreshIndicator(
        onRefresh: () async {
          await _vm.refreshList();
        },
        child: ListView.builder(
            controller: _scrollController,
            itemCount: _vm.listData.length,
            itemBuilder: (BuildContext context, int index) {
              return _buildListItemView(index);
            }),
      ),
    );
  }

  _buildListItemView(int index) {
    final draft = _vm.listData[index];
    bool isLastOne = (index == _vm.listData.length - 1);
    bool showLoadingMoreWidget = isLastOne && _vm.isLoadingMore;

    return Material(
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => ExpenseDetailPage(
                        currentDraftItems: _vm.listData,
                        startPosition: index,
                      )));
        },
        child: Container(
          height: showLoadingMoreWidget ? 120 : 60,
          color: Colors.white,
          padding: EdgeInsets.only(left: 25, top: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                draft.listItemTitle,
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                children: <Widget>[
                  Text(
                    draft.valueText,
                    style: TextStyle(
                        fontWeight: FontWeight.w400, color: Colors.grey),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Text(
                    draft.companyText,
                    style: TextStyle(
                        fontWeight: FontWeight.w400, color: Colors.grey),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                ],
              ),
              Expanded(
                child: Container(),
              ),
              Container(
                height: 1,
                color: Colors.grey[200],
                width: double.infinity,
              ),
              showLoadingMoreWidget
                  ? Container(
                      padding: EdgeInsets.all(8),
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(),
                    )
                  : SizedBox()
            ],
          ),
        ),
      ),
    );
  }

  _buildLoadingView() {
    return LoadingListLayoutWidget();
  }
}
