
import 'package:flutter_shopping_app/screens/login_web/home_web_screen.dart';
import 'package:flutter_shopping_app/screens/login_web/login_web_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

  

final GoRouter router = GoRouter(
  initialLocation: "/login",
  routes: <GoRoute>[
  GoRoute(
  path: "/login",
  builder: (context,state){
   
    return  const  LoginWebScreen();
  }
  ),
  GoRoute(
  path: "/home",
  builder: (context,state){
   
    return  const  HomeWebScreen();
  }
  ),
 
],
redirect: (context,state) async {
  print(state.fullPath);


  final SharedPreferences prefs = await SharedPreferences.getInstance();
        final String? token = prefs.getString('token');
        final bool loggedIn = token != null;
        print("token checking");
        print(token);
        if(loggedIn){
          return "/home";
        }
        else{
          return "/login";
        }

        
}
);