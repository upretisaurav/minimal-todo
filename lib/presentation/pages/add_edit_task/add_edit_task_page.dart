import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../../../config/constants/colors.dart';
import '../../../config/constants/dimensions.dart';
import '../../../config/constants/strings.dart';
import '../../../config/injector/injection_container.dart';
import '../../../core/utils/validators.dart';
import '../../../domain/entities/task_entity.dart';
import '../../blocs/task/task_bloc.dart';
import '../../blocs/task/task_event.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/common/custom_text_field.dart';

class AddEditTaskPage extends StatefulWidget {
  final TaskEntity? task;

  const AddEditTaskPage({super.key, this.task});

  @override
  State<AddEditTaskPage> createState() => _AddEditTaskPageState();
}

class _AddEditTaskPageState extends State<AddEditTaskPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  TaskPriority _selectedPriority = TaskPriority.medium;
  DateTime? _selectedDueDate;
  bool get _isEditing => widget.task != null;

  @override
  void initState() {
    super.initState();
    if (_isEditing) {
      _titleController.text = widget.task!.title;
      _descriptionController.text = widget.task!.description ?? '';
      _selectedPriority = widget.task!.priority;
      _selectedDueDate = widget.task!.dueDate;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TaskBloc>(
      create: (_) => getIt<TaskBloc>(),
      child: Scaffold(
        backgroundColor: context.colors.surface,
        appBar: AppBar(
          title: Text(_isEditing ? AppStrings.editTask : AppStrings.addTask),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(AppDimensions.paddingL),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomTextField(
                  controller: _titleController,
                  labelText: AppStrings.title,
                  validator: TaskValidators.validateTitle,
                ),
                const SizedBox(height: AppDimensions.paddingL),

                CustomTextField(
                  controller: _descriptionController,
                  labelText: AppStrings.description,
                  maxLines: 3,
                  validator: TaskValidators.validateDescription,
                ),
                const SizedBox(height: AppDimensions.paddingL),

                _PrioritySelector(
                  selectedPriority: _selectedPriority,
                  onPriorityChanged: (priority) {
                    setState(() {
                      _selectedPriority = priority;
                    });
                  },
                ),
                const SizedBox(height: AppDimensions.paddingL),

                _DueDateSelector(
                  selectedDate: _selectedDueDate,
                  onDateChanged: (date) {
                    setState(() {
                      _selectedDueDate = date;
                    });
                  },
                ),
                const SizedBox(height: AppDimensions.paddingXL),

                CustomButton(text: AppStrings.saveTask, onPressed: _saveTask),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _saveTask() {
    if (!_formKey.currentState!.validate()) return;

    final task = TaskEntity(
      id: _isEditing ? widget.task!.id : const Uuid().v4(),
      title: _titleController.text.trim(),
      description:
          _descriptionController.text.trim().isEmpty
              ? null
              : _descriptionController.text.trim(),
      isCompleted: _isEditing ? widget.task!.isCompleted : false,
      createdAt: _isEditing ? widget.task!.createdAt : DateTime.now(),
      dueDate: _selectedDueDate,
      priority: _selectedPriority,
    );

    if (_isEditing) {
      context.read<TaskBloc>().add(UpdateTaskEvent(task));
    } else {
      context.read<TaskBloc>().add(AddTaskEvent(task));
    }

    context.pop();
  }
}

class _PrioritySelector extends StatelessWidget {
  final TaskPriority selectedPriority;
  final ValueChanged<TaskPriority> onPriorityChanged;

  const _PrioritySelector({
    required this.selectedPriority,
    required this.onPriorityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.priority,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: AppDimensions.paddingS),
        Row(
          children:
              TaskPriority.values.map((priority) {
                final isSelected = priority == selectedPriority;
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      right: AppDimensions.paddingS,
                    ),
                    child: GestureDetector(
                      onTap: () => onPriorityChanged(priority),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: AppDimensions.paddingM,
                        ),
                        decoration: BoxDecoration(
                          color:
                              isSelected
                                  ? context.priorityBgColor(
                                    priority.displayName,
                                  )
                                  : context.colors.surfaceContainerLowest,
                          borderRadius: BorderRadius.circular(
                            AppDimensions.radiusM,
                          ),
                          border:
                              isSelected
                                  ? Border.all(
                                    color: _getPriorityColor(context, priority),
                                    width: 2,
                                  )
                                  : null,
                        ),
                        child: Text(
                          priority.displayName,
                          textAlign: TextAlign.center,
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(
                            color:
                                isSelected
                                    ? _getPriorityColor(context, priority)
                                    : context.colors.onSurfaceVariant,
                            fontWeight: isSelected ? FontWeight.w600 : null,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }

  Color _getPriorityColor(BuildContext context, TaskPriority priority) {
    switch (priority) {
      case TaskPriority.high:
        return context.priorityHighColor;
      case TaskPriority.medium:
        return context.priorityMediumColor;
      case TaskPriority.low:
        return context.priorityLowColor;
    }
  }
}

class _DueDateSelector extends StatelessWidget {
  final DateTime? selectedDate;
  final ValueChanged<DateTime?> onDateChanged;

  const _DueDateSelector({
    required this.selectedDate,
    required this.onDateChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.dueDate,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: AppDimensions.paddingS),
        GestureDetector(
          onTap: () => _selectDate(context),
          child: Container(
            padding: const EdgeInsets.all(AppDimensions.paddingM),
            decoration: BoxDecoration(
              color: context.colors.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(AppDimensions.radiusM),
              border: Border.all(color: context.colors.outline),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  color: context.colors.onSurfaceVariant,
                ),
                const SizedBox(width: AppDimensions.paddingM),
                Expanded(
                  child: Text(
                    selectedDate != null
                        ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                        : 'Select due date (optional)',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color:
                          selectedDate != null
                              ? context.colors.onSurfaceVariant
                              : context.colors.onSurfaceVariant.withAlpha(128),
                    ),
                  ),
                ),
                if (selectedDate != null)
                  GestureDetector(
                    onTap: () => onDateChanged(null),
                    child: Icon(
                      Icons.clear,
                      color: context.colors.onSurfaceVariant,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null) {
      onDateChanged(picked);
    }
  }
}
