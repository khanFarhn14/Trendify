import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trendify/cache/cache_storage.dart';
import 'package:trendify/providers/provider_products_list.dart';
import 'package:trendify/resources.dart';
import 'package:trendify/routes/routes.dart';
import 'package:trendify/routes/routes_name.dart';
import 'package:trendify/widgets/style_components.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await checkUserLoggedInStatus();
  runApp(const MyApp());
}

bool _isLoggedIn = false;

Future<void> checkUserLoggedInStatus() async {
  await LocalStorage.getUserLoggedInStatus().then((value){
    if(value != null){
      clearPrint("Is user logged in $value");
        _isLoggedIn = value;
    }
  });

  clearPrint("Checking logged in status after checking $_isLoggedIn");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductList())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorSchemeSeed: ColorComponents.blackColor,
          scaffoldBackgroundColor: ColorComponents.primaryColor,
          textTheme: Theme.of(context).textTheme.apply(
            bodyColor: ColorComponents.blackColor,
          ),

          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(            
              backgroundColor: ColorComponents.blackColor,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              shadowColor: ColorComponents.black40LightColor,
            )
          ),
          bottomAppBarTheme: const BottomAppBarTheme(color: ColorComponents.primaryColor)        
        ),
        // home: const LoginPage(),
        initialRoute: _isLoggedIn ? RouteName.home : RouteName.login,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
