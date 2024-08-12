import 'dart:convert';
import 'dart:developer';
import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shopping_app/bloc/authentication/authentication_bloc.dart';
import 'package:flutter_shopping_app/bloc/authentication/authentication_event.dart';
import 'package:flutter_shopping_app/bloc/authentication/authentication_state.dart';
import 'package:flutter_shopping_app/common_widgets/common_button.dart';
import 'package:flutter_shopping_app/toast_message.dart';
import 'package:flutter_shopping_app/utils/color_constants.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginWebScreen extends StatefulWidget {
  const LoginWebScreen({super.key});

  @override
  State<LoginWebScreen> createState() => _LoginWebScreenState();
}

class _LoginWebScreenState extends State<LoginWebScreen> {
  late TextEditingController _passwordController;
  late TextEditingController _emailController;
  late FocusNode usernameFocusNode;
  late FocusNode passwordFocusNode;
  late ValueNotifier obsecurePassword;
  
  final _formKey = GlobalKey<FormState>();



  @override
  void initState() {
    _passwordController = TextEditingController();
    _emailController =    TextEditingController();
    usernameFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
   
    obsecurePassword = ValueNotifier(true);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      backgroundColor: ColorConstants().lightBackGroundColor,
      body:   Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Login",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                 TextFormField(
        key: const Key('emailField'),
        controller: _emailController,
        decoration: const InputDecoration(
          hintText: "Username",
          labelText: "Enter Username",
          prefixIcon: Icon(
            Icons.email,
            size: 28,
          ),
        ),
        cursorColor: Colors.black,
        onFieldSubmitted: (v) {
          FocusScope.of(context).requestFocus(passwordFocusNode);
        },
        validator: (v){
          if(v== null || v.isEmpty){
            return "Please enter a email";
          }
          return null;
        },
      ),

      const SizedBox(
        height: 10,
      ),
      

      ValueListenableBuilder(
          valueListenable: obsecurePassword,
          builder: ((context, value, child) {
            return TextFormField(
              key: const Key('passwordField'),
              controller: _passwordController,
              obscureText: obsecurePassword.value,
              decoration: InputDecoration(
                  hintText: "Password",
                  labelText: "Enter Password",
                  isDense: true,
                  prefixIcon: const Icon(
                    Icons.lock,
                    size: 28,
                  ),
                  suffixIcon: GestureDetector(
                      onTap: () {
                        obsecurePassword.value = !obsecurePassword.value;
                      },
                      child: obsecurePassword.value
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility))),
              cursorColor: Colors.black,
              onFieldSubmitted: (v) {
                FocusScope.of(context).requestFocus(passwordFocusNode);
              },
               validator: (v){
          if(v== null || v.isEmpty || v.length<5){
            return  v!.isEmpty ?  "Please enter password": v.length<5 ? "please enter 6 digit password" : "Please enter password";
          }
          return null;
        },
            );
          })),
                     const  SizedBox(
                        height: 20,
                      ),
                  SizedBox(
                  width: double.infinity,
                  child: CommonButton(childWidget: const Text("Login", style: TextStyle(color: Colors.white),), onTap:(){
                    if(_formKey.currentState!.validate()){
                      log("check");
                     loginUser(_emailController.text, _passwordController.text , context);
                     
                    }
                  }) )
                ],
              ),
            ),
          ),
        )
    );
  }
    
  }



Future<void> loginUser(String userName, String passwordValue, BuildContext context ) async {
   String apiUrl = 'https://fakestoreapi.com/auth/login';
   String username =  userName;
   String password =  passwordValue;
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data['token'];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      await prefs.setString("username", username);
      context.go("/home");
      print('Token stored: $token');

     
     
    } else {
      print('Login failed: ${response.body}');
    }
  }