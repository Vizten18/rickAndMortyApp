part of 'splash_bloc.dart';

enum SplashStatus { 
  initial, 
  loading, 
  success, 
  failure;

  bool get isInitial => this == SplashStatus.initial;
  bool get isLoading => this == SplashStatus.loading;
  bool get isSuccess => this == SplashStatus.success;
  bool get isFailure => this == SplashStatus.failure;
 }

/// {@template splash_state}
/// SplashState description
/// {@endtemplate}
class SplashState extends Equatable {
  /// {@macro splash_state}
  const SplashState({
    this.status = SplashStatus.initial,
  });

  /// Status of the state
  final SplashStatus status;

  @override
  List<Object> get props => [status];

  /// Creates a copy of the current SplashState with property changes
  SplashState copyWith({
    SplashStatus? status,
  }) {
    return SplashState(
      status: status ?? this.status,
    );
  }
}
