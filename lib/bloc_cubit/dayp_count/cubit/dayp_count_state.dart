part of 'dayp_count_cubit.dart';

sealed class DaypCountState {}

final class DaypCountInitial extends DaypCountState {}

class DaypCountLoadingState extends DaypCountState {}

class DaypCountLoadedState extends DaypCountState {
  final daypCountData;
  DaypCountLoadedState(this.daypCountData);
}

class DaypComparisonCountLoadedState extends DaypCountState {
  final daypComparisonData;
  DaypComparisonCountLoadedState(this.daypComparisonData);
}

class DaypCountErrorState extends DaypCountState {
  final String errorMessage;
  DaypCountErrorState(this.errorMessage);

  // DaypCountErrorState(String? statusMessage);
}