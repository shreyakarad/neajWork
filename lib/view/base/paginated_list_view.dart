import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_woocommerce/helper/responsive_helper.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/styles.dart';

class PaginatedListView extends StatefulWidget {
  final ScrollController scrollController;
  final Function(int offset) onPaginate;
  final List<dynamic> dataList;
  final int perPage;
  final Widget itemView;
  const PaginatedListView({
    @required this.scrollController, @required this.onPaginate, @required this.dataList, this.perPage = 10,
    @required this.itemView,
  });

  @override
  State<PaginatedListView> createState() => _PaginatedListViewState();
}

class _PaginatedListViewState extends State<PaginatedListView> {
  int _offset;
  List<int> _offsetList;
  bool _isLoading = false;
  List<dynamic> _previousList = [];

  @override
  void initState() {
    super.initState();

    _offset = 1;
    _offsetList = [1];

    widget.scrollController?.addListener(() {
      if (widget.scrollController.position.pixels == widget.scrollController.position.maxScrollExtent && widget.dataList != null && !_isLoading) {
        print('Call_Pagination');
        if(mounted && !ResponsiveHelper.isDesktop(context)) {
          _paginate();
        }
      }
    });
  }

  void _paginate() async {
    print('call on paginate');
    if (!_stopPaginate() && !_offsetList.contains(_offset+1)) {
      _previousList = [];
      _previousList.addAll(widget.dataList);
      setState(() {
        _offset += 1;
        _offsetList.add(_offset);
        _isLoading = true;
      });
      await widget.onPaginate(_offset);
      setState(() {
        _isLoading = false;
      });

    }else {
      if(_isLoading) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // || _previousList.length == widget.dataList.length
  // || widget.dataList.length % widget.perPage != 0

  bool _stopPaginate() {
    print(widget.dataList);
    print(widget.dataList == null);
    print( _previousList.length == widget.dataList.length);
    return (widget.dataList == null || _previousList.length == widget.dataList.length);
  }

  @override
  Widget build(BuildContext context) {
    if(widget.dataList != null) {
      _offsetList = [];
      for(int index=1; index<=_offset; index++) {
        _offsetList.add(index);
      }
    }

    return Column(children: [
      Column(children: [

        widget.itemView,

        (ResponsiveHelper.isDesktop(context) && (widget.dataList == null || _stopPaginate() || _offsetList.contains(_offset+1))) ? SizedBox() : Center(child: Padding(
          padding: ResponsiveHelper.isDesktop(context) ? EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL) : EdgeInsets.zero,
          child: (ResponsiveHelper.isDesktop(context) && widget.dataList != null) ? InkWell(
            onTap: _paginate,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL, horizontal: Dimensions.PADDING_SIZE_LARGE),
              margin: ResponsiveHelper.isDesktop(context) ? EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL) : null,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                color: Theme.of(context).primaryColor,
              ),
              child: Text('view_more'.tr, style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge, color: Colors.white)),
            ),
          ) : SizedBox(),
        )),

      ]),

      (ResponsiveHelper.isDesktop(context) && (widget.dataList == null || _stopPaginate() || _offsetList.contains(_offset+1))) ? SizedBox() : Container(
        color: Colors.transparent, width: context.width, alignment: Alignment.center,
        padding: _isLoading ? EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL) : EdgeInsets.zero,
        child: _isLoading ? CircularProgressIndicator() : SizedBox(),
      ),

    ]);
  }
}
