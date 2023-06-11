import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/styles.dart';

class BouncingButton extends StatefulWidget {
  final Function onPressed;
  final String buttonText;
  final bool transparent;
  final EdgeInsets margin;
  final double height;
  final double width;
  final double fontSize;
  final double radius;
  final IconData icon;
  BouncingButton({this.onPressed, @required this.buttonText, this.transparent = false, this.margin, this.width, this.height,
    this.fontSize, this.radius = 5, this.icon});

  @override
  _BouncingButtonState createState() => _BouncingButtonState();
}
class _BouncingButtonState extends State<BouncingButton> with SingleTickerProviderStateMixin {
  double _scale;
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 500), lowerBound: 0.0, upperBound: 0.1)..addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;

    final ButtonStyle _flatButtonStyle = TextButton.styleFrom(
      backgroundColor: widget.onPressed == null ? Theme.of(context).disabledColor : widget.transparent
          ? Colors.transparent : Theme.of(context).primaryColor,
      minimumSize: Size(widget.width != null ? widget.width : Dimensions.WEB_MAX_WIDTH, widget.height != null ? widget.height : 50),
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(widget.radius),
      ),
    );

    return Center(child: Material(
      color: Colors.transparent,
      child: Transform.scale(
        scale: _scale,
        child: SizedBox(width: widget.width != null ? widget.width : Dimensions.WEB_MAX_WIDTH, child: Padding(
          padding: widget.margin == null ? EdgeInsets.all(0) : widget.margin,
          child: TextButton(
            onPressed: () {
              _controller.forward();
              widget.onPressed();
              Future.delayed(Duration(milliseconds: 200), () {
                _controller.reverse();
              });
            },
            style: _flatButtonStyle,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              widget.icon != null ? Padding(
                padding: EdgeInsets.only(right: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                child: Icon(widget.icon, color: widget.transparent ? Theme.of(context).primaryColor : Theme.of(context).cardColor),
              ) : SizedBox(),
              Text(widget.buttonText ??'', textAlign: TextAlign.center, style: robotoBold.copyWith(
                color: widget.transparent ? Theme.of(context).primaryColor : Theme.of(context).cardColor,
                fontSize: widget.fontSize != null ? widget.fontSize : Dimensions.fontSizeLarge,
              )),
            ]),
          ),
        )),
      ),
    ));
  }
}