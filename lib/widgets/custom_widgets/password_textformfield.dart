import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../utility/custom_validators.dart';

class PasswordTextFormField extends StatefulWidget {
  const PasswordTextFormField({
    required TextEditingController controller,
    required this.validator,
    this.textInputAction = TextInputAction.done,
    this.hint = 'Password',
    Key? key,
  })  : _controller = controller,
        super(key: key);
  final TextEditingController _controller;
  final TextInputAction? textInputAction;
  final String hint;
  final String? Function(String? value)? validator;
  @override
  PasswordTextFormFieldState createState() => PasswordTextFormFieldState();
}

class PasswordTextFormFieldState extends State<PasswordTextFormField> {
  bool _notVisible = true;
  void _onListener() => setState(() {});
  @override
  void initState() {
    widget._controller.addListener(_onListener);
    super.initState();
  }

  @override
  void dispose() {
    widget._controller.removeListener(_onListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget._controller,
      obscureText: _notVisible,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: widget.textInputAction,
      cursorColor: Theme.of(context).colorScheme.secondary,
      validator: widget.validator ??
          (String? value) => CustomValidator.password(value),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        hintText: widget.hint,
        suffixIcon: IconButton(
          onPressed: () => setState(() {
            _notVisible = !_notVisible;
          }),
          splashRadius: 16,
          icon: (_notVisible == true)
              ? const Icon(CupertinoIcons.eye)
              : const Icon(CupertinoIcons.eye_slash),
        ),
        focusColor: Theme.of(context).primaryColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }
}
