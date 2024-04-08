import 'package:kozmotrust/common/widgets/admin_bottom_bar.dart';
import 'package:kozmotrust/common/widgets/bottom_bar.dart';
import 'package:kozmotrust/features/account/screens/healthinfo_screen.dart';
import 'package:kozmotrust/features/account/widgets/search_favorites.dart';
import 'package:kozmotrust/features/auth/screens/auth_screen.dart';
import 'package:kozmotrust/features/account/screens/account_settings.dart';
import 'package:kozmotrust/features/home/screens/home_screen.dart';
import 'package:kozmotrust/features/product_details/screens/product_details_screen.dart';
import 'package:kozmotrust/features/product_details/screens/gpt_examine_screen.dart';
import 'package:kozmotrust/features/search/screens/search_screen.dart';
import 'package:kozmotrust/models/product.dart';
import 'package:flutter/material.dart';
import 'features/admin/screens/search-edit-delete-product.dart';

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
    case AdminBottomBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AdminBottomBar(),
      );
    case SearchScreen.routeName:
      var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SearchScreen(
          searchQuery: searchQuery,
        ),
      );
    case SearchFavorites.routeName:
      var searchQuery = routeSettings.arguments as String?;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SearchFavorites(
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
    case GPTExamineScreen.routeName:
      var answer = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => GPTExamineScreen(
          answer: answer,
        ),
      );
    case HealthInformationScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HealthInformationScreen(),
      );
    case SearchEditDeleteScreen.routeName:
      var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SearchEditDeleteScreen(
          searchQuery: searchQuery,
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
