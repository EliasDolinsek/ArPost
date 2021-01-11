import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'ar_actions_event.dart';
part 'ar_actions_state.dart';

class ArActionsBloc extends Bloc<ArActionsEvent, ArActionsState> {
  ArActionsBloc() : super(ArActionsInitial());

  @override
  Stream<ArActionsState> mapEventToState(
    ArActionsEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
