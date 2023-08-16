import 'package:flutter/material.dart';

Container customIconContainer ({final double? height,final double? width,final IconData? icon,final Function()? onTap}){
  return Container(
    alignment: Alignment.center,
    height: height,
    width: width,
    decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        shape: BoxShape.circle
    ),
    child: IconButton(onPressed: onTap, icon: Icon(icon,color: Colors.black),)
  );


}