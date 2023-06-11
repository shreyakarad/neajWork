import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';


class RoughView extends StatefulWidget {
  const RoughView({Key key}) : super(key: key);
  @override
  State<RoughView> createState() => _RoughViewState();
}

class _RoughViewState extends State<RoughView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(Dimensions.WEB_MAX_WIDTH)),
                ),
                child: Text('Hello'),
              ),
            )
          ],
        )
      ),
    );
  }
}