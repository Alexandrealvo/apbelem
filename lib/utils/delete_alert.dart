import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

deleteAlert(context, String text, VoidCallback function) {
  Alert(
    image: Icon(
      Icons.highlight_off,
      color: Colors.yellowAccent,
      size: 60,
    ),
    style: AlertStyle(
      backgroundColor: Theme.of(context).textSelectionTheme.selectionColor,
      animationType: AnimationType.fromTop,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      //descStyle: GoogleFonts.poppins(color: Colors.red,),
      animationDuration: Duration(milliseconds: 300),
      titleStyle: GoogleFonts.poppins(
        color: Theme.of(context).errorColor,
        fontSize: 18,
      ),
    ),
    context: context,
    title: text,
    buttons: [
      DialogButton(
        child: Text(
          "Cancelar",
          style: GoogleFonts.montserrat(
            color: Theme.of(context).textSelectionTheme.selectionColor,
            fontSize: 18,
          ),
        ),
        onPressed: () {
          Get.back();
        },
        width: 80,
        color: Theme.of(context).errorColor,
      ),
      DialogButton(
        child: Text(
          "OK",
          style: GoogleFonts.montserrat(
            color: Theme.of(context).textSelectionTheme.selectionColor,
            fontSize: 18,
          ),
        ),
        onPressed: function,
        width: 80,
        color: Theme.of(context).primaryColor,
      )
    ],
  ).show();
}
