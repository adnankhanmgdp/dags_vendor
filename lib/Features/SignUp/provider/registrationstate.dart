class RegistrationState {
  final String phoneNumber;


  ///CONSTRUCTOR
  const RegistrationState(
      {this.phoneNumber = ""});

  ///Methode
  RegistrationState copyWith(
      {String? phoneNumber, String? name, String? email}) {
    return RegistrationState(
        phoneNumber: phoneNumber ?? this.phoneNumber,
     );
  }
}
