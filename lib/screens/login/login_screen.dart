import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shopping_app/bloc/authentication/authentication_bloc.dart';
import 'package:flutter_shopping_app/bloc/authentication/authentication_event.dart';
import 'package:flutter_shopping_app/bloc/authentication/authentication_state.dart';
import 'package:flutter_shopping_app/common_widgets/common_button.dart';
import 'package:flutter_shopping_app/toast_message.dart';
import 'package:flutter_shopping_app/utils/color_constants.dart';
import 'package:go_router/go_router.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _passwordController;
  late TextEditingController _emailController;
  late FocusNode usernameFocusNode;
  late FocusNode passwordFocusNode;
  late ValueNotifier obsecurePassword;
   late final AuthenticationBloc authenticationBloc;
  final _formKey = GlobalKey<FormState>();



  @override
  void initState() {
    _passwordController = TextEditingController();
    _emailController =    TextEditingController();
    usernameFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    obsecurePassword = ValueNotifier(true);
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      backgroundColor: ColorConstants().lightBackGroundColor,
      body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
         bloc: authenticationBloc,
        listener: (context, state) {
          if(state is AuthenticationLoadedState){
            context.go("/home");
          }
         else if(state is AuthenticationFailureState){
            ToastMessage.showError(state.messaage);
          }
        
         
        },
        builder: (context, state) {
          return  Center(
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
                  _authenticationForm(
                      _emailController,
                      _passwordController,
                      context,
                      usernameFocusNode,
                      passwordFocusNode,
                      state,
                      obsecurePassword),
                     const  SizedBox(
                        height: 20,
                      ),
                  SizedBox(
                  width: double.infinity,
                  child: CommonButton(childWidget: (state is AuthenticationLoadingState) ?  const  CircularProgressIndicator() : const Text("Login", style: TextStyle(color: Colors.white),), onTap:(){
                    if(_formKey.currentState!.validate()){
                      log("validate");
                      log(_emailController.text);
                      authenticationBloc.add(UserLoginEvent(email: _emailController.text, password: _passwordController.text));
                      
                    }
                  }) )
                ],
              ),
            ),
          ),
        );
  }
      ),
    );
  }
}

Widget _authenticationForm(
    TextEditingController emailController,
    TextEditingController passwordController,
    BuildContext context,
    FocusNode usernameFocusNode,
    FocusNode passwordFocusNode,
    AuthenticationState state, 
    ValueNotifier obsecurePassword) {
  return Column(
    children: [
      TextFormField(
        key: const Key('emailField'),
        controller: emailController,
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
              controller: passwordController,
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

    ],
  );
}
