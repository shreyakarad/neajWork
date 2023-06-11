import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/styles.dart';
import 'package:get/get.dart';

class SearchField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final String suffixIcon;
  final Function iconPressed;
  final Function onSubmit;
  final Function onChanged;
  SearchField({@required this.controller, @required this.hint, @required this.suffixIcon, @required this.iconPressed, this.onSubmit, this.onChanged});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border.all(width: .2, color: Theme.of(context).primaryColor.withOpacity(.3)),
        borderRadius: BorderRadius.circular(100),
        boxShadow: [BoxShadow(color: Theme.of(context).hintColor.withOpacity(.1), spreadRadius: 1, blurRadius: 5)]),

      child: TextField(
        controller: widget.controller,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL, right: Dimensions.PADDING_SIZE_SMALL),
          hintText: widget.hint,
          hintStyle: robotoRegular.copyWith(color: Theme.of(context).primaryColor.withOpacity(.5)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(100), borderSide: BorderSide.none),
          filled: true, fillColor: Theme.of(context).primaryColor.withOpacity(.1),
          isDense: true,
          suffixIcon: Container(
            decoration: BoxDecoration(
              color: Get.isDarkMode ? Theme.of(context).cardColor : Theme.of(context).primaryColor,
              shape: BoxShape.circle,
            ),
            child: InkWell(
              onTap: widget.iconPressed,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical : Dimensions.PADDING_SIZE_SMALL),
                  child: SizedBox(height: 10, width: 10, child: Image.asset(widget.suffixIcon,scale: 2,color: Colors.white, height: 10, width: 10))))

          ),
        ),
        onSubmitted: widget.onSubmit,
        onChanged: widget.onChanged,
      ),
    );
  }
}
