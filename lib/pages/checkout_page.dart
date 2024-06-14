import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:trendify/services/repository/user_cart_repository.dart';
import 'package:trendify/widgets/style_components.dart';
import 'package:get/get.dart';
import 'package:trendify/state_management/reactive_user_cart.dart';
import 'package:trendify/widgets/widget_components.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  UserCartRepository userCartRepository = UserCartRepository();
  final ReactiveUserCart reactiveUserCart = Get.put(ReactiveUserCart());
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchCartItem();
  }

  _fetchCartItem() async{
    await userCartRepository.getUserCartItem();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorComponents.primaryColor,
        title: const Text("Checkout", style: FontStyleComponents.heading2,),
        centerTitle: true,
      ),
      body: Obx(
        () => reactiveUserCart.isUserCartFetched.value ? 
        reactiveUserCart.isUserCartHasData.value ?  
        ListView.builder(
          itemCount: reactiveUserCart.userCartDetailedList.length,
          itemBuilder: (context, index){
            return Container(
                width: double.infinity,
                height: 120,
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 12),
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: ColorComponents.whiteColor
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AspectRatio(
                      aspectRatio: 1.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CachedNetworkImage(
                          imageUrl: reactiveUserCart.userCartDetailedList[index]['image'],
                          fit: BoxFit.cover,
                        )
                      ),
                    ),
                    const SizedBox(width: 12,),
  
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(reactiveUserCart.userCartDetailedList[index]['title'], style: FontStyleComponents.bodyBold, overflow: TextOverflow.fade, softWrap: true,),
                      
                          Text('Quantity: ${reactiveUserCart.userCart[index]['quantity'].toString()}', style: FontStyleComponents.body),
                      
                          Text('Price: ${FontStyleComponents.indianRupee}${reactiveUserCart.userCartDetailedList[index]['price'].toString()}', style: FontStyleComponents.body,)
                        ],
                      ),
                    ),
  
                    IconButton(
                      onPressed: () async {

                      },
                      icon: const Icon(Icons.close, size: 24, color: ColorComponents.blackColor,)
                    )
                  ],
                )
              );
          }
        )
        : 
        const Center(child: Text("An Exception Occur", style: FontStyleComponents.bodyBold,)) : 
        Center(child: WidgetComponents.loading(ColorComponents.blackColor),)
      ),

      bottomNavigationBar: BottomAppBar(
        color: ColorComponents.primaryColor,
        elevation: 0,
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
                myStateFunc((){
                  isLoading = true;
                });

                await Future.delayed(const Duration(seconds: 2));

                myStateFunc((){
                  isLoading = false;
                });

              },
              child: isLoading ? WidgetComponents.loading(ColorComponents.whiteColor) : const Text("Checkout", style: FontStyleComponents.bodySmallBold,),
            );
          }
        )
      ),
    );
  }
}