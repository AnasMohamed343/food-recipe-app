import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipe_app/Constants.dart';
import 'package:recipe_app/Features/auth/login/Login.dart';
import 'package:recipe_app/Features/auth/sign_up/Signup.dart';
import 'package:recipe_app/Features/cart_screen/presentation/views/cart_screen.dart';
import 'package:recipe_app/Features/category_screen/presentation/views/category_screen.dart';
import 'package:recipe_app/Features/home/presentation/views/home_view.dart';
import 'package:recipe_app/Features/profile_screen/presentation/views/profile_screen.dart';
import 'package:recipe_app/Features/profile_screen/presentation/views/widgets/favorite_screen.dart';
import 'package:recipe_app/Features/profile_screen/presentation/views/widgets/update_profile_details.dart';
import 'package:recipe_app/Features/search/presentation/views/search_screen.dart';
import 'package:recipe_app/Features/splash_screen/splash_screen.dart';
import 'package:recipe_app/core/utiles/routes_manager.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/provider/authentication_provider.dart';
import 'package:recipe_app/provider/cart_model.dart';
import 'package:recipe_app/provider/favorite_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'di/di.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize Hive
  //await Hive.initFlutter();

  configureDependencies();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => AuthenticationProvider(),
    ),
    ChangeNotifierProxyProvider<AuthenticationProvider, CartModel>(
      create: (context) => CartModel(''),
      update: (context, authProvider, previousCartModel) =>
          CartModel(authProvider.userId ?? ''),
    ),
    // Use a Builder to access the context safely
    ChangeNotifierProxyProvider<AuthenticationProvider, FavoriteProvider>(
      create: (context) {
        final authProvider =
            Provider.of<AuthenticationProvider>(context, listen: false);
        if (authProvider.userId == null || authProvider.userId!.isEmpty) {
          return FavoriteProvider(''); // or handle it another way
        }
        return FavoriteProvider(authProvider.userId!);
      },
      update: (context, authProvider, previous) => FavoriteProvider(
        authProvider.userId ?? '',
      ),
    ),
  ], child: RecipeApp()));
}

class RecipeApp extends StatelessWidget {
  RecipeApp({super.key});

  // final FlutterSecureStorage secureStorage = FlutterSecureStorage();
  // bool isUserLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: Provider.of<AuthenticationProvider>(context, listen: false)
          .isUserRemembered(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        } else {
          bool isUserLoggedIn = snapshot.data ?? false;
          return ScreenUtilInit(
            designSize: const Size(412, 867),
            minTextAdapt: true,
            splitScreenMode: true,
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              //home: HomeView(),
              routes: {
                RoutesManager.homeScreenRoute: (context) => const HomeView(),
                RoutesManager.searchScreenRoute: (context) =>
                    const SearchScreen(),
                RoutesManager.cartScreenRoute: (context) => const CartScreen(),
                RoutesManager.categoryScreenRoute: (context) =>
                    const CategoryScreen(),
                RoutesManager.splashScreenRoute: (context) =>
                    const SplashScreen(),
                RoutesManager.signupScreenRoute: (context) => const Signup(),
                RoutesManager.loginScreenRoute: (context) => const Login(),
                RoutesManager.favoriteScreenRoute: (context) =>
                    const FavoriteScreen(),
                RoutesManager.profileScreenRoute: (context) =>
                    const ProfileScreen(),
                RoutesManager.updateProfileScreenRoute: (context) =>
                    const UpdateProfileDetails(),
              },
              initialRoute: isUserLoggedIn
                  ? RoutesManager.homeScreenRoute
                  : RoutesManager.splashScreenRoute,
            ),
          );
        }
      },
    );
    // return FutureBuilder(
    //   future: secureStorage.read(key: kKeepMeLoggedIn),
    //   builder: (context, snapshot) {
    //     // Debugging print
    //     print("Snapshot state: ${snapshot.connectionState}");
    //
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return const MaterialApp(
    //         home: Scaffold(
    //           body: Center(child: CircularProgressIndicator()),
    //         ),
    //       );
    //     } else if (snapshot.hasError) {
    //       return const MaterialApp(
    //         home: Scaffold(
    //           body: Center(child: Text("Error reading secure storage")),
    //         ),
    //       );
    //     } else {
    //       bool isUserLoggedIn =
    //           snapshot.data == 'true'; // Compare the value to 'true'
    //       return ScreenUtilInit(
    //         designSize: const Size(412, 867),
    //         minTextAdapt: true,
    //         splitScreenMode: true,
    //         child: MaterialApp(
    //           debugShowCheckedModeBanner: false,
    //           routes: {
    //             RoutesManager.homeScreenRoute: (context) => const HomeView(),
    //             RoutesManager.searchScreenRoute: (context) =>
    //                 const SearchScreen(),
    //             RoutesManager.cartScreenRoute: (context) => const CartScreen(),
    //             RoutesManager.categoryScreenRoute: (context) =>
    //                 const CategoryScreen(),
    //             RoutesManager.splashScreenRoute: (context) =>
    //                 const SplashScreen(),
    //             RoutesManager.signupScreenRoute: (context) => const Signup(),
    //             RoutesManager.loginScreenRoute: (context) => const Login(),
    //             RoutesManager.favoriteScreenRoute: (context) =>
    //                 const FavoriteScreen(),
    //             RoutesManager.profileScreenRoute: (context) =>
    //                 const ProfileScreen(),
    //             RoutesManager.updateProfileScreenRoute: (context) =>
    //                 const UpdateProfileDetails(),
    //           },
    //           initialRoute: isUserLoggedIn
    //               ? RoutesManager.homeScreenRoute
    //               : RoutesManager.splashScreenRoute,
    //         ),
    //       );
    //     }
    //   },
    // );
  }
}
