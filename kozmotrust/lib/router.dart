import 'package:kozmotrust/common/widgets/bottom_bar.dart';
import 'package:kozmotrust/features/allergies/screens/allergies_screen.dart';
import 'package:kozmotrust/features/admin/screens/add_product_screen.dart';
import 'package:kozmotrust/features/auth/screens/auth_screen.dart';
import 'package:kozmotrust/features/account/screens/account_settings.dart';
import 'package:kozmotrust/features/home/screens/home_screen.dart';
import 'package:kozmotrust/features/product_details/screens/product_details_screen.dart';
import 'package:kozmotrust/features/search/screens/search_screen.dart';
import 'package:kozmotrust/models/product.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreen(),
      );
    case AccountSettings.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AccountSettings(),
      );
    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeScreen(),
      );
    case BottomBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BottomBar(),
      );
    case AddProductScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AddProductScreen(),
      );
    case SearchScreen.routeName:
      var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SearchScreen(
          searchQuery: searchQuery,
        ),
      );
    case ProductDetailScreen.routeName:
      var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ProductDetailScreen(
          product: product,
        ),
      );
    case AllergiesScreen.routeName:
      var totalAmount = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AllergiesScreen(
          totalAmount: totalAmount,
        ),
      );
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Screen does not exist!'),
          ),
        ),
      );
  }
}
