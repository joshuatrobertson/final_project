import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_haircuts/providers/products.dart';
import 'package:uber_haircuts/widgets/return_text.dart';

import '../common_items.dart';

class CategoryFilterEntry {
  const CategoryFilterEntry(this.name);
  final String name;
}

class CategoriesFilter extends StatefulWidget {
  const CategoriesFilter({Key key}) : super(key: key);

  @override
  State createState() => _CategoriesFilterState();
}

class _CategoriesFilterState extends State<CategoriesFilter> {
  final List<CategoryFilterEntry> _items = <CategoryFilterEntry>[
    const CategoryFilterEntry('Haircut'),
    const CategoryFilterEntry('Beard Trim'),
    const CategoryFilterEntry('Student Cut'),
    const CategoryFilterEntry('Wash & Cut'),
    const CategoryFilterEntry('Other'),

  ];
  final List<String> _filters = <String>[];

  Iterable<Widget> get categoryWidget sync* {
    final productsProvider = Provider.of<ProductsProvider>(context);

    for (final CategoryFilterEntry category in _items) {
      yield Padding(
        padding: const EdgeInsets.all(3.5),
        child: FilterChip(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: theme, width: 1),
            borderRadius: BorderRadius.circular(100),
          ),
          checkmarkColor: Colors.lightBlue,
          backgroundColor: lightGrey,
          selectedColor: accent_2,
          label: ReturnText(text: category.name),
          selected: _filters.contains(category.name),
          onSelected: (bool value) {
            setState(() {
              if (value) {
                _filters.add(category.name);
              } else {
                _filters.removeWhere((String name) {
                  return name == category.name;
                });
              }
            });
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: ListView(
        scrollDirection: Axis.horizontal,
            children: categoryWidget.toList()
      ),
    );
  }

}