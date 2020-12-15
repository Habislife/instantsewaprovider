import 'package:flutter/material.dart';
import '../model/service_model.dart';
import '../state/category_state.dart';
import '../ui/sub_categories_page.dart';
import '../util/hexcode.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

// ignore: must_be_immutable
class AllCategoryList extends StatefulWidget {
  List<Service> category;
  AllCategoryList({this.category});

  @override
  _AllCategoryListState createState() => _AllCategoryListState();
}

class _AllCategoryListState extends State<AllCategoryList>
    with AutomaticKeepAliveClientMixin {
  final _categoriesStateRM = RM.get<CategoryState>();

  bool value = false;

  @override
  void initState() {
    _categoriesStateRM
        .setState((categoryState) => categoryState.getAllCategories());
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
      ),
      body: StateBuilder<CategoryState>(
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
                            CheckboxListTile(
                              activeColor: _purple,
                              title: new Text(
                                'Hello',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.5),
                              ),
                              value: value,
                              onChanged: (value) {
                                setState(() {
                                  this.value = value;
                                });
                              },
                              checkColor: Colors.white,
                              controlAffinity: ListTileControlAffinity.trailing,
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
