import 'package:flutter/material.dart';
import 'package:provider/model/Auth/feedback_model.dart';
import 'package:provider/router/route_constants.dart';
import 'package:provider/util/hexcode.dart';
import 'package:provider/widgets/show_snackbar.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    Color _purple = HexColor('#603f8b');
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text('Feedback'),
        backgroundColor: _purple,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, homeRoute);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body:Injector(
          inject: [Inject<FeedbackModel>(()=>FeedbackModel())],
          builder: (context){
            final _feedbackModel = RM.get<FeedbackModel>();
            return   Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                StateBuilder<FeedbackModel>(
                    builder: (context,_feedbackModel){
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            minLines: 4,
                            maxLines: 10,
                            keyboardType: TextInputType.multiline,
                            onChanged: (String feedback){
                              _feedbackModel.setState((state) => state.setFeedback(feedback),
                                  catchError: true);
                            },
                            decoration: InputDecoration(
                              errorText:
                              _feedbackModel
                                  .hasError
                                  ? _feedbackModel
                                  .error.message
                                  : null,
                              prefixIcon: Icon(Icons.note_add),
                              hintText: 'Write your feedback',
                              hintStyle: TextStyle(color: Colors.grey),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                ),

                SizedBox(
                  height: 30,
                ),
                StateBuilder(
                    observe: ()=>_feedbackModel,
                    builder: (_,model){
                      return Center(
                        child: RaisedButton(
                          onPressed: (){
                            if (!_feedbackModel.state
                                .validateData()) {
                              showSnackBar(
                                  key: _key,
                                  color: Colors.red,
                                  message:
                                  "Data is invalid,please fill before submitting the form");
                            } else {
                              _feedbackModel.setState(
                                    (feedbackState) async {
                                  await feedbackState.feedbackSend();
                                },);
                            }
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          color: _purple,
                          padding: EdgeInsets.fromLTRB(35, 12, 35, 12),
                          child: Text(
                            'Submit',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17.0,
                            ),
                          ),
                        ),
                      );}),

              ],
            );
          }
      ),
    );
  }
}
