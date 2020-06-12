import 'package:expenses_mobile/constants/ui_constants.dart';
import 'package:expenses_mobile/view/shared/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingListLayoutWidget extends StatelessWidget {
  final _numberOfItems = 15;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    var scaleOffset = scaleFactor(context);
    final shortLineWidth = screenWidth -
        (screenWidth * GOLDEN_RATIO) -
        (COMMON_PADDING * 4) * scaleOffset;
    final mediumLineWidth =
        (screenWidth * GOLDEN_RATIO) - (COMMON_PADDING * 4) * scaleOffset;

    return Container(
      height: double.infinity,
      width: screenWidth,
      child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _numberOfItems,
          itemBuilder: (BuildContext context, int index) {
            return Container(
                height: 60,
                padding: EdgeInsets.fromLTRB(32, 0, 16, 0),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Shimmer.fromColors(
                  enabled: true,
                  baseColor: Colors.grey[200],
                  highlightColor: Colors.grey[50],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      space(12),
                      _buildLoadingDetailLine(),
                      space(12),
                      _buildLoadingDetailLine(widthRequest: mediumLineWidth),
                      space(12),
                      _buildLoadingDetailLine(heightRequest: 0.5),
                    ],
                  ),
                ));
          }),
    );
  }

  Widget _buildLoadingDetailLine(
      {double widthRequest = double.infinity,
      double heightRequest = 10,
      @required BuildContext context}) {
    return Container(
      width: widthRequest,
      height: heightRequest * scaleFactor(context),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(2 * scaleFactor(context)),
      ),
    );
  }
}
