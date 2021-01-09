//import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'
    show
        Widget, runApp, BuildContext,
        Center, Colors, Column,
        Icons, MaterialApp, Scaffold,
        Text, Theme, ThemeData;

import 'package:firebase_core/firebase_core.dart' show Firebase;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:prof_prep/app/auth_widget.dart';
import 'package:prof_prep/app/home/home_page.dart';
import 'package:prof_prep/app/onboarding/onboarding_page.dart';
import 'package:prof_prep/app/onboarding/onboarding_view_model.dart';
import 'package:prof_prep/app/top_level_providers.dart';
import 'package:prof_prep/app/sign_in/sign_in_page.dart';
import 'package:prof_prep/routing/app_router.dart';
import 'package:flutter/material.dart';

import 'package:riverpod/riverpod.dart';
import 'package:prof_prep/services/shared_preferences_service.dart';

import 'package:flutter/material.dart';


Future<void>  main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final sharedPreferences = await SharedPreferences.getInstance();


  runApp(
       ProviderScope(
         overrides: [
           sharedPreferencesServiceProvider.overrideWithValue(
             SharedPreferencesService(sharedPreferences),
           ),
         ],
         child: App(),
  )
  );
}
//LIGHT WAY TO CODE, important this app doesn't need update himself constantly
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //TODO ASYNC COMMUNICATE TO FIREBASE ISOLATED.
    final firebaseAuth = context.read(firebaseAuthProvider);

    return  MaterialApp(
      theme: ThemeData(primarySwatch: Colors.yellow),
      // home: AuthWidget(
      //   nonSIgnedInBuilder: (_) => Consumer(
      //     builder: (context, watch, _){
      //       final didCompleteOnboarding = watch(onboardingViewModelProvider.state);
      //       return didCompleteOnboarding ? SignInPage() : OnboardingPage();
      //     },
      //   ),
      //   signedInBuilder: (_) => HomePage(),
      // ),
      onGenerateRoute: (settings) => AppRouter.onGenerateRoute(settings, firebaseAuth),
    );
  }
}
