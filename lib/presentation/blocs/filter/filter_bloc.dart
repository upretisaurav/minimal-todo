import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/task_filter_entity.dart';
import 'filter_event.dart';
import 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  FilterBloc() : super(const FilterState()) {
    on<ChangeFilterEvent>(_onChangeFilter);
    on<SetDateRangeEvent>(_onSetDateRange);
    on<ClearDateRangeEvent>(_onClearDateRange);
    on<ResetFiltersEvent>(_onResetFilters);
  }

  void _onChangeFilter(ChangeFilterEvent event, Emitter<FilterState> emit) {
    emit(
      state.copyWith(
        currentFilter: event.filter,
        hasActiveFilters: _checkHasActiveFilters(
          filter: event.filter,
          startDate: state.startDate,
          endDate: state.endDate,
        ),
      ),
    );
  }

  void _onSetDateRange(SetDateRangeEvent event, Emitter<FilterState> emit) {
    emit(
      state.copyWith(
        startDate: event.startDate,
        endDate: event.endDate,
        hasActiveFilters: _checkHasActiveFilters(
          filter: state.currentFilter,
          startDate: event.startDate,
          endDate: event.endDate,
        ),
      ),
    );
  }

  void _onClearDateRange(ClearDateRangeEvent event, Emitter<FilterState> emit) {
    emit(
      state.copyWith(
        hasActiveFilters: _checkHasActiveFilters(
          filter: state.currentFilter,
        ),
      ),
    );
  }

  void _onResetFilters(ResetFiltersEvent event, Emitter<FilterState> emit) {
    emit(const FilterState());
  }

  bool _checkHasActiveFilters({
    required TaskFilter filter,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return filter != TaskFilter.all || startDate != null || endDate != null;
  }
}
