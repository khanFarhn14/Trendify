import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:trendify/widgets/style_components.dart';
import 'package:trendify/widgets/widget_components.dart';

class ProductDescriptionPage extends StatelessWidget {
  final String title, imageUrl ,category, description;
  final dynamic price, rate;
  const ProductDescriptionPage({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.category,
    required this.description,
    required this.price,
    required this.rate
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: ColorComponents.whiteColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WidgetComponents.height(height: 52),

            // ---------- Image ----------
            Center(
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                width: double.infinity,
                height: 268,
                fit: BoxFit.contain,
              ),
            ),

            WidgetComponents.height(height: 24),

            // ---------- Title ----------
            Text(title, style: FontStyleComponents.interBodyLarge,),

            WidgetComponents.height(height: 12),

            // ---------- Category ----------
            Text.rich(
              TextSpan(
                text: 'Category: ',
                style: FontStyleComponents.body.copyWith(color: ColorComponents.black40LightColor),
                children: [
                  TextSpan(
                    text: category.toUpperCase(),
                    style: FontStyleComponents.bodyBold
                  )
                ]
              )
            ),

            WidgetComponents.height(height: 12),

            // ---------- Description ----------
            Text("Description", style: FontStyleComponents.body.copyWith(color: ColorComponents.black40LightColor)),

            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: ColorComponents.white10DarkColor,
                )
              ),

              child: Text(description, style: FontStyleComponents.body),
            ),

            WidgetComponents.height(height: 12),

            // ---------- MRP ----------
            Text.rich(
              TextSpan(
                text: 'MRP: ',
                style: FontStyleComponents.body.copyWith(color: ColorComponents.black40LightColor),
                children: [
                  TextSpan(
                    text: '${FontStyleComponents.indianRupee}${price.toString()}',
                    style: FontStyleComponents.bodyBold
                  )
                ]
              )
            ),

            WidgetComponents.height(height: 12),

            // ---------- Rate ----------
            Text.rich(
              TextSpan(
                text: 'Rating: ',
                style: FontStyleComponents.body.copyWith(color: ColorComponents.black40LightColor),
                children: [
                  TextSpan(
                    text: rate.toString(),
                    style: FontStyleComponents.bodyBold
                  )
                ]
              )
            ),
          ],
        ),
      ),

      bottomNavigationBar: BottomAppBar(
        color: ColorComponents.whiteColor,
        elevation: 0,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorComponents.blackColor,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0)
            )
          ),
          onPressed: () async {},
          child: const Text("Add to Cart", style: FontStyleComponents.bodySmallBold,),
        )
      ),
    );
  }
}