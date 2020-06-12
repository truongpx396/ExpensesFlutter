import 'package:expenses_mobile/constants/ui_constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';

class ExpensesPolicyPage extends StatefulWidget {
  @override
  _ExpensesPolicyPageState createState() => _ExpensesPolicyPageState();
}

class _ExpensesPolicyPageState extends State<ExpensesPolicyPage> {
  bool _isLoading = true;
  PDFDocument doc;

  @override
  void initState() {
    super.initState();
    loadAssetDocument();
  }

  void loadAssetDocument() async {
    print('LOADING PDF');
    doc = await PDFDocument.fromAsset('assets/Expenses_Policy.pdf');
    print(doc.toString());
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 1.0,
        iconTheme: IconThemeData(color: Colors.black54),
        actions: <Widget>[
          IconButton(
              icon: const Icon(
                Icons.info_outline,
                color: Colors.orange,
              ),
              onPressed: () {}),
          FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Cancel',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.orange),
            ),
          )
        ],
        title: Text(
          'Expenses Policy',
          style: kAppBarTextStyle,
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : PDFViewer(
              document: doc,
              showPicker: false,
              indicatorBackground: Colors.black87.withOpacity(0.5),
            ),
    );
  }
}
