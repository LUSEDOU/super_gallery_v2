part of 'app_cubit.dart';

enum AppStatus { authenticated, unauthenticated }

class AppState extends Equatable {
  const AppState({this.status = AppStatus.unauthenticated});

  final AppStatus status;

  @override
  List<Object> get props => [status];
}
