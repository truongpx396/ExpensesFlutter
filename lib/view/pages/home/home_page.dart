import 'package:auth0/auth0.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:expenses_mobile/auth/auth.dart';
import 'package:expenses_mobile/constants/ui_constants.dart';
import 'package:expenses_mobile/model/app/app_state.dart';
import 'package:expenses_mobile/view/base/base_widget.dart';
import 'package:expenses_mobile/view/pages/drafts/drafts_page.dart';
import 'package:expenses_mobile/view/pages/expenses_policy_page.dart';
import 'package:expenses_mobile/view/pages/pending_on_ateam/pending_on_ateam_page.dart';
import 'package:expenses_mobile/view/pages/pending_on_manager/pending_on_manager_page.dart';
import 'package:expenses_mobile/view/pages/validated_by_manager/validated_by_manager_page.dart';
import 'package:expenses_mobile/view/shared/colors.dart';
import 'package:expenses_mobile/view/shared/decorations.dart';
import 'package:expenses_mobile/view/shared/ui_styles.dart';
import 'package:expenses_mobile/view_model/home_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title = 'Home Page'}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _buildSubHeaderLine(String title) {
    return SizedBox(
        height: 30,
        child: Container(
          padding: EdgeInsets.only(left: 13),
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ));
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  HomeViewModel _vm;

  @override
  void initState() {
    super.initState();
  }

  void initAuth0Client() {
    var auth0 = AuthClient(
        authClient: Provider.of<AppStateModel>(context, listen: false)
            .mocks
            .getMock('authClient'));
    auth0.authorize().then((res) {
      if (res.containsKey('access_token')) {
        Provider.of<AppStateModel>(context, listen: false).logIn(res);
      }
    });

    final clientId = 'DFdb6hTN3KyEpvSOK9Uar96fCQ5f2FQ6';
    final baseUrl = 'https://auth.mantu.com/';
    var client = Auth0Client(clientId, baseUrl,
        connectTimeout: 10000, sendTimeout: 10000, receiveTimeout: 60000);
    var params = Map<String, dynamic>();
    params['redirectUri'] = 'https://qc.mantu.com';
    params['responseType'] = 'Access Token';
    params['state'] = '';
    var result = client.authorizeUrl(params);
    print(result.toString());
  }

  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<AppStateModel>(context);
