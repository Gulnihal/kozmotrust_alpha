import 'package:kozmotrust/common/widgets/bottom_bar.dart';
import 'package:kozmotrust/constants/global_variables.dart';
import 'package:kozmotrust/features/auth/screens/auth_screen.dart';
import 'package:kozmotrust/features/auth/services/auth_service.dart';
import 'package:kozmotrust/features/home/screens/home_screen.dart';
import 'package:kozmotrust/providers/user_provider.dart';
import 'package:kozmotrust/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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
  final AuthService authService = AuthService();
  Locale _locale = const Locale('en'); // Default locale is English

  // Function to change the app's language
  void changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
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
      locale: _locale,
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
        useMaterial3: true, // can remove this line
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: ScaffoldMessenger(
        child: Provider.of<UserProvider>(context).user.token.isEmpty
            ? const AuthScreen()
            : Provider.of<UserProvider>(context).user.token.isNotEmpty
                ? const BottomBar()
                : const HomeScreen(),
      ),
    );
  }
}
