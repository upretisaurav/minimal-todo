import 'package:equatable/equatable.dart';
import 'package:minimal_todo/domain/entities/task_filter_entity.dart';

abstract class FilterEvent extends Equatable {
  const FilterEvent();

  @override
  List<Object?> get props => [];
}

class ChangeFilterEvent extends FilterEvent {
  final TaskFilter filter;

  const ChangeFilterEvent(this.filter);

  @override
  List<Object?> get props => [filter];
}

class SetDateRangeEvent extends FilterEvent {
  final DateTime? startDate;
  final DateTime? endDate;

  const SetDateRangeEvent({this.startDate, this.endDate});

  @override
  List<Object?> get props => [startDate, endDate];
}

class ClearDateRangeEvent extends FilterEvent {
  const ClearDateRangeEvent();
}

class ResetFiltersEvent extends FilterEvent {
  const ResetFiltersEvent();
}
