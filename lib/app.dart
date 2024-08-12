import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shopping_app/bloc/authentication/authentication_bloc.dart';
import 'package:flutter_shopping_app/routes/routes.dart';
import 'package:flutter_shopping_app/themes/theme_data.dart';
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class App extends StatelessWidget {
  
  const App({super.key});

 
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
         BlocProvider<AuthenticationBloc>(
          create: (BuildContext context) => AuthenticationBloc(),
        ),
      ],
      child: MaterialApp.router(
      
        title: 'E-Commerce App',
        debugShowCheckedModeBanner: false,
        theme: ThemeConfig.lightTheme  ,
       
        themeMode: ThemeMode.light ,
         routeInformationParser: router.routeInformationParser,
        routerDelegate: router.routerDelegate,
        routeInformationProvider: router.routeInformationProvider,
      
            
       
      ),
    );
  }
}