//    if (!appState.authenticated) {
//      return Scaffold(
//        body: HomePage(),
//      );
//    }

    return BaseWidget<HomeViewModel>(
      model: HomeViewModel(),
      onModelReady: (model) {
        //initAuth0Client();
        _vm = model;
        _vm.loadBannerCount();
      },
      builder: (context, model, child) => AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 1.0,
              iconTheme: IconThemeData(color: Colors.black54),
              actions: <Widget>[
                IconButton(
                    icon: const Icon(
                      Icons.info_outline,
                      color: Colors.orange,
                    ),
                    onPressed: () {
                      _vm.loadBannerCount();
                    }),
              ],
              title: Text(
                widget.title,
                style: kAppBarTextStyle,
              ),
            ),
            body: Container(
              color: Colors.grey[100],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        await _vm.loadBannerCount();
                      },
                      child: SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Container(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(top: 8.0, bottom: 8.0),
                            child: Column(
                              children: <Widget>[
//                          _buildSubHeaderLine('Pending'),
//                          _buildManageExpenses(),
                                SizedBox(
                                  height: 10,
                                ),
                                _buildNotifications(),
                                _buildSubHeaderLine('In Process'),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Row(
                                    children: <Widget>[
                                      _buildInProcessCardView(
                                          numberOfItems: _vm.draftsTotal,
                                          currency: _vm.draftsCurrency,
                                          totalAmount: _vm.draftsTotalAmount,
                                          title: 'Drafts',
                                          color: Colors.grey,
                                          icon: CommunityMaterialIcons
                                              .file_document_edit,
                                          onTapped: onDraftsCardViewTapped),
                                      _buildInProcessCardView(
                                          currency: _vm.pendingOnATeamCurrency,
                                          totalAmount:
                                              _vm.pendingATeamTotalAmount,
                                          numberOfItems:
                                              _vm.pendingOnATeamExpensesTotal,
                                          title: 'Pending on A-Team',
                                          color: Colors.orange,
                                          icon: CommunityMaterialIcons.clock,
                                          onTapped:
                                              onPendingOnATeamCardViewTapped),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Row(
                                    children: <Widget>[
                                      _buildInProcessCardView(
                                          currency:
                                              _vm.pendingOnManagerCurrency,
                                          totalAmount:
                                              _vm.pendingManagerTotalAmount,
                                          numberOfItems:
                                              _vm.pendingOnManagerExpensesTotal,
                                          title: 'Pending on Manager',
                                          color: Colors.orange,
                                          icon: CommunityMaterialIcons
                                              .briefcase_account,
                                          onTapped:
                                              onPendingOnManagerCardViewTapped),
                                      _buildInProcessCardView(
                                          currency:
                                              _vm.validatedByManagerCurrency,
                                          totalAmount:
                                              _vm.validatedByManagerTotalAmount,
                                          numberOfItems: _vm
                                              .validatedByManagerExpensesTotal,
                                          title: 'Validated by Manager',
                                          color: Colors.green,
                                          icon: CommunityMaterialIcons
                                              .briefcase_check,
                                          onTapped:
                                              onValidatedByManagerCardViewTapped),
                                    ],
                                  ),
                                ),
                                _buildSubHeaderLine('Treated'),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Row(
                                    children: <Widget>[
                                      _buildTreatedCardView(
                                          CommunityMaterialIcons.credit_card,
                                          'Pending on Payment'),
                                      _buildTreatedCardView(
                                          Icons.block, 'Refused'),
                                      _buildTreatedCardView(
                                          CommunityMaterialIcons.wallet_outline,
                                          'Paid and Closed'),
                                    ],
                                  ),
                                ),
                                _buildSubHeaderLine('Policy'),
                                _buildPolicyCardView(),
                                SizedBox(
                                  height: 30,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[200],
                          blurRadius: 10.0,
                          spreadRadius: 5.0,
                          offset: Offset(
                            5.0, // horizontal, move right 10
                            5.0, // vertical, move down 10
                          ),
                        )
                      ],
                    ),
                    height: 50,
                  )
                ],
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Padding(
                padding: EdgeInsets.only(bottom: 15),
                child: FloatingActionButton(
                  backgroundColor: Colors.orange,
                  onPressed: () {},
                  child: Icon(
                    Icons.camera_alt,
                    size: 30,
                  ),
                ))),
      ),
    );
  }

  onDraftsCardViewTapped() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => DraftsPage()));
  }

  onPendingOnATeamCardViewTapped() {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => PendingOnATeamPage()));
  }

  onPendingOnManagerCardViewTapped() {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => PendingOnManagerPage()));
  }

  onValidatedByManagerCardViewTapped() {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => ValidatedByManagerPage()));
  }

  _buildTreatedCardView(IconData icon, String title) {
    return Expanded(
      child: Container(
        decoration: getCardShadowDecoration(),
        margin: EdgeInsets.all(5),
        child: Container(
          padding: const EdgeInsets.all(5),
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              SizedBox(
                height: 5,
              ),
              Icon(
                icon,
                size: 38,
                color: Colors.grey[500],
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                height: 1,
                color: Colors.grey[200],
              ),
              SizedBox(
                height: 2,
              ),
              Expanded(
                child: Center(
                  child: AutoSizeText(
                    title,
                    minFontSize: 12,
                    maxFontSize: 12,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: boldTextStyle.merge(smallTextSizeStyle),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String textFromTotalAmount(double totalAmount) {
//    if (totalAmount % 1 == 0) {
//      int value = totalAmount.round();
//      FlutterMoneyFormatter fmf = FlutterMoneyFormatter(
//          amount: totalAmount
//      );
//      return '$value';
//    }
    print('DOUBLE VALUE: ' + totalAmount.toString());
    FlutterMoneyFormatter fmf = FlutterMoneyFormatter(amount: totalAmount);
    final text = fmf.output.compactNonSymbol;
    return text;
  }

  _buildInProcessCardView(
      {String title,
      String currency = '',
      double totalAmount = 0.0,
      Color color,
      IconData icon,
      Function onTapped,
      int numberOfItems}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTapped,
        child: Container(
          margin: EdgeInsets.all(5),
          decoration: getCardShadowDecoration(),
          child: Container(
            height: 85,
            padding: EdgeInsets.only(left: 5, bottom: 5, top: 5),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 55,
                  child: Row(
                    children: <Widget>[
                      Icon(
                        icon != null ? icon : Icons.assignment,
                        size: 30,
                        color: color.withOpacity(0.8),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                currency,
                                style: TextStyle(
                                    fontSize: 11,
                                    color: color,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                textFromTotalAmount(totalAmount),
                                style: TextStyle(
                                    fontSize: 22,
                                    color: color,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 15),
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey[200],
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 14,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        numberOfItems.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            title,
                            style: boldTextStyle.merge(smallTextSizeStyle),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildPolicyCardView() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => ExpensesPolicyPage()));
      },
      child: SizedBox(
        height: 70,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Container(
            margin: EdgeInsets.all(5),
            decoration: getCardShadowDecoration(),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.security,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 1,
                    height: 30,
                    color: Colors.grey[200],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Read the latest Expenses Policy',
                    style: boldTextStyle.merge(smallTextSizeStyle),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildManageExpenses() {
    final cardWidth = MediaQuery.of(context).size.width * 0.618;
    return Container(
        height: 100,
        child: ListView(
          // This next line does the trick.
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            SizedBox(
              width: 8,
            ),
            Container(
              width: cardWidth,
              child: Card(
                elevation: 3.0,
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Container(
              width: cardWidth,
              child: Card(
                elevation: 3.0,
              ),
            ),
            SizedBox(
              width: 8,
            ),
          ],
        ));
  }

  _buildNotifications() {
    return Container(
        height: 60,
        padding: EdgeInsets.only(top: 5, bottom: 5),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            SizedBox(
              width: 8,
            ),
            buildDaysToValidateExpensesView(),
            SizedBox(
              width: 15,
            ),
            buildDaysToPaymentPeriodView(),
            SizedBox(
              width: 15,
            ),
            buildDaysToSubmitRemainingExpensesView(),
            SizedBox(
              width: 8,
            ),
          ],
        ));
  }

  buildDaysToSubmitRemainingExpensesView() {
    final cardWidth = MediaQuery.of(context).size.width * 0.618;
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Colors.orange[600], Colors.orangeAccent])),
        width: cardWidth,
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '2',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Colors.white),
                ),
                Text(
                  'DAYS',
                  style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w300,
                      color: Colors.white),
                ),
              ],
            ),
            SizedBox(
              width: 15,
            ),
            Flexible(
              child: Text(
                'to submit your remaining expenses',
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w300,
                    color: Colors.white),
              ),
            ),
          ],
        ));
  }

  buildDaysToPaymentPeriodView() {
    final cardWidth = MediaQuery.of(context).size.width * 0.618;
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Colors.green, Colors.lightGreen])),
        width: cardWidth,
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '2',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Colors.white),
                ),
                Text(
                  'DAYS',
                  style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w300,
                      color: Colors.white),
                ),
              ],
            ),
            SizedBox(
              width: 15,
            ),
            Flexible(
              child: Text(
                'until the next payment period',
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w300,
                    color: Colors.white),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              '0',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
          ],
        ));
  }

  buildDaysToValidateExpensesView() {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Colors.red, Colors.orange])),
        width: 150,
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '1',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Colors.white),
                ),
                Text(
                  'DAY',
                  style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w300,
                      color: Colors.white),
                ),
              ],
            ),
            SizedBox(
              width: 15,
            ),
            Flexible(
              child: Text(
                'to validate your team expenses',
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w300,
                    color: Colors.white),
              ),
            ),
          ],
        ));
  }
}
