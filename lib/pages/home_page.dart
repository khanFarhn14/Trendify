// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trendify/cache/cache_storage.dart';
import 'package:trendify/pages/product_description_page.dart';
import 'package:trendify/resources.dart';
import 'package:trendify/routes/routes_name.dart';
import 'package:trendify/services/repository/products_repository.dart';
import 'package:trendify/state_management/reactive_products_list.dart';
import 'package:trendify/state_management/reactive_user_cart.dart';
import 'package:trendify/widgets/style_components.dart';
import 'package:trendify/widgets/widget_components.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();
  ProductsRepository productsRepository = ProductsRepository();
  final ReactiveProductList reactiveProductList = Get.put(ReactiveProductList());
  final ReactiveUserCart reactiveUserCart = Get.put(ReactiveUserCart());

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    await productsRepository.getAllProducts();
  }

  Future<void> _sortProducts() async {
    await productsRepository.sortProducts();
  }

  Future<void> _getCategories() async {
    await productsRepository.getCategory();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            WidgetComponents.height(height: 52),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Experience\nThe Trends", style: FontStyleComponents.heading2,),

                Row(
                  children: [

                    IconButton(
                      onPressed: () => _fetchProducts(),
                      icon: const Icon(Icons.filter_alt_off_outlined, size: 24,)
                    ),

                    Stack(
                        clipBehavior: Clip.none,
                        children: [
                          // const ImageIcon(AssetImage(IconsResources.iconCart), size: 24,),
                          IconButton(
                            onPressed: (){
                              Navigator.pushNamed(context, RouteName.checkout);
                            },
                            icon: const ImageIcon(AssetImage(IconsResources.iconCart), size: 24,)
                          ),
                          Positioned(
                            top: 5,
                            right: 5,
                            child: Container(
                              alignment: Alignment.center,
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                color: ColorComponents.blackColor,
                                borderRadius: BorderRadius.circular(50)
                              ),
                              child: Obx(() =>Text(reactiveUserCart.numberOfCartItems.toString(), style: FontStyleComponents.bodySmallBold.copyWith(color: ColorComponents.whiteColor),)),
                            )
                          )
                        ],
                      ),


                    MenuAnchor(
                      style: MenuStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(const Color(0xff333333).withOpacity(0.8)),
                        padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.symmetric(horizontal: 12)),
                        fixedSize: MaterialStateProperty.all<Size>(const Size.fromWidth(158))

                      ),
                      builder: (BuildContext context, MenuController controller, Widget? child){
                        return IconButton(
                          onPressed: () {
                            if (controller.isOpen) {
                              controller.close();
                            } else {
                              controller.open();
                            }
                          },

                          icon: const ImageIcon(AssetImage(IconsResources.iconOption), size: 24,)
                        );
                      },

                      menuChildren: [
                        InkWell(
                          onTap: (){
                            _sortProducts();
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Filter", style: FontStyleComponents.body.copyWith(color: ColorComponents.primaryColor),),
                                const SizedBox(width: 58,),
                                const ImageIcon(AssetImage(IconsResources.iconFilter), size: 20, color: ColorComponents.primaryColor,)
                              ],
                            ),
                          ),
                        ),

                        const Divider(color: ColorComponents.white10DarkColor,),

                        InkWell(
                          onTap: () {
                            _getCategories();
                            bottomSheet();

                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Sort", style: FontStyleComponents.body.copyWith(color: ColorComponents.primaryColor),),
                                const SizedBox(width: 58,),
                                const ImageIcon(AssetImage(IconsResources.iconSort), size: 20, color: ColorComponents.primaryColor,)
                              ],
                            ),
                          ),
                        ),

                        const Divider(color: ColorComponents.white10DarkColor,),

                        InkWell(
                          onTap: () {
                            LocalStorage.saveUserLoggedInStatus(false);
                            Navigator.pushNamedAndRemoveUntil(context, RouteName.login, (route) => false);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Log Out", style: FontStyleComponents.body.copyWith(color: ColorComponents.primaryColor),),
                                const SizedBox(width: 58,),
                                const Icon(Icons.logout_outlined, size: 20, color: ColorComponents.primaryColor,)
                              ],
                            ),
                          ),
                        ),
                      ]
                    ),
                  ],
                )
              ],
            ),

            WidgetComponents.height(height: 24),

            Container(
              // width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              color: ColorComponents.whiteForInputField,
              child: Row(
                children: [
                  const ImageIcon(AssetImage(IconsResources.iconSearch), size: 24,),
                  
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      decoration: WidgetComponents.inputDecorationForSearch(hintText: 'search'),
                      style: FontStyleComponents.body,
                      cursorColor: ColorComponents.blackColor,
                    ),
                  ),

                  IconButton(
                    onPressed: (){
                      searchController.clear();
                    },
                    icon: const ImageIcon(AssetImage(IconsResources.iconCancel)),
                    iconSize: 24,
                  ),

                ],
              ),
            ),

            WidgetComponents.height(height: 24),

            Obx(
              // ---------- Is Data Fetched ? ----------
              ()=> reactiveProductList.isProductFetched.value ? 
              // ---------- Is Response has Data ? ----------
              reactiveProductList.isResponseHadData.value ?
              ProductListComponent(data: reactiveProductList.productList) :
              const Center(child: Text("An Exception occurred while fetching"),)
              : 
              Center(child: WidgetComponents.loading(ColorComponents.blackColor),),

            )
          ],
        ),
      ),
    );
  }

  void bottomSheet(){
    showModalBottomSheet(
      backgroundColor: ColorComponents.whiteColor,

      context: context,
      builder: (context){
        return Container(
          height: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0)
          ),
          child: Obx(() => reactiveProductList.categories.isEmpty ? Center(child: WidgetComponents.loading(ColorComponents.blackColor)) :
          
          ListView.builder(
            itemCount: reactiveProductList.categories.length,
            itemBuilder: (context, index){
              return ListTile(
                title: Text(reactiveProductList.categories[index].toString().toUpperCase()),
                trailing: const ImageIcon(AssetImage(IconsResources.iconArrow)),
                onTap: () {
                  productsRepository.getSpecificCategory(reactiveProductList.categories[index]);
                  Navigator.pop(context);
                },
                // on
              );
            }
          ),
          ),
        );
      }
    );
  }
}

