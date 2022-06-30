import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'date_picker_state.dart';

class DatePickerCubit extends Cubit<DatePickerState> {
  static final formattedDate =
      DateFormat("dd MMMM yyyy").format(DateTime.now());
  DatePickerCubit() : super(DatePickerInitial(formattedDate));
  void onTapTextfield(BuildContext context) async {
    final newDate = await showDatePicker(
      context: context,
      lastDate: DateTime(2003, 13),
      firstDate: DateTime(1990),
      initialDate: DateTime(2004),
    );
    if (newDate != null) {
      final dateFormated = DateFormat("dd MMMM yyyy").format(newDate);
      emit(DatePickerInitial(dateFormated));
    }
  }
}
