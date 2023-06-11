import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/view/screens/product/model/product_model.dart';

class ProductSpecification extends StatelessWidget {
  final ProductModel product;
  const ProductSpecification({Key key, @required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<TableRow> _tableRows = [];
    for(int index=0; index<product.attributes.length; index++) {
      String _options = '';
      for(String option in product.attributes[index].options) {
        _options += '${_options.isNotEmpty ? ', ' : ''}$option';
      }
      _tableRows.add(TableRow(children: [
        Padding(
          padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          child: Text(product.attributes[index].name),
        ),
        Padding(
          padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          child: Text(_options),
        ),
      ]));
    }

    return Table(
      defaultColumnWidth: FlexColumnWidth(1),
      columnWidths: {0: FlexColumnWidth(1), 1: FlexColumnWidth(2)},
      border: TableBorder.symmetric(
        inside: BorderSide(color: Theme.of(context).disabledColor, width: 1),
        outside: BorderSide(color: Theme.of(context).textTheme.bodyLarge.color, width: .5),
      ),
      children: _tableRows,
    );
  }
}
