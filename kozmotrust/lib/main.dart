import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:kozmotrust/providers/user_provider.dart';
import 'package:kozmotrust/features/auth/screens/auth_screen.dart';
import 'package:kozmotrust/features/home/screens/home_screen.dart';
import 'package:kozmotrust/common/widgets/bottom_bar.dart';
import 'package:kozmotrust/features/auth/services/auth_service.dart';
import 'package:kozmotrust/router.dart';
import 'constants/global_variables.dart';
import 'localizations.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    ),
  ], child: const MyApp()));
}

final supportedLocales = [
  const Locale('en'), // English
  const Locale('tr'), // Turkish
];

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _authService.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kozmotrust',
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      locale: const Locale('en'), // Default locale is English
      supportedLocales: supportedLocales,
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        colorScheme: const ColorScheme.light(
          primary: GlobalVariables.secondaryColor,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: Consumer<UserProvider>(
        builder: (context, userProvider, _) {
          // userProvider.fetchUserData();
          if (userProvider.user.token.isEmpty) {
            return const AuthScreen();
          } else {
            return userProvider.user.token.isNotEmpty ? const BottomBar() : const HomeScreen();
          }
        },
      ),
    );
  }
}
