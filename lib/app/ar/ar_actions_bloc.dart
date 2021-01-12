import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'ar_actions_event.dart';

part 'ar_actions_state.dart';

part 'ar_actions_bloc.freezed.dart';

@injectable
class ArActionsBloc extends Bloc<ArActionsEvent, ArActionsState> {
  ArActionsBloc() : super(ArActionsState.initial());

  @override
  Stream<ArActionsState> mapEventToState(
    ArActionsEvent event,
  ) async* {
    yield* event.map(
      place: (e) async* {
        yield state.copyWith(isPlaced: true, isCaptured: false);
      },
      release: (e) async* {
        yield state.copyWith(isPlaced: false, isCaptured: false);
      },
      capture: (e) async* {
        yield state.copyWith(isPlaced: false, isCaptured: true);
      },
      submitImageFile: (_SubmitImage value) async* {
        yield state.copyWith(image: some(value.file), isCaptured: true);
      },
    );
  }
}
