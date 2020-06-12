import 'package:expenses_mobile/constants/ui_constants.dart';
import 'package:expenses_mobile/view/shared/colors.dart';
import 'package:flutter/material.dart';

class EmptyBackgroundWidget extends StatelessWidget {
  final VoidCallback onTapped;

  EmptyBackgroundWidget({this.onTapped});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final imageSize = size.width * GOLDEN_RATIO;

    var widget = Container(
      padding: EdgeInsets.symmetric(horizontal: (size.width - imageSize) / 2),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Looks like there is nothing here!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: darkGreyColor,
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: imageSize,
            width: imageSize,
            child: Image.asset('images/empty_background.png'),
          ),
          Text(
            'Tap to refresh.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: lightGreyColor,
              fontWeight: FontWeight.w300,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );

    return GestureDetector(
      onTap: () {
        print('Tapped');
        onTapped();
      },
      child: widget,
    );
  }
}
