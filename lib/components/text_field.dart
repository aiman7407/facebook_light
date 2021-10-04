import 'package:flutter/material.dart';

import 'package:flutter/material.dart';






Widget defaultFormField({
  @required TextEditingController controller,
  @required TextInputType textInputType,
  Function onSubmited,
  bool obscureText=false,
  Function onChanged,
  IconData suffix,
  Function suffixAction,
  @required Function validate,
  Function onTab,
  @required String label,
  @required IconData prefixIcon,
  bool isEnabled=true
})=> TextFormField(
  obscureText: obscureText,
  controller: controller,
  keyboardType: textInputType,
  onFieldSubmitted: onSubmited,
  onChanged: onChanged,
  validator:validate ,
  onTap: onTab,
  enabled: isEnabled,
  decoration: InputDecoration(
    suffixIcon: IconButton(
        icon: Icon(suffix),
        onPressed: suffixAction ,
    ),

      labelText: label,
      prefixIcon: Icon(prefixIcon),
      border: OutlineInputBorder()
  ),

);