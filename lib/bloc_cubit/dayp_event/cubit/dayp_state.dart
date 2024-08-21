part of 'dayp_cubit.dart';

// @immutable
sealed class DaypState {}

final class DaypInitial extends DaypState {}

class DaypLoadingState extends DaypState {}

class DaypLoadedState extends DaypState {}

class DaypErrorState extends DaypState {}