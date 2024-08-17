import 'package:pcnc/widgets/build_input_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatefulWidget {
  final void Function(String?)? onSaved;
  final String? Function(String?) validator;
  final String labelText;
  final IconData icon;
  final bool isPasswordField;
  final TextInputType keyboardType;
  final String? trailingText;
  final TextEditingController? controller;

  const CustomTextFormField({
    this.onSaved,
    required this.validator,
    required this.labelText,
    required this.icon,
    this.isPasswordField = false,
    this.keyboardType = TextInputType.text,
    this.trailingText, 
    this.controller,
    super.key,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool hidden = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.isPasswordField ? hidden : false,
      cursorColor: Theme.of(context).colorScheme.surface,
      style: TextStyle(
        color: Theme.of(context).colorScheme.surface,
        fontSize: 16.sp,
      ),
      textAlign: TextAlign.start,
      keyboardType: widget.keyboardType,
      decoration: widget.isPasswordField
          ?  buildInputDecoration(
              context,
              widget.labelText,
              widget.icon,
            ).copyWith(
              filled: true,
              fillColor: Theme.of(context).colorScheme.primary,
              suffixIcon: IconButton(
                icon: hidden
                    ? Icon(
                        Icons.visibility_off,
                        color: Theme.of(context).iconTheme.color,
                        size: 16.dm,
                      )
                    : Icon(
                        Icons.visibility,
                        color: Theme.of(context).iconTheme.color,
                        size: 16.dm,
                      ),
                onPressed: () => setState(() => hidden = !hidden),
              ),
            )
          : buildInputDecoration(
              context,
              widget.labelText,
              widget.icon,
                ).copyWith(
              filled: true,
              fillColor:Theme.of(context).colorScheme.primary,
              suffix: Text(widget.trailingText ?? ''),
            ),
      validator: widget.validator,
      onSaved: widget.onSaved,
      controller: widget.controller,
      
    );
  }
}