import '../util/hexcode.dart';
import 'package:flutter/material.dart';
import '../widgets/sub_catergory_list.dart';

class SubCategoriesPage extends StatelessWidget {
  final String categoryIndex;
  final String categoryName;

  const SubCategoriesPage({Key key, this.categoryIndex, this.categoryName})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    Color _purple = HexColor('#603f8b');
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName + ' Services'),
        backgroundColor: _purple,
      ),
      body: Container(
        child: ListView(children: [
          SubCategoriesList(categoryIndex),
        ]),
      ),
    );
  }
}
