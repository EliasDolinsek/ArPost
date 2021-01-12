import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';

part 'ar_actions_event.dart';

part 'ar_actions_state.dart';

part 'ar_actions_bloc.freezed.dart';

class ArActionsBloc extends Bloc<ArActionsEvent, ArActionsState> {
  ArActionsBloc() : super(ArActionsState.initial());

  @override
  Stream<ArActionsState> mapEventToState(
    ArActionsEvent event,
  ) async* {
    yield* event.map(
      place: (e) async* {
        state.copyWith(isPlaced: true);
      },
      release: (e) async* {
        state.copyWith(isPlaced: false);
      },
      capture: (e) async* {
        state.copyWith(isPlaced: false);
      },
    );
  }
}
