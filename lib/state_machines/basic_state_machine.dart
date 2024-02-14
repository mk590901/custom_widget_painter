import '../events/event.dart';
import '../interfaces/i_extended_action.dart';
import 'state.dart';
import 'transaction.dart';

abstract class BasicStateMachine {
  late  int _currentState;
  final Map<int, State> states_ = <int, State>{};
  final Map<Type, IExtendedAction> extendedActions_ = <Type, IExtendedAction>{};

//  Constructor
    BasicStateMachine(this._currentState) {
    create();
  }

  void setAction (Event event, IExtendedAction action) {
    extendedActions_[event.runtimeType] = action;
  }

  IExtendedAction? getAction(Event event) {
    IExtendedAction? result;
    if (extendedActions_.containsKey(event.runtimeType)) {
      result = extendedActions_[event.runtimeType];
    }
    return result;
  }

  int dispatch(Event event) {

    State? stateEntity = states_ [_currentState];
    if (stateEntity == null || stateEntity.size() == 0) {
      print ("Failed to get State [${getStateName(_currentState)}]");
      return -1;
    }

    Transaction? transaction = stateEntity.transaction(event);
    if (transaction == null) {
      //print ("Failed to get transaction for [${getStateName(_currentState)}], event->${event}");
      event.action()?.done("Trans ${getStateName(_currentState)}->${event.runtimeType}->?");
      return -1;
    }

    if (event.getAction() != null) {
      //print ("dispatch.EVENT->${event.runtimeType} action Ok");
    }
    else {
      //print ("dispatch.EVENT->${event.runtimeType} action is NULL");
      IExtendedAction? action = getAction(event);
      if (action != null) {
        event.addAction(action);
      }
    }

    event.getAction()?.run();

    String? prevState = getStateName(_currentState);

    _currentState = transaction.state();

    String? currState = getStateName(_currentState);

    //print ("trans [$prevState]->[$currState]");

    transaction.method()?.execute(event.getData());

    //publishState (_currentState);

    if (event.getData() != null /*&& event.getData()!.isNotEmpty*/) {
      if (event.isActivateGui()) {
        event.action()?.done("${event.getData()}");
      }
      // if ((event is Success) || (event is Error)) {
      //   print('MESSAGE -> ${event.getData()}');
      // }
    }
    return _currentState;
  }

  void    create();                   //  abstract function
  void    publishState(int state);    //  abstract function
  void    publishEvent(Event event);  //  abstract function
  String? getStateName(int state);    //  abstract function
  String? getEventName(int event);    //  abstract function

  int state() {
    return _currentState;
  }

}