import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider/application/classes/errors/common_error.dart';
import 'package:provider/application/storage/localstorage.dart';
import 'package:provider/application/storage/storage_keys.dart';
import 'package:provider/model/Auth/user_profile_update_model.dart';
import 'package:provider/ui/Auth/login_page.dart';
import 'package:provider/util/hexcode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import '../base_url.dart';
import '../router/route_constants.dart';
import '../widgets/show_snackbar.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  bool isHiddenPassword = true;
  bool isHiddenPassword2 = true;
  File _imageFile;
  final ImagePicker _picker = ImagePicker();
  Dio dio = new Dio();
  String email;
  String userName;
  String fullName;
  String phoneNumber;
  String address;
  bool _isLoading = false;

  @override
  void initState() {
    _loadUserData();
    super.initState();
  }

  _loadUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = await jsonDecode(localStorage.getString('user'));

    if (user != null) {
      setState(() {
        userName = user['username'];
        fullName = LocalStorage.getItem(FUllNAME);
        address = LocalStorage.getItem(ADDRESS_ADDRESS);
        email = user['email'];
        phoneNumber = LocalStorage.getItem(PHONE);
        _isLoading = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List subtitle = [
      "Email",
      "Address",
      "Phone Number",
    ];
    final List title = [
      email,
      address,
      phoneNumber,
    ];
    Color _purple = HexColor('#603f8b');
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: _purple,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, homeRoute);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            tooltip: 'Go to the next page',
            onPressed: () async {
              Navigator.push(context, MaterialPageRoute<void>(
                builder: ((builder) => editProfile(updatedFullName: fullName
                    ,updatedEmail: email,
                    updatedPhoneNumber: phoneNumber,
                    updatedUserName: userName)),
              ));
            },
          ),
        ],
      ),
      body:
      (!_isLoading) ? new Center(
        child: new SizedBox(
          height: 50.0,
          width: 50.0,
          child: new CircularProgressIndicator(
            value: null,
            strokeWidth: 7.0,
          ),
        ),
      )
          :
      SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 250,
              child: Stack(
                children: <Widget>[
                  Container(
                    height: 130,
                    width: 2000,
                    color: Colors.grey[300],
                    child:
                    Image(
                      image: AssetImage("images/instant_sewa.png"),
                    ),
                  ),
                  Align(
                    alignment: Alignment(0, 1),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        imageProfile(),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          fullName,
                          style: TextStyle(
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          userName,
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black38,
                          ),
                        ),
                      ],
                    ),
                  ),
                  //TopBar(),
                ],
              ),
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14.0,
                        vertical: 12.0,
                      ),
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 14.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                title[index],
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4.0),
                              Text(
                                subtitle[index],
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
              shrinkWrap: true,
              itemCount: 3,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: SizedBox(
                  height: 45.0,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.4,
                  child: RaisedButton(
                    color: _purple,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0)),
                    onPressed: () {
                      logout();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14.0, vertical: 12.0),
                      child: Text(
                        'LogOut',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 17.0),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget editProfile({
    String updatedEmail,
    String updatedUserName,
    String updatedFullName,
    String updatedPhoneNumber
  }) {

    Color _purple = HexColor('#603f8b');
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: _purple,
      ),
      resizeToAvoidBottomPadding: false,
      body: Injector(
        inject:[Inject<UserProfileUpdateModel>(()=>UserProfileUpdateModel(
            username: updatedUserName,
            fullname: updatedFullName,
            email: updatedEmail,
            phoneNo: updatedPhoneNumber))],
        builder:(context){
          final _singletonRegisterFormModel = RM.get<UserProfileUpdateModel>();
          return Form(
            child: Column(
              children: <Widget> [
                Container(
                  padding: EdgeInsets.all(25.0),
                  child: Column(
                    children: <Widget>[
                      StateBuilder<UserProfileUpdateModel>(
                        builder: (_,_singletonRegisterFormModel){
                          return TextFormField(
                            initialValue: fullName,
                            onChanged: (String fullName){
                              _singletonRegisterFormModel.setState((s) => s.setFullName(fullName),catchError: true);
                            },
                            decoration: InputDecoration(
                              errorText: _singletonRegisterFormModel
                                  .hasError
                                  ? _singletonRegisterFormModel
                                  .error.message
                                  : null,
                              labelText: 'Fullname',
                              labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.purple),
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 10.0,),
                      StateBuilder<UserProfileUpdateModel>(
                        builder: (_,_singletonRegisterFormModel){
                          return TextFormField(
                            initialValue: userName,
                            onChanged: (String username){
                              _singletonRegisterFormModel.setState((s) => s.setUsername(username),catchError: true);
                            },
                            decoration: InputDecoration(
                              errorText: _singletonRegisterFormModel
                                  .hasError
                                  ? _singletonRegisterFormModel
                                  .error.message
                                  : null,
                              labelText: 'Username',
                              labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.purple),
                              ),
                            ),
                          );
                        },
                      ),

                      SizedBox(height: 10.0,),
                      StateBuilder<UserProfileUpdateModel>(
                        builder: (_,_singletonRegisterFormModel){
                          return TextFormField(
                            initialValue: email,
                            onChanged: (String email){
                              _singletonRegisterFormModel.setState((s) => s.setEmail(email),catchError: true);
                            },
                            decoration: InputDecoration(
                              errorText: _singletonRegisterFormModel
                                  .hasError
                                  ? _singletonRegisterFormModel
                                  .error.message
                                  : null,
                              labelText: 'Email',
                              labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.purple),
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 10.0,),
                      StateBuilder<UserProfileUpdateModel>(
                        builder: (_,_singletonRegisterFormModel){
                          return TextFormField(
                            initialValue: phoneNumber,
                            onChanged: (String phoneno){
                              _singletonRegisterFormModel.setState((s) => s.setPhoneNo(phoneno),catchError: true);
                            },
                            decoration: InputDecoration(
                              errorText: _singletonRegisterFormModel
                                  .hasError
                                  ? _singletonRegisterFormModel
                                  .error.message
                                  : null,
                              labelText: 'Phone Number',
                              labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.purple),
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 40.0,),
                      StateBuilder(
                          observe: () => _singletonRegisterFormModel,
                          builder: (_, model) {
                            return Container(
                              height: 60,
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: SizedBox(
                                  height: 45.0,
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.4,
                                  child: RaisedButton(
                                    color: _purple,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25.0)),
                                    onPressed: () {
                                      if (!_singletonRegisterFormModel.state
                                          .validateData()) {
                                        showSnackBar(
                                            key: _key,
                                            color: Colors.red,
                                            message:
                                            "Data is invalid,please fill before submitting the form");
                                      } else {
                                        _singletonRegisterFormModel.setState(
                                                (signInFormState) async {
                                              signInFormState.submitUpdateProfile();
                                              Navigator.pushNamed(
                                                  context, homeRoute);
                                            },
                                            onError: (context, error) =>
                                                showSnackBar(
                                                    key: _key,
                                                    color: Colors.red,
                                                    message:
                                                    "{$error.message}"));
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 14.0, vertical: 12.0),
                                      child: Text(
                                        'Done',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 17.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget imageProfile() {
    return Center(
      child: Stack(
        children: <Widget>[
          CircleAvatar(
            //"https://robohash.org/1?set=set2"
            backgroundImage: _imageFile == null
                ? AssetImage("images/instant_sewa.png")
                : FileImage(File(_imageFile.path)),
            radius: 70.0,
          ),
          Positioned(
            bottom: 20.0,
            right: 20.0,
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: ((builder) => bottomSheet()),
                );
              },
              child: Icon(
                Icons.camera_alt,
                color: Colors.deepPurple,
                size: 28.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: 100.0,
      //width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile Picture",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton.icon(
                icon: Icon(Icons.camera),
                onPressed: () {
                  takePhoto(ImageSource.camera);
                },
                label: Text("Camera"),
              ),
              FlatButton.icon(
                icon: Icon(Icons.image),
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                },
                label: Text("Gallery"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> takePhoto(ImageSource source) async {
    var pickedFile = await ImagePicker.pickImage(
      source: source,
    );
    setState((){
      _imageFile = pickedFile;
    });
    File imageFile = File(_imageFile.path);
    _uploadFile(imageFile);
  }

  _uploadFile(File file) async {
    String name = file.path.split('/').last;
    var data = FormData.fromMap({
      "image": await MultipartFile.fromFile(
        file.path,
        filename: name,
      ),
    });
    String url = BASE_URL+"/profileimageupdate";
    Dio dio = new Dio();
    await dio
        .post(url, data: data,options: Options(headers: {
      'Authorization': "Bearer ${LocalStorage.getItem(TOKEN)}"
    }))
        .then((response) => print(response))
        .catchError((error) => print(error));
  }
  void logout() async
  {
    try {
      var token = LocalStorage.getItem(TOKEN);
      final response = await http.get(BASE_URL + "/auth/logout", headers:
      {'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'});
      if (response.statusCode == 200) {
        LocalStorage.deleteItem(TOKEN);
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        await localStorage.remove('user');
        LocalStorage.deleteItem(PHONE);
        LocalStorage.deleteItem(FUllNAME);
        LocalStorage.deleteItem(ADDRESS_ADDRESS);
        LocalStorage.deleteItem(VERIFICATION);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => LoginPage()));
      }
    }
    on DioError catch (e) {
      showNetworkError(e);
    }
  }
}
