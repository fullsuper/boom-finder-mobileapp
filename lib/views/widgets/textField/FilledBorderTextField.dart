import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FilledBorderTextField extends StatelessWidget {
  TextEditingController textEditingController;
  String hintText;
  double verticalPadding, horizontalPadding;
  int lines;
  Color fill;
  TextInputType type;
  Icon suffixIcon;
  Function onPressSuffixIcon, onSave;
  bool isPassword;
  Function(String) validator;

  FilledBorderTextField(
      {this.textEditingController,
      this.hintText,
      this.horizontalPadding = 10,
      this.verticalPadding = 20,
      this.fill,
      this.lines = 1,
      this.type = TextInputType.text,
      this.suffixIcon,
      this.isPassword = false,
      this.onPressSuffixIcon,
      this.validator,
      this.onSave});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        onSaved: onSave,
        validator: validator,
        obscureText: this.isPassword,
        controller: this.textEditingController,
        keyboardType: this.type,
        maxLines: this.lines,
        minLines: this.lines,
        textAlign: TextAlign.left,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: this.horizontalPadding,
            horizontal: this.verticalPadding,
          ),
          hintText: this.hintText,
          hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: this.type == TextInputType.multiline ? 30 : 15),
          alignLabelWithHint: true,
          fillColor: this.fill,
          filled: this.fill != null,
          suffixIcon: suffixIcon!= null ? IconButton(icon: this.suffixIcon, onPressed: this.onPressSuffixIcon,) : null
        ),
        style: TextStyle(color: Colors.black, fontSize: 18),
      ),
    );
  }
}
