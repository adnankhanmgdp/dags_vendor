import 'package:dags/Features/AccountsScreen/view/accounts_scr.dart';
import 'package:dags/Features/DeliveryPartnerScreen/view/delivery_partner_scr.dart';
import 'package:dags/Features/HelpSupportScreen/view/help_support.dart';
import 'package:dags/Features/LocationRequest/view/location_req.dart';
import 'package:dags/Features/OrderdetailScreen/view/order_detail_screen.dart';
import 'package:dags/Features/OrdersScreen/view/orders_scr.dart';
import 'package:dags/Features/ProfileScreen/view/profile.dart';
import 'package:dags/Features/SplashScreen/view/splash_scr_view.dart';
import 'package:dags/Features/TermsScreen/view/terms_scr.dart';
import 'package:dags/Features/TransactionScreen/view/transaction_screen.dart';
import 'package:dags/Features/VendorScreen/view/vendor_scr.dart';
import 'package:dags/Features/VerificationSuccessScreen/view/verification_scs_scr.dart';
import 'package:dags/Features/VerifyingStayScreen/view/verifying_scr.dart';
import 'package:dags/Features/application/view/application.dart';
import 'package:dags/Features/dashboardScreen/view/dashboard_scr.dart';
import 'package:dags/Features/otp%20screen/view/otp_scr.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../Features/CameraScreen/view/camera_scr.dart';
import '../../Features/KycScreen/view/kyc_scr.dart';
import '../../Features/ProofScreen/view/proof_scr.dart';
import '../../Features/SignIn/view/welcome_back_scr.dart';
import '../../Features/SignUp/view/register_screen.dart';
import '../Services/global.dart';
import 'appRoutes.dart';

class appPages {
  static List<RouteEntity> routes() {
    return [
      RouteEntity(
          path: AppRoutes.SPLASH,
          page: const ProviderScope(child: SplashScreen())),
      RouteEntity(
          path: AppRoutes.REGISTER,
          page: const ProviderScope(child: Register())),
      RouteEntity(
          path: AppRoutes.OTP, page: const ProviderScope(child: OtpScreen())),
      RouteEntity(
          path: AppRoutes.VENDOR,
          page: const ProviderScope(child: VendorScreen())),
      RouteEntity(
          path: AppRoutes.KYC, page: const ProviderScope(child: KycScreen())),
      RouteEntity(
          path: AppRoutes.PROOF,
          page: const ProviderScope(child: ProofScreen())),
      RouteEntity(
          path: AppRoutes.CAMERA,
          page: const ProviderScope(child: CameraScreen())),
      RouteEntity(
          path: AppRoutes.VERIFY,
          page: const ProviderScope(child: VerifyingScreen())),
      RouteEntity(
          path: AppRoutes.VERIFYSCS,
          page: const ProviderScope(child: VerifyingSuccessScreen())),
      RouteEntity(
          path: AppRoutes.WELCOMEBACK,
          page: const ProviderScope(child: WelcomeBackScreen())),
      RouteEntity(
          path: AppRoutes.DELIVERYPARTNER,
          page: const ProviderScope(child: DeliveryPartnerScreen())),
      RouteEntity(
          path: AppRoutes.TERMS,
          page: const ProviderScope(child: TermsScreen())),
      RouteEntity(
          path: AppRoutes.APPLICATION,
          page: const ProviderScope(child: Application())),
      RouteEntity(
          path: AppRoutes.PROFILE,
          page: const ProviderScope(child: ProfileScreen())),
      RouteEntity(
          path: AppRoutes.ORDERDETAIL,
          page: const ProviderScope(child: OrderDetailsScreen())),
      RouteEntity(
          path: AppRoutes.ORDERSCREEN,
          page: const ProviderScope(child: OrdersScreen())),
      RouteEntity(
          path: AppRoutes.TRANSACTION,
          page: const ProviderScope(child: TransactionHistoryScreen())),
      RouteEntity(
          path: AppRoutes.HELP, page: const ProviderScope(child: HelpScreen())),
      RouteEntity(
          path: AppRoutes.ACCOUNTS,
          page: const ProviderScope(child: AccountsScreen())),
      RouteEntity(
          path: AppRoutes.DASHBOARD,
          page: const ProviderScope(child: DashBoardScreen())),
      RouteEntity(
          path: AppRoutes.LOCATION,
          page: const ProviderScope(child: LocationRequestScreen())),
    ];
  }

  static MaterialPageRoute generateRouteSettings(RouteSettings settings) {
    if (kDebugMode) {
      print('current route name is ${settings.name}');
    }
    if (settings.name != null) {
      var result = routes().where((element) => element.path == settings.name);

      bool userLoggedInEarlier =
          Global.storageServices.getUserLoggedInEarlier();

      bool userRegisteredEarlier =
          Global.storageServices.getUserRegisteredEarlier();

      bool vendorRegisteredEarlier =
          Global.storageServices.getVendorRegisteredEarlier();

      bool kycDoneEarlier = Global.storageServices.getKycDoneEarlier();

      bool locationGranted = Global.storageServices.getLocationGranted();

      /// NOW HERE WE ARE CHECKING IF THE CURRENT ROUTE IS WELCOME PAGE ROUTE AND Device has been opened earlier...
      /// and if it is true then navigate the user to the login screen..not to the welcome screen anymore
      /// NOTE- THIS INFORMATION WHETHER THE DEVICE IS OPENED FIRST TIME OR NOT WILL BE STORED UNDER THE getDeviceOpenedEarlier()
      /// FUNCTION OF STORAGE SERVICES WHICH IS CAPABLE OF STORING THE STATE EVEN IF THE APP IS CLOSED....
      ///  THIS STATE OF getDeviceOpenedEarlier() WILL BE STORED IN THE PERMANENT MEMORY...
      if (result.first.path == AppRoutes.WELCOMEBACK && userLoggedInEarlier) {
        if (kDebugMode) {
          print("pahle path se hai");
        }
        if (locationGranted) {
          return MaterialPageRoute(
              builder: (_) => const ProviderScope(child: Application()),
              settings: settings);
        }
        return MaterialPageRoute(
            builder: (_) => const ProviderScope(child: LocationRequestScreen()),
            settings: settings);
      } else if (result.first.path == AppRoutes.REGISTER &&
          userRegisteredEarlier) {
        if (kDebugMode) {
          print("dusre path se hai");
        }
        if (vendorRegisteredEarlier) {
          debugPrint('vendor is already registered');
          if (kycDoneEarlier) {
            if (locationGranted) {
              return MaterialPageRoute(
                  builder: (_) => const ProviderScope(child: Application()),
                  settings: settings);
            }
            return MaterialPageRoute(
                builder: (_) =>
                    const ProviderScope(child: LocationRequestScreen()),
                settings: settings);
          } else {
            return MaterialPageRoute(
                builder: (_) => const ProviderScope(child: KycScreen()),
                settings: settings);
          }
        } else {
          debugPrint('vendor is not  registered');
          return MaterialPageRoute(
              builder: (_) => const ProviderScope(child: VendorScreen()),
              settings: settings);
        }
      } else {
        if (kDebugMode) {
          print("sab mamla chaupat hai");
        }
        return MaterialPageRoute(
            builder: (_) => result.first.page, settings: settings);
      }
    }
    return MaterialPageRoute(
        builder: (_) => const ProviderScope(child: SplashScreen()),
        settings: settings);
  }
}

class RouteEntity {
  String path;
  Widget page;

  RouteEntity({required this.path, required this.page});
}
