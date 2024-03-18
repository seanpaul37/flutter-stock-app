import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_app/core/services/Navigation_Service.dart';
import 'package:stock_app/core/states_manager/blocs/add_gest_bloc.dart';
import 'package:stock_app/core/states_manager/blocs/list_product_bloc.dart';

import 'core/RouterGenerator.dart';
import 'package:intl/intl.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/states_manager/SimpleBlocObserver.dart';
import 'core/states_manager/blocs/add_product_blocs.dart';
import 'core/states_manager/blocs/delete_product_bloc.dart';
import 'core/states_manager/blocs/update_product_bloc.dart';

void main() {
  Intl.defaultLocale = "fr";
  runApp(const MyApp());
  Bloc.observer = SimpleBlocObserver();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProductBloc()),
        BlocProvider(create: (context) => AddProductBloc()),
        BlocProvider(create: (context) => UpdateProductBloc()),
        BlocProvider(create: (context) => DeleteProductBloc()),
        BlocProvider(create: (context) => AddGestBloc()),
      ],
      child: MaterialApp(
        navigatorKey: NavigationService.navigatorKey,
        title: 'Informations - leboncoin, site de petites annonces gratuites',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a purple toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 219, 217, 217)),
          useMaterial3: true,
        ),
        supportedLocales: const [
          Locale('fr'),
          Locale('fr', 'FR'),
        ],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        debugShowCheckedModeBanner: false,
        onGenerateRoute: (RouteSettings settings) {
          return RouterGenerator.navigate(settings);
        },
      ),
    );
  }
}
