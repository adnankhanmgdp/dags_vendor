class VendorState {
  final String userName;
  final String email;
  final String address;
  final String capacity;

  ///CONSTRUCTOR
  const VendorState(
      {this.userName = "",
        this.email = "",
        this.address = "",
        this.capacity = ""});

  ///Methode
  VendorState copyWith(
      {String? userName,
        String? email,
        String? address,
        String? capacity}) {
    return VendorState(
        userName: userName ?? this.userName,
        email: email ?? this.email,
        address: address ?? this.address,
        capacity: capacity ?? this.capacity);
  }
}
