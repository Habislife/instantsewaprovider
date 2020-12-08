import 'package:flutter/material.dart';
import 'package:provider/model/Auth/phoneno_update_model.dart';
import 'package:provider/router/route_constants.dart';
import 'package:provider/widgets/show_snackbar.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class UserPhonePage extends StatefulWidget {
  @override
  _UserPhonePageState createState() => _UserPhonePageState();
}

class _UserPhonePageState extends State<UserPhonePage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _key,
      backgroundColor: Colors.white,
      body: Injector(
        inject: [Inject<PhoneUpdateModel>(()=>PhoneUpdateModel())],
        builder: (context){
          final _phoneNoUpdateModel = RM.get<PhoneUpdateModel>();
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
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Enter your Phone Number.",
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
                              StateBuilder<PhoneUpdateModel>(
                                builder: (context,_phoneNoUpdateModel){
                                  return  Container(
                                    padding: EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(color: Colors.grey[200]),
                                      ),
                                    ),
                                    child: TextFormField(
                                      onChanged: (String phoneNo){
                                        _phoneNoUpdateModel.setState((state) => state.setPhoneNo(phoneNo),
                                            catchError: true);
                                      },
                                      decoration: InputDecoration(
                                        errorText:
                                        _phoneNoUpdateModel
                                            .hasError
                                            ? _phoneNoUpdateModel
                                            .error.message
                                            : null,
                                        border: InputBorder.none,
                                        prefixIcon: Icon(Icons.phone),
                                        labelText: "Phone Number",
                                        labelStyle: TextStyle(color: Colors.grey),
                                      ),
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
                        observe: ()=>_phoneNoUpdateModel,
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
                                  if (!_phoneNoUpdateModel.state
                                      .validateData()) {
                                    showSnackBar(
                                        key: _key,
                                        color: Colors.red,
                                        message:
                                        "Data is invalid,please fill before submitting the form");
                                  } else {
                                    _phoneNoUpdateModel.setState(
                                            (fullNameState) async {
                                          await fullNameState.updatePhoneNo();
                                          Navigator.pushNamed(
                                              context, addressUpdateRoute);
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
                      ),
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
