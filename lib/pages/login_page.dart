// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:trendify/cache/cache_storage.dart';
import 'package:trendify/resources.dart';
import 'package:trendify/routes/routes_name.dart';
import 'package:trendify/services/repository/auth_repository.dart';
import 'package:trendify/widgets/style_components.dart';
import 'package:trendify/widgets/widget_components.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final usernameRegex = RegExp(r'^[a-zA-Z][a-zA-Z0-9_-]{2,14}$');
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FocusNode userNameFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  AuthRepository authRepository = AuthRepository();

  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    userNameFocusNode.dispose();
    passwordFocusNode.dispose();
    userNameController.dispose();
    passwordController.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: ColorComponents.primaryColor,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(ImageResources.loginPageIllustration, width: screenWidth, height: 310,),
          
              WidgetComponents.height(height: 12),
          
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text("Welcome to Trendify", style: FontStyleComponents.heading2,),
              ),
          
              WidgetComponents.height(height: 24),
          
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text("Login to access your account", style: FontStyleComponents.bodyLarge,),
              ),
          
              WidgetComponents.height(height: 12),

              // Username Field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
                  controller: userNameController,
                  
                  onFieldSubmitted: (value) => WidgetComponents.textFieldFocusShift(context, userNameFocusNode, passwordFocusNode),
                  style: FontStyleComponents.bodyBold,
                  cursorColor: ColorComponents.blackColor,
                  keyboardType: TextInputType.name,
                  decoration: WidgetComponents.inputDecoration(hintText: 'username'),
                  textInputAction: TextInputAction.done,
                  validator: (value){
                    if(value!.isEmpty){
                      return 'Please enter your username';
                    }
                    if(!usernameRegex.hasMatch(value)){
                      return 'Please enter a valid username';
                    }
                    return null;
                  },
                ),
              ),
          
              WidgetComponents.height(height: 16),

              // Password Field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
                  controller: passwordController,
                  focusNode: passwordFocusNode,
                  
                  style: FontStyleComponents.bodyBold,
                  cursorColor: ColorComponents.blackColor,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: WidgetComponents.inputDecoration(hintText: 'password'),
                  textInputAction: TextInputAction.done,
                  validator: (value){
                    if(value!.isEmpty){
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: ColorComponents.primaryColor,

        child: StatefulBuilder(
          builder: (context, myStateFunc) {
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorComponents.blackColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0)
                )
              ),
              onPressed: () async {
                if(_formKey.currentState!.validate()) {
                  dynamic data = {
                    "username": userNameController.text,
                    "password": passwordController.text,
                  };

                  myStateFunc((){
                    isLoading = true;
                  });
            
                  if(await authRepository.login(data: data, context: context)){
                    // Saving session
                    LocalStorage.saveUserLoggedInStatus(true);
                    Navigator.pushNamedAndRemoveUntil(context, RouteName.home, (route) => false);

                  }

                  myStateFunc((){
                    isLoading = false;
                  });
                }
              },
              child: isLoading ? WidgetComponents.loading(ColorComponents.primaryColor) : const Text("Login", style: FontStyleComponents.bodySmallBold,),
            );
          }
        ),

      ),
    );
  }
}