import 'package:bloc/bloc.dart';

/// bloc observer that observes bloc events

class CubitDelegateFactory {
  static final CubitDelegateFactory _instance = CubitDelegateFactory._internal();

  factory CubitDelegateFactory() => _instance;

  CubitDelegateFactory._internal() : super();

  /// Verifies that [observer] is of an instance type that indicates that the setup has already been completed
  /// and returns true. Returns false otherwise.
  bool hasObserverSetup(BlocObserver observer) {
    return observer is CubitObserver;
  }

  /// Creates a new suitable [BlocDelegate] based on [region] and returns it.
  BlocObserver create() {
    return CubitObserver();
  }
}

class CubitObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('${bloc.runtimeType} $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('${bloc.runtimeType} $error $stackTrace');
    super.onError(bloc, error, stackTrace);
  }
}
