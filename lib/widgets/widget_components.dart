import 'package:flutter/material.dart';
import 'package:trendify/widgets/style_components.dart';

class WidgetComponents{
  static Widget height({required double height}){
    return SizedBox(height: height,);
  }

  static InputDecoration inputDecoration({required String hintText}) => InputDecoration(
    hintText: hintText,
    hintStyle: FontStyleComponents.bodySmall.copyWith(color: ColorComponents.black40LightColor),
    
    prefixIconColor: ColorComponents.blackColor,

    fillColor: ColorComponents.whiteForInputField,
    filled: true,

    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(0),
      borderSide: BorderSide.none
    ),

    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(0),
      borderSide: const BorderSide(color: ColorComponents.blackColor, width: 1.5)
    ),

    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(0.0),
      borderSide: BorderSide.none,
    ),

    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(0.0),
      borderSide: const BorderSide
      (
        color: ColorComponents.errorColor,
        width: 1.5
      )
    ),
  );

  static InputDecoration inputDecorationForSearch({required String hintText}) => InputDecoration(
    hintText: hintText,
    hintStyle: FontStyleComponents.bodySmall.copyWith(color: ColorComponents.black40LightColor),
    
    prefixIconColor: ColorComponents.blackColor,

    fillColor: ColorComponents.whiteForInputField,
    filled: true,

    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(0),
      borderSide: BorderSide.none
    ),

    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(0),
      borderSide: BorderSide.none
    ),

    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(0.0),
      borderSide: BorderSide.none,
    ),

    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(0.0),
      borderSide: const BorderSide
      (
        color: ColorComponents.errorColor,
        width: 1.5
      )
    ),
  );

  static void textFieldFocusShift(BuildContext context, FocusNode currentFocus, FocusNode nextFocus){
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  // Snackbar for error
  static void showSnackBarForFeedback({required BuildContext cntxt, required String message, required bool isError})
  {
    ScaffoldMessenger.of(cntxt).showSnackBar(

      SnackBar(
        duration: const Duration(milliseconds: 800),
        behavior: SnackBarBehavior.floating,
        elevation: 0,
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        backgroundColor: ColorComponents.black40LightColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8)
        ),
        content: Row(
          children: [
            isError ? const Icon(Icons.error_outline_rounded, color: ColorComponents.errorColor,size: 24,):
            const Icon(Icons.done, color: ColorComponents.successColor,size: 24,),
            const SizedBox(width: 12,),
            Text(
              message,
              style: FontStyleComponents.body.copyWith(color: ColorComponents.whiteColor),
              textAlign: TextAlign.start,
            ),
          ],
        ),
        action: SnackBarAction
        (
          label: "Ok",
          onPressed: (){},
          textColor: ColorComponents.whiteColor,
        ),
      )
    );
  }

   // Loading
  static Widget loading(Color color) => SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: color, strokeWidth: 1),);
}