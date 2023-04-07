import 'package:di_cho_nhanh/models/agruments/product_type.dart';
import 'package:flutter/material.dart';

class SelectProductType extends StatefulWidget {
  const SelectProductType({super.key, required this.callback});
  final Function(ProductType) callback;
  @override
  State<SelectProductType> createState() => _SelectProductTypeState();
}

class _SelectProductTypeState extends State<SelectProductType> {
  ProductType selected = ProductType.undefine;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DropdownButtonFormField<ProductType>(
          hint: const Text('Chọn loại sản phẩm'),
          isExpanded: true,
          value: selected,
          decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 32),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(30.0),
                ),
              )),
          items: ProductType.values.map((ProductType type) {
            return DropdownMenuItem<ProductType>(
              value: type,
              child: Text(categoriName(type)),
            );
          }).toList(),
          onChanged: ((value) {
            widget.callback(value!);
            setState(() {
              selected = value;
            });
          })),
    );
  }
}
