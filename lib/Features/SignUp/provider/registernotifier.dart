import 'package:dags/Features/SignUp/provider/registrationstate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegistrationNotifier extends StateNotifier<RegistrationState>
{
  // Constructor
  RegistrationNotifier():super(const RegistrationState());

  void onPhoneNumberChange(String phoneNumber)
  {
    state=state.copyWith(phoneNumber:phoneNumber);
  }
  // void onUserNameChange(String name)
  // {
  //   state=state.copyWith(name:name);
  // }
  // void onUserEmailChange(String email)
  // {
  //   state=state.copyWith(email:email);
  // }
}

final registrationNotifierProvider= StateNotifierProvider<RegistrationNotifier,RegistrationState>((ref) {
  return RegistrationNotifier();
});
