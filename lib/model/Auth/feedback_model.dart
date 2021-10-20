import 'package:provider/state/service_profile_update_state.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class FeedbackModel {
  final ServiceProviderUpdateState _serviceUserUpdateState = Injector.get<ServiceProviderUpdateState>();
  String feedback;
  FeedbackModel({this.feedback});
  void setFeedback(String feedback) {
    this.feedback = feedback;
  }

  bool validateData()
  {
    return this.feedback!= null
    ;
  }

  void feedbackSend() async
  {
    await _serviceUserUpdateState.feedbackToSystem(feedback: this.feedback);
  }

}
