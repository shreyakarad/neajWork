import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/styles.dart';
import 'package:get/get.dart';

class AddressInputField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode nextNode;
  final TextInputType inputType;
  final bool require;
  final String Function(String) validator;
  const AddressInputField({
    @required this.title, @required this.controller, @required this.focusNode, @required this.nextNode,
    @required this.require, this.inputType, this.validator
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
            child: Text(title,
              style: DMSansBold.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).primaryColor),
            ),
          ),
          SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
          require ? SizedBox() : Text(
            ' (${'optional'.tr})',
            style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).disabledColor),
          ),
        ]),
        SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

        TextFormField(
          controller: controller,
          validator: validator,
          focusNode: focusNode,
          keyboardType: inputType == TextInputType.phone ? TextInputType.phone : TextInputType.text,
          onSaved: (text) => nextNode != null ? FocusScope.of(context).requestFocus(nextNode) : null,
          inputFormatters: inputType == TextInputType.phone ? <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp('[0-9+]'))] : null,
          textInputAction: nextNode != null ? TextInputAction.next : TextInputAction.done,
          decoration: InputDecoration(
            isDense: true,
            filled: true,
            fillColor: Theme.of(context).cardColor,
            enabledBorder : OutlineInputBorder(borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL), borderSide: BorderSide(width: 1, color: Theme.of(context).primaryColorLight.withOpacity(0.30))),
            focusedBorder : OutlineInputBorder(borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL), borderSide: BorderSide(width: 1, color: Theme.of(context).primaryColorLight.withOpacity(0.30))),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL), borderSide: BorderSide(width: 1, color: Theme.of(context).primaryColorLight)),
            hintStyle: robotoRegular.copyWith(color: Theme.of(context).hintColor),
          ),
        ),
        SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
      ]),
    );
  }
}


class FormTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode nextFocus;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final int maxLines;
  final bool isPassword;
  final Function onTap;
  final Function onChanged;
  final Function onSubmit;
  final bool isEnabled;
  final TextCapitalization capitalization;
  final Color fillColor;
  final bool autoFocus;
  final GlobalKey<FormFieldState<String>> key;
  final String Function(String) validator;

  FormTextField(
      {this.hintText = '',
        this.controller,
        this.focusNode,
        this.nextFocus,
        this.isEnabled = true,
        this.inputType = TextInputType.text,
        this.inputAction = TextInputAction.next,
        this.maxLines = 1,
        this.onSubmit,
        this.onChanged,
        this.capitalization = TextCapitalization.none,
        this.onTap,
        this.fillColor,
        this.isPassword = false,
        this.autoFocus = false,
        this.key,
        this.validator,
      });

  @override
  _FormTextFieldState createState() => _FormTextFieldState();
}

class _FormTextFieldState extends State<FormTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return
      TextFormField(
        validator:  widget.validator,
        key: widget.key,
        maxLines: widget.maxLines,
        controller: widget.controller,
        focusNode: widget.focusNode,
        style: robotoRegular,
        textInputAction: widget.inputAction,
        keyboardType: widget.inputType,
        cursorColor: Theme.of(context).primaryColor,
        textCapitalization: widget.capitalization,
        enabled: widget.isEnabled,
        autofocus: widget.autoFocus,
        //onChanged: widget.isSearch ? widget.languageProvider.searchLanguage : null,
        obscureText: widget.isPassword ? _obscureText : false,
        inputFormatters: widget.inputType == TextInputType.phone ? <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp('[0-9+]'))] : null,
        decoration: InputDecoration(
          hintText: widget.hintText,
          isDense: true,
          filled: true,
          fillColor: widget.fillColor != null ? widget.fillColor : Theme.of(context).cardColor,
          enabledBorder : OutlineInputBorder(borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE), borderSide: BorderSide(width: 1, color: Theme.of(context).primaryColorLight.withOpacity(0.30))),
          focusedBorder : OutlineInputBorder(borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE), borderSide: BorderSide(width: 1, color: Theme.of(context).primaryColorLight.withOpacity(0.30))),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE), borderSide: BorderSide(width: 1, color: Theme.of(context).primaryColorLight)),
          hintStyle: robotoRegular.copyWith(color: Theme.of(context).hintColor),
          suffixIcon: widget.isPassword ? IconButton (
            icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility, color: Theme.of(context).hintColor.withOpacity(0.3)),
            onPressed: _toggle,
          ) : null,
        ),
        onTap: widget.onTap,
        onSaved: (text) => widget.nextFocus != null ? FocusScope.of(context).requestFocus(widget.nextFocus) : widget.onSubmit != null ? widget.onSubmit(text) : null,
        onChanged: widget.onChanged,
    );
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}