import 'package:flutter/material.dart';
import 'package:hotel_app/core/router/routes.dart';
import 'package:hotel_app/features/categories/presentation/views/screens/categories_hotel.dart';
import 'package:hotel_app/features/profile/presentation/views/screens/profile_screen.dart';
import 'package:hotel_app/features/auth/presentation/views/screens/login_in_screen.dart';
import 'package:hotel_app/features/profile/presentation/views/screens/splash_screen.dart';
import '../../features/auth/presentation/views/screens/sign_up_screen.dart';
import '../../features/search/presentation/views/screens/filter_screen.dart';
import '../../features/search/presentation/views/screens/search_screen.dart';

class AppRouter {
  static final Map<String, WidgetBuilder> appRoutes = {
    AppRoutes.profile: (context) => ProfileScreen(),
    AppRoutes.searchScreen: (context) => SearchScreen(),
    AppRoutes.filter: (context) => FilterScreen(),
    AppRoutes.signUp: (context) => SignUpScreen(),
    AppRoutes.login: (context) => LoginInScreen(),
    AppRoutes.categories: (context) => CategoriesHotel(),
    // AppRoutes.booking: (context) => BookingScreen(),
    AppRoutes.spleshScreen: (context) => SplashScreen(),
  };
}
