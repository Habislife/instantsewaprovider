import 'package:flutter/material.dart';
import '../application/classes/category/category.dart';
import '../state/home_state.dart';
import '../state/home_state.dart';
import '../util/hexcode.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

// ignore: must_be_immutable
class AllCategoryList extends StatefulWidget {
  @override
  _AllCategoryListState createState() => _AllCategoryListState();
}

class _AllCategoryListState extends State<AllCategoryList>
    with AutomaticKeepAliveClientMixin {
  List<String> subCategoryList = [];
  final _categoriesStateRM = RM.get<HomeState>();
  bool _isSelected = false;

  @override
  void initState() {
    _categoriesStateRM.setState((categoryState) => categoryState.getCategory());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color _purple = HexColor('#603f8b');
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Services'),
        backgroundColor: _purple,
        actions: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 11.0, horizontal: 8.0),
            child: RaisedButton(
              color: Colors.white,
              shape: StadiumBorder(),
              onPressed: () {},
              child: Text(
                'Next',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
          )
        ],
      ),
      body: StateBuilder<HomeState>(
        observe: () => _categoriesStateRM,
        builder: (context, model) {
          return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ListView(
                children: <Widget>[
                  ...model.state.categories.map(
                    (category) => Column(
                      children: [
                        SizedBox(height: 10.0),
                        ExpansionTile(
                          leading: CircleAvatar(
                            radius: 29.0,
                            backgroundColor: Colors.white,
                            child: ClipRRect(
                              child: SizedBox(
                                width: 50.0,
                                height: 30.0,
                                child: Image.asset(
                                  "${category.categoryImage}",
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          title: Text(
                            "${category.categoryName}",
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                          children: <Widget>[
                            ...category.subCategory.map(
                              (subCategory) => Column(
                                children: [
                                  CheckboxListTile(
                                    activeColor: _purple,
                                    title: new Text(
                                      subCategory.subCategoryName,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 0.5),
                                    ),
                                    value: subCategory.isSelected,
                                    onChanged: (bool newValue) {
                                      setState(() {
                                        subCategory.isSelected = newValue;
                                        subCategory.isSelected
                                            ? subCategoryList
                                                .add(subCategory.id)
                                            : subCategoryList
                                                .remove(subCategory.id);
                                      });
                                    },
                                    checkColor: Colors.white,
                                    controlAffinity:
                                        ListTileControlAffinity.trailing,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ));
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
