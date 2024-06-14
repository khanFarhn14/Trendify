import 'package:flutter/material.dart';
import 'package:trendify/pages/home_page.dart';
import 'package:trendify/pages/login_page.dart';
import 'package:trendify/routes/routes_name.dart';

class Routes{
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){

      case RouteName.login:
        return MaterialPageRoute(
          builder: (context) => const LoginPage()
        );

      // case RouteName.productDescription:
      //   return PageRouteBuilder(
      //     pageBuilder: (context, animation, secondaryAnimation) => const ProductDescriptionPage(),
      //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
      //       return SlideTransition(
      //         position: Tween<Offset>(
      //           begin: const Offset(1, 0),
      //           end: Offset.zero,
      //         ).animate(animation),
      //         child: child
      //       );
      //     },
      //   );
      
      case RouteName.home:
        return MaterialPageRoute(builder: (context) => const HomePage());

      default: return MaterialPageRoute(
        builder: (context){
          return const Scaffold(
            body: Center(
              child: Text('No Route Defined'),
            ),
          );
        }
      );
    }
  }
}