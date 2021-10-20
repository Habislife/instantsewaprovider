import 'package:provider/application/classes/tracker/ongoing_tracker.dart';
import 'package:provider/application/classes/tracker/operation.dart';
import 'package:provider/repositories/tracking_repository.dart';

class TrackingState
{
  final TrackingRepository _trackingRepository;
  TrackingState(this._trackingRepository): assert( _trackingRepository!= null);

  List<OperationTracker> _ongoing = [];
  List<OperationTracker> get ongoingProject => _ongoing;
  List<OperationTracker> _completed = [];
  List<OperationTracker> get completedProject => _completed;
  List<OperationTracker> _cancelled = [];
  List<OperationTracker> get cancelledProject => _cancelled;
  List<Operation> _operation = [];
  List<Operation> get operation => _operation;
  Future <bool> bookOrCancel({String operationId,int status})
  async{
    if(await _trackingRepository.bookOrCancelled(operationId: operationId, status: status))
      {
        return true ;
      }
    else{
      return false;
    }
  }
  Future <bool> operationStart({String operationId})
  async{
    if(await _trackingRepository.operationStart(operationId: operationId))
    {
      return true ;
    }
    else{
      return false;
    }
  }

  Future <bool> operationCompletion({String operationId})
  async{
    if(await _trackingRepository.operationCompletion(operationId: operationId))
    {
      return true ;
    }
    else{
      return false;
    }
  }

  Future <bool> paymentCompletion({String operationId,int status,String totalAmount})
  async{
    if(await _trackingRepository.paymentCompletion(operationId: operationId,status: status,totalAmount: totalAmount))
    {
      return true ;
    }
    else{
      return false;
    }
  }
  Future getOngoingProject() async
  {
    _ongoing= await _trackingRepository.getOngoingProject();
  }
  Future getCompletedProject() async
  {
    _completed= await _trackingRepository.getCompletedProject();
  }
  Future getCancelledProject() async
  {
    _cancelled= await _trackingRepository.getCancelledProject();
  }
  Future getOperation({String operationId}) async
  {
    _operation = await _trackingRepository.getOperation(operationId: operationId);
  }
}