import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final double fieldHeight;
  final String hintText;
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode nextFocus;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final bool isPassword;
  final Function onChanged;
  final Function onSubmit;
  final bool isEnabled;
  final int maxLines;
  final TextCapitalization capitalization;
  final String prefixIcon;
  final Widget sufixIcon;
  final double prefixSize;
  final bool divider;
  final TextAlign textAlign;
  final Widget prefixWidget;
  final double verticalContentPadding;

  final bool isAmount;
  final FilteringTextInputFormatter formatter;

  CustomTextField({
    this.fieldHeight,
    this.hintText = 'Write something...',
    this.controller,
    this.focusNode,
    this.nextFocus,
    this.isEnabled = true,
    this.inputType = TextInputType.text,
    this.inputAction = TextInputAction.next,
    this.maxLines = 1,
    this.prefixWidget,
    this.onSubmit,
    this.onChanged,
    this.prefixIcon,
    this.sufixIcon,
    this.formatter,
    this.capitalization = TextCapitalization.none,
    this.isPassword = false,
    this.prefixSize = Dimensions.PADDING_SIZE_SMALL,
    this.divider = false,
    this.textAlign = TextAlign.start,
    this.isAmount = false,
    this.verticalContentPadding,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: widget.fieldHeight ?? 50,
          child: TextField(
            maxLines: widget.maxLines,
            controller: widget.controller,
            focusNode: widget.focusNode,
            textAlign: widget.textAlign,
            style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeLarge),
            textInputAction: widget.inputAction,
            keyboardType:
                widget.isAmount ? TextInputType.number : widget.inputType,
            cursorColor: Theme.of(context).primaryColor,
            textCapitalization: widget.capitalization,
            enabled: widget.isEnabled,
            autofocus: false,
            obscureText: widget.isPassword ? _obscureText : false,
            inputFormatters: widget.inputType == TextInputType.phone
                ? <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                  ]
                : widget.isAmount
                    ? [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))]
                    : widget.formatter != null
                        ? [widget.formatter]
                        : null,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                  borderSide: BorderSide(
                      width: 1,
                      color: Theme.of(context)
                          .primaryColorLight
                          .withOpacity(0.50))),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                  borderSide: BorderSide(
                      width: 1,
                      color: Theme.of(context)
                          .primaryColorLight
                          .withOpacity(0.50))),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                  borderSide: BorderSide(
                      width: 1, color: Theme.of(context).primaryColorLight)),
              contentPadding: EdgeInsets.symmetric(
                  vertical: widget.verticalContentPadding ?? 15,
                  horizontal: 10),
              isDense: true,
              hintText: widget.hintText,
              fillColor: Theme.of(context).cardColor,
              hintStyle: robotoRegular.copyWith(
                  fontSize: Dimensions.fontSizeLarge,
                  color: Theme.of(context).hintColor),
              filled: true,
              prefixIcon: widget.prefixIcon != null
                  ? Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: widget.prefixSize),
                      child:
                          Image.asset(widget.prefixIcon, height: 4, width: 4),
                    )
                  : null,
              prefix: widget.prefixWidget,
              suffixIcon: widget.isPassword
                  ? IconButton(
                      icon: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Theme.of(context).hintColor.withOpacity(0.3)),
                      onPressed: _toggle,
                    )
                  : widget.sufixIcon,
            ),
            onSubmitted: (text) => widget.nextFocus != null
                ? FocusScope.of(context).requestFocus(widget.nextFocus)
                : widget.onSubmit != null
                    ? widget.onSubmit(text)
                    : null,
            onChanged: widget.onChanged,
          ),
        ),
        widget.divider
            ? Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_LARGE),
                child: Divider())
            : SizedBox(),
      ],
    );
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}
