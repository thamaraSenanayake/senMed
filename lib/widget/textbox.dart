import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../res.dart';



class CustomTextBox extends StatefulWidget {
  final String? textBoxHint;
  final String? initText;
  final Widget? leftIcon;
  final IconData? rightIcon;
  final Function(String) onChange;
  final Function(String)? onSubmit;
  final Function()? onEditingComplete;
  final bool obscureText;
  final TextInputType textInputType;
  final TextEditingController? textEditingController;
  final String errorText;
  final FocusNode? focusNode;
  // final bool shadow;
  final int? maxLength;
  final double width;
  final double height;
  final double fontSize;
  final bool enable;
  final Color? borderColor;
  final String? Function(String?)? validator;
  const CustomTextBox({
    Key? key,
    this.onEditingComplete,
    this.enable = true,
    required this.onChange,
    this.borderColor,
    this.leftIcon,
    this.rightIcon,
    this.fontSize=15,
    this.textBoxHint,
    this.obscureText = false,
    this.textInputType = TextInputType.text,
    this.onSubmit,
    this.initText,
    this.textEditingController,
    this.focusNode,
    this.height = 50,
    this.validator,
    // this.shadow = true,
    required this.errorText, 
    this.maxLength,

    required this.width, 
  }) : super(key: key);

  @override
  _TextBoxState createState() => _TextBoxState();
}

class _TextBoxState extends State<CustomTextBox> {
  late TextEditingController _controller;
  late final double _fontSize = widget.fontSize;
  late bool _obscureText;
  @override
  void initState() { 
    super.initState();
    _obscureText = widget.obscureText;
    _controller = widget.textEditingController?? TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {     

      if(widget.initText != null){
        _controller.text = widget.initText!;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        width: widget.width,
        constraints:widget.textInputType == TextInputType.multiline? const BoxConstraints(
          minHeight:  71,
        ):BoxConstraints(
          maxHeight:  widget.height,
        ),
        height: 48,
        padding:const EdgeInsets.only(
          left: 10 ,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.15)),
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.15),
              blurRadius: 11.0,
              spreadRadius: 0.0,
              offset: Offset(
                0.0,
                3.0,
              ),
            )
          ],
          
          border: Border.all(
            color: widget.errorText.isEmpty?
                    (Colors.transparent):
                    Colors.redAccent,
            width:(1)
          ),
          borderRadius: BorderRadius.circular(4),
          
          
        ),
        child: Row(
          // mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment:widget.textInputType == TextInputType.multiline? CrossAxisAlignment.start: CrossAxisAlignment.center,
          children: [

            if(widget.leftIcon != null)
            widget.leftIcon!,
            
            Expanded(
              child: Focus(
                onFocusChange: (hasFocus) {
                  if(!hasFocus){
                    if(widget.onEditingComplete != null){
                      widget.onEditingComplete!();
                    }
                  }
                },
                child: TextField(
                  enabled: widget.enable,
                  cursorColor: Colors.black,
                  scrollPadding: EdgeInsets.all(0),
                  
                  style: GoogleFonts.poppins(
                    color: Colors.black, 
                    fontSize: 14,
                    fontWeight:FontWeight.w400
                  ),
                  focusNode: widget.focusNode,
                  controller:_controller,
                  decoration: InputDecoration(
                    
                    counterText: "",
                    border: InputBorder.none,
                    hintText: widget.textBoxHint,
                    isDense: true,
                    hintStyle:GoogleFonts.poppins(
                      fontSize:13, 
                      color: Colors.grey, 
                      fontWeight: FontWeight.w500,
                      // height: 1.5
                    ),
                  ),
                  maxLines: widget.textInputType == TextInputType.multiline?null:1,
                  obscureText: _obscureText,
                  keyboardType: widget.textInputType,
                  // validator: widget.validator,
                  onChanged: (value) {
                    widget.onChange(value.trim());
                  },
                  onSubmitted: (value) {
                    if(widget.onSubmit != null){
                      widget.onSubmit!(value.trim());
                    }
                  },
                  maxLength: widget.maxLength,
                  // maxLengthEnforced: true,
                ),
              ),
            ),

            if(widget.rightIcon != null)
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Icon(widget.rightIcon,
                  color: AppColors.thirdColor),
            ), 

            
            if(widget.obscureText)
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  child: Icon(
                    _obscureText? Icons.visibility_off:Icons.visibility,
                    color:_obscureText? Colors.grey:AppColors.thirdColor
                  ),
                ),
              )
            
          ],
        ),
      ),
    );
  }
}
