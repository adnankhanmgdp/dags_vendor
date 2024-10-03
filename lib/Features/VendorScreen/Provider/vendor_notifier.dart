import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'VendorState.dart';

class VendorNotifier extends StateNotifier<VendorState>
{
  // Constructor
  VendorNotifier():super(const VendorState());

  void onUserNameChange(String name)
  {
    state=state.copyWith(userName: name);
  }
  void onUserEmailChange(String email)
  {
    state=state.copyWith(email: email);
  }
  void onUserAddressChange(String address)
  {
    state=state.copyWith(address: address);
  }
  void onUserCapacityChange(String capacity)
  {
    state=state.copyWith(capacity:capacity);
  }
}

final vendorNotifierProvider= StateNotifierProvider<VendorNotifier,VendorState>((ref) {
  return VendorNotifier();
});
