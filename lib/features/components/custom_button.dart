import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomButton extends StatelessWidget {
  final Function()? onTap;
  final String buttonText;
  const CustomButton({super.key,required this.buttonText, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.screenWidth,
      height: 44,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape:const StadiumBorder(),
          backgroundColor:const Color.fromARGB(255, 244, 245, 245),
        ),
        onPressed: onTap,
        child: buttonText.text.make(),
        
      ),
    );
  }
}