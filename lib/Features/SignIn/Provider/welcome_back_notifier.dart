import 'package:dags/Features/SignIn/Provider/welcome_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WelcomeNotifier extends StateNotifier<WelcomeState>
{
  // Constructor
  WelcomeNotifier():super(const WelcomeState());

  void onPhoneNumberChange(String phoneNumber)
  {
    state=state.copyWith(phoneNumber:phoneNumber);
  }
}

final welcomeNotifierProvider= StateNotifierProvider<WelcomeNotifier,WelcomeState>((ref) {
  return WelcomeNotifier();
});
