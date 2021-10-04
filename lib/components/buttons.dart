import 'package:flutter/material.dart';



class DefaultButton extends StatelessWidget {

  final String text;
  final Function action;
  final fontSize;
  final double width;



  DefaultButton({this.text, this.action,this.fontSize,this.width=double.infinity});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: ElevatedButton(
          onPressed: action,
          child: Text(text,style: TextStyle(
              fontSize: fontSize
          ),)
      ),
    );
  }
}


class DefaultTextButton extends StatelessWidget {

  final String text;
  final Function action;


  DefaultTextButton({this.text, this.action});

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: action, child: Text(text));
  }
}
