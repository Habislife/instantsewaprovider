import 'package:flutter/material.dart';
import 'package:provider/model/Auth/fullname_update_model.dart';
import 'package:provider/router/route_constants.dart';
import 'package:provider/widgets/show_snackbar.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class UserInfoPage extends StatefulWidget {
  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  String dropdownValue = null;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _key,
      backgroundColor: Colors.white,
      body: Injector(
        inject: [Inject<FullNameUpdateModel>(()=>FullNameUpdateModel())],
        builder: (context)
        {
          final _fullNameUpdateModel = RM.get<FullNameUpdateModel>();
          return SafeArea(
            child: ListView(
              children: <Widget>[
                Container(
                  height: 100,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        bottom: 5,
                        left: 0,
                        child: Image.asset(
                          "images/main_top.png",
                          width: size.width * 0.50,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: Text(
                          "Give us your information for better user experience.",
                          style: TextStyle(
                              color: Color.fromRGBO(49, 39, 79, .6),
                              fontSize: 20.0),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Enter your Full Name.",
                        style: TextStyle(
                          color: Color.fromRGBO(49, 39, 79, .6),
                          fontSize: 18.0,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(196, 135, 198, .3),
                                blurRadius: 20,
                                offset: Offset(0, 10),
                              )
                            ]),
                        child: Form(
                          child: Column(
                            children:[
                              StateBuilder<FullNameUpdateModel>(
                                builder: ( context,_fullNameUpdateModel){
                                  return Container(
                                    padding: EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(color: Colors.grey[200]),
                                      ),
                                    ),
                                    child: TextFormField(
                                      onChanged: (String fullName){
                                        _fullNameUpdateModel.setState((state) => state.setFullName(fullName),
                                        catchError: true);
                                      },
                                      decoration: InputDecoration(
                                        errorText:
                                        _fullNameUpdateModel
                                            .hasError
                                            ? _fullNameUpdateModel
                                            .error.message
                                            : null,
                                        border: InputBorder.none,
                                        prefixIcon: Icon(Icons.person),
                                        labelText: "Full Name",
                                        labelStyle: TextStyle(color: Colors.grey),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              StateBuilder<FullNameUpdateModel>(
                                builder: ( context,_fullNameUpdateModel){
                                  return Container(
                                    padding: EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(color: Colors.grey[200]),
                                      ),
                                    ),
                                    child: DropdownButton<String>(
                                      value: dropdownValue,
                                      icon: Icon(Icons.arrow_downward),
                                      iconSize: 24,
                                      elevation: 16,
                                      style: TextStyle(color: Colors.deepPurple),
                                      underline: Container(
                                        height: 2,
                                        color: Colors.deepPurpleAccent,
                                      ),
                                      onChanged: (String newValue) {
                                        _fullNameUpdateModel.setState((state) => state.setGender(newValue));
                                        setState(() {
                                          dropdownValue = newValue;

                                        });
                                      },
                                      items: <String>['Male','Female']
                                          .map<DropdownMenuItem<String>>((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      StateBuilder(
                        observe: ()=> _fullNameUpdateModel,
                        builder: (_,model){
                          return Container(
                            height: 50,
                            margin: EdgeInsets.symmetric(horizontal: 80),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: Color.fromRGBO(49, 39, 79, 1),
                            ),
                            child: Center(
                              child: InkWell(
                                onTap: () {
                                  if (!_fullNameUpdateModel.state
                                      .validateData()) {
                                    showSnackBar(
                                        key: _key,
                                        color: Colors.red,
                                        message:
                                        "Data is invalid,please fill before submitting the form");
                                  } else {
                                    _fullNameUpdateModel.setState(
                                            (fullNameState) async {
                                          await fullNameState.updateFullName();
                                          Navigator.pushNamed(
                                              context, phoneUpdateRoute);
                                        },
                                        onError: (context, error) =>
                                            showSnackBar(
                                                key: _key,
                                                color: Colors.red,
                                                message: "{$error.message}"));
                                  }
                                },
                                child: Text(
                                  "Next",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}