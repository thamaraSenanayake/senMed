import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDropDown extends StatefulWidget {
  final String? value;
  final List<String> valueList;
  final Function(String) onChange;
  final double? width;
  final String? hint;
  final String errorText;
  const CustomDropDown({Key? key,this.errorText="", this.hint, this.width, required this.value, required this.valueList, required this.onChange}) : super(key: key);

    @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  String? _selectItem;

  @override
  void initState() {
    super.initState();
    _selectItem = widget.value;
  }
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Container(
      width: widget.width??_size.width,
      height: 45,
      padding:const EdgeInsets.only(
        left:20,
        right:20
      ),
      decoration: BoxDecoration(
        color:  Colors.white,
        borderRadius: BorderRadius.circular(5),
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
      ),
      child:DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectItem,
          icon: Icon(Icons.keyboard_arrow_down),
          iconEnabledColor:Color(0xff777777),
          onChanged: (String? newValue) async {
            widget.onChange(newValue!);
            setState(() {
              _selectItem = newValue;
            });
          },
          hint: widget.hint!= null?Text(
                widget.hint!,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                  color: const Color(0xff777777)
                ),
              ):null,
          items: widget.valueList.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                  color: const Color(0xff777777)
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}