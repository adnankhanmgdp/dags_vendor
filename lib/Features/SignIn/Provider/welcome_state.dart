class WelcomeState {
  final String phoneNumber;

  ///CONSTRUCTOR
  const WelcomeState({this.phoneNumber = ""});

  ///Methode
  WelcomeState copyWith(
      {String? phoneNumber}) {
    return WelcomeState(phoneNumber: phoneNumber ?? this.phoneNumber);
  }
}
