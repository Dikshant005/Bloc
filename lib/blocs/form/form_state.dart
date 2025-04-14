// form_state.dart
abstract class FormBlocState {}

class FormInitial extends FormBlocState {}

class FormSubmitting extends FormBlocState {}

class FormSuccess extends FormBlocState {
  final String name;
  final String email;
  final String phone;
  final String gender;
  final String country;
  final String state;
  final String city;

  FormSuccess({
    required this.name,
    required this.email,
    required this.phone,
    required this.gender,
    required this.country,
    required this.state,
    required this.city,
  });
}

class FormFailure extends FormBlocState {
  final String errorMessage;

  FormFailure(this.errorMessage);
}
