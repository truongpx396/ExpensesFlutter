import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: MyHomePage(title: 'Expenses'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _buildSubHeaderLine(String title) {
    return SizedBox(
        height: 30,
        child: Container(
          padding: EdgeInsets.only(left: 5),
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1.0,
          title: Text(
            widget.title,
            style:
                TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
          color: Colors.grey[100],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          _buildSubHeaderLine('Pending'),
                          _buildManageExpenses(),
                          _buildSubHeaderLine('In Process'),
                          Row(
                            children: <Widget>[
                              _buildInProcessCardView('Title', Colors.blueGrey,
                                  Icon(Icons.monetization_on)),
                              _buildInProcessCardView('Title', Colors.blueGrey,
                                  Icon(Icons.monetization_on)),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: <Widget>[
                              _buildInProcessCardView('Title', Colors.blueGrey,
                                  Icon(Icons.monetization_on)),
                              _buildInProcessCardView('Title', Colors.blueGrey,
                                  Icon(Icons.monetization_on)),
                            ],
                          ),
                          _buildSubHeaderLine('Treated'),
                          Row(
                            children: <Widget>[
                              _buildTreatedCardView(
                                  Icon(
                                    Icons.payment,
                                    size: 45,
                                    color: Colors.grey,
                                  ),
                                  'Pending on Payment'),
                              _buildTreatedCardView(
                                  Icon(
                                    Icons.block,
                                    size: 45,
                                    color: Colors.grey,
                                  ),
                                  'Refused'),
                              _buildTreatedCardView(
                                  Icon(
                                    Icons.monetization_on,
                                    size: 45,
                                    color: Colors.grey,
                                  ),
                                  'Paid and Closed'),
                            ],
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
              Container(
                width: double.infinity,
                height: 50,
                color: Colors.white,
              )
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
            padding: EdgeInsets.only(bottom: 15),
            child: FloatingActionButton(
              backgroundColor: Colors.orange,
              onPressed: () {},
              tooltip: 'Increment',
              child: Icon(
                Icons.camera_alt,
                size: 30,
              ),
            )));
  }

  _buildTreatedCardView(Icon icon, String title) {
    return Expanded(
      child: Card(
        elevation: 3.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Container(
          padding: const EdgeInsets.all(5),
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              SizedBox(
                height: 5,
              ),
              icon,
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
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildInProcessCardView(String title, Color color, Icon icon) {
    return Expanded(
      child: Card(
        elevation: 3.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Container(
          height: 80,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 55,
              ),
              Container(
                margin: const EdgeInsets.only(left: 15),
                width: double.infinity,
                height: 1,
                color: Colors.grey[200],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildPolicyCardView() {
    return SizedBox(
      height: 60,
      child: Card(
        elevation: 3.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
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
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
              )
            ],
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
            Container(
              width: cardWidth,
              child: Card(
                elevation: 3.0,
              ),
            ),
            Container(
              width: cardWidth,
              child: Card(
                elevation: 3.0,
              ),
            ),
          ],
        ));
  }
}
