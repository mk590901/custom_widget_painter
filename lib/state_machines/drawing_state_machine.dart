import '../states/drawing_state.dart';
import '../events/event.dart';
import '../events/draw_events.dart';
import '../interfaces/trans_methods.dart';
import 'basic_state_machine.dart';
import 'state.dart';
import 'trans.dart';

class DrawingStateMachine extends BasicStateMachine {

  DrawingStateMachine(super.currentState);

  @override
  void create() {
    states_ [state_(DrawingStates.drawing)]   = State([ Trans(Drawing(),  state_(DrawingStates.drawing),  OnNothing())]);
  }

  @override
  String? getEventName(int event) {
    // TODO: implement getEventName
    throw UnimplementedError();
  }

  @override
  String? getStateName(int state) {
    return "state [${DrawingStates.values[state].name}]";
  }

  @override
  void publishEvent(Event event) {
    print ("publishEvent->${event}");
  }

  @override
  void publishState(int state) {
    // TODO: implement publishState
  }

}
