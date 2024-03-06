import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    // log('[bloc] ${bloc.runtimeType} $event');
    debugPrint('[Bloc] ${bloc.runtimeType} --- [Event] $event');
  }

  @override
  onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    // log('[bloc] ${bloc.runtimeType} $transition');
    debugPrint('[Bloc] ${bloc.runtimeType} --- [Transition] $transition');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    // log('[bloc] ${bloc.runtimeType} $change');
    debugPrint('[Bloc] ${bloc.runtimeType} --- [Change] $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    // log('[bloc] onError $error');
    debugPrint('[Bloc] ${bloc.runtimeType} --- [Error] $error');
  }
}