class ProductListComponent extends StatelessWidget {
  final List<dynamic> data;
  const ProductListComponent({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 12, top: 12),
        itemCount: data.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 14,
          crossAxisSpacing: 12,
          crossAxisCount: 2,
          mainAxisExtent: 334,
        ),
      
        itemBuilder: (context, index){
          return InkWell(
              onTap: (){
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) => ProductDescriptionPage(
                      title: data[index]['title'],
                      imageUrl: data[index]['image'],
                      category: data[index]['category'],
                      description: data[index]['description'],
                      price: data[index]['price'],
                      rate: data[index]['rating']['rate'],
                      
                    ),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(1, 0),
                          end: Offset.zero,
                        ).animate(animation),
                        child: child
                      );
                    },
                  )
                );
              },
              child: CardOfProducts(
              title: data[index]['title'],
              imageUrl: data[index]['image'],
              description: data[index]['description'],
              price: data[index]['price'],
            ),
          );
        }
      ),
    );
  }
}

class CardOfProducts extends StatelessWidget {
  final String title, imageUrl, description;
  final dynamic price;
  const CardOfProducts({super.key, required this.title,required this.imageUrl ,required this.description, required this.price});

  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    final ReactiveUserCart reactiveUserCart = Get.put(ReactiveUserCart());

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
      color: ColorComponents.whiteColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          SizedBox(
            width: double.infinity,
            child: Text(
              title,
              style: FontStyleComponents.bodyBold,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          // WidgetComponents.height(height: 12),

          Center(
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              height: 182,
              fit: BoxFit.cover,
            ),
          ),

          // WidgetComponents.height(height: 12),

          Text(
            description,
            style: FontStyleComponents.bodySmall,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),

          SizedBox(
            width: double.infinity,
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text('only ${FontStyleComponents.indianRupee}${price.toString()}',
                  style: FontStyleComponents.body,
                ),
            
                StatefulBuilder(
                  builder: (context, myStateFunc) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorComponents.whiteColor,
                        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                          side: const BorderSide(
                            color: ColorComponents.blackColor,
                          )
                        )
                      ),
                      onPressed: ()async{
                        myStateFunc((){
                          isLoading = true;
                        });

                        await Future.delayed(const Duration(seconds: 1));


                        myStateFunc((){
                          isLoading = false;
                        });

                        reactiveUserCart.numberOfCartItems.value++;
                        WidgetComponents.showSnackBarForFeedback(cntxt: context, message: "Added to cart", isError: false);
                        
                      },
                      child: isLoading ? WidgetComponents.loading(ColorComponents.blackColor) : Text('Add', style: FontStyleComponents.bodySmallBold.copyWith(color: ColorComponents.blackColor),)
                    );
                  }
                )
                
              ],
            ),
          )
        ],
      )
    );
  }
}