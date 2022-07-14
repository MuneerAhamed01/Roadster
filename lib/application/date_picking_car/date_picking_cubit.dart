import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'date_picking_state.dart';

class DatePickingCubit extends Cubit<DatePickingState> {
  DatePickingCubit() : super(DatePickingInitial());
  void pickDateTimeRange(BuildContext context) async {
    final newDate = await showDateRangePicker(
      context: context,
      lastDate: DateTime(2030),
      firstDate: DateTime.now(),
      // initialDate: DateTime.now(),
    );
    if (newDate != null) {
      // final dateFormated = DateFormat("dd MMMM yyyy").format(newDate.start);

      emit(DatePickingDone(newDate));
    }
  }
}
