import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final List properties = const <dynamic>[];
  Failure([properties]);

  @override
  List<Object> get props => properties;
}

// General Failures

class ServerFailure extends Failure {}

class CacheFailure extends Failure {}
