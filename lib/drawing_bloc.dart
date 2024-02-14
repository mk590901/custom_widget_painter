import "events/draw_events.dart";
import "events/event.dart";
import "state_machines/basic_state_machine.dart";
import "state_machines/drawing_state_machine.dart";
import "states/drawing_state.dart";
import 'package:flutter_bloc/flutter_bloc.dart';

class DrawingBloc extends Bloc<Event, DrawingState> {
  BasicStateMachine? _stateMachine;

  DrawingBloc(DrawingState state) : super(state) {
    _stateMachine = DrawingStateMachine(state_(DrawingStates.drawing));

    on<Drawing>((event, emit) {
      done(event, emit);
    });
  }

  void done(Event event, Emitter<DrawingState> emit) {
    int newState = _stateMachine!.dispatch(event);
    if (newState >= 0) {
      DrawingState nextState = DrawingState(DrawingStates.values[newState]);
      nextState.setData(event.getData());
      emit(nextState);
    }
  }
}
