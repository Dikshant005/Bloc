// form_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'form_event.dart';
import 'form_state.dart';

class FormBloc extends Bloc<FormEvent, FormBlocState> {
  FormBloc() : super(FormInitial()) {
    on<SubmitFormEvent>(_onSubmitForm);
  }

  void _onSubmitForm(SubmitFormEvent event, Emitter<FormBlocState> emit) {
    print("Form submission started");
    emit(FormSubmitting());

    // Validation checks
    if (event.name.isEmpty ||
        event.email.isEmpty ||
        event.phone.isEmpty ||
        event.gender.isEmpty ||
        event.country.isEmpty ||
        event.state.isEmpty ||
        event.city.isEmpty) {
      emit(FormFailure('Please fill in all fields'));
      return;
    }

    if (!_isValidName(event.name)) {
      emit(FormFailure('Name must be at least 3 characters and contain no numbers'));
      return;
    }

    if (!_isValidLocation(event.country)) {
      emit(FormFailure('Please enter a valid country name'));
      return;
    }

    if (!_isValidLocation(event.state)) {
      emit(FormFailure('Please enter a valid state name'));
      return;
    }

    if (!_isValidLocation(event.city)) {
      emit(FormFailure('Please enter a valid city name'));
      return;
    }

    if (!_isValidEmail(event.email)) {
      emit(FormFailure('Invalid email format'));
      return;
    }

    if (!_isValidPhone(event.phone)) {
      emit(FormFailure('Phone number must be 10 digits'));
      return;
    }

    print("Form validation successful");
    emit(FormSuccess(
      name: event.name,
      email: event.email,
      phone: event.phone,
      gender: event.gender,
      country: event.country,
      state: event.state,
      city: event.city,
    ));
  }

  bool _isValidName(String name) {
    if (name.length < 3) return false;
    final hasNumbers = RegExp(r'[0-9]').hasMatch(name);
    return !hasNumbers;
  }

  bool _isValidLocation(String value) {
    return value.length >= 3;
  }

  bool _isValidEmail(String email) {
    final regex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    return regex.hasMatch(email);
  }

  bool _isValidPhone(String phone) {
    final regex = RegExp(r"^\d{10}$");
    return regex.hasMatch(phone);
  }
}
