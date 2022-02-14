import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormFieldWithHeader extends StatefulWidget {
  const CustomTextFormFieldWithHeader({
    TextEditingController? controller,
    required this.headerText,
    this.keyboardType,
    this.onTap,
    this.textInputAction,
    this.onChanged,
    this.validator,
    this.initialValue,
    this.hint = '',
    this.color,
    this.contentPadding,
    this.headerPadding,
    this.minLines = 1,
    this.maxLines = 1,
    this.maxLength,
    this.showSuffixIcon = true,
    this.radius = 8,
    this.readOnly = false,
    this.inputFormatters,
    this.autoFocus = false,
    this.textAlign = TextAlign.start,
    this.style,
    this.border,
    this.starticon,
    this.endIcon,
    this.Boardercolor,
    this.gradientBorder,
    this.hintColor,
    Key? key,
  })  : _controller = controller,
        super(key: key);
  final TextEditingController? _controller;
  final TextInputType? keyboardType;
  final TextInputFormatter? inputFormatters;
  final TextInputAction? textInputAction;
  final void Function(String)? onChanged;
  final bool showSuffixIcon;
  final String? Function(String? value)? validator;
  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsets? headerPadding;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final Color? color;
  final Function()? onTap;
  final Color? Boardercolor;
  final double radius;
  final bool? gradientBorder;
  final String? initialValue;
  final String? hint;
  final bool readOnly;
  final bool autoFocus;
  final TextAlign textAlign;
  final InputBorder? border;
  final Color? hintColor;
  final String headerText;
  final TextStyle? style;
  final IconData? starticon;
  final String? endIcon;

  @override
  CustomTextFormFieldWithHeaderState createState() =>
      CustomTextFormFieldWithHeaderState();
}

class CustomTextFormFieldWithHeaderState
    extends State<CustomTextFormFieldWithHeader> {
  void _onListen() => setState(() {});

  @override
  void initState() {
    widget._controller!.addListener(_onListen);
    super.initState();
  }

  @override
  void dispose() {
    widget._controller!.removeListener(_onListen);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              widget.headerPadding ?? const EdgeInsets.symmetric(horizontal: 0),
          child: Text(
            widget.headerText,
            style: TextStyle(color: Colors.black, fontSize: 14),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          decoration: (widget.gradientBorder == true)
              ? BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(7.8)),
                )
              : null,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 1.4),
            padding: widget.contentPadding ??
                const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.radius),
              color: widget.color ?? Theme.of(context).secondaryHeaderColor,
              border: Border.all(color: widget.Boardercolor ?? Colors.grey),
            ),
            child: TextFormField(
              initialValue: widget.initialValue,
              controller: widget._controller,
              readOnly: widget.readOnly,
              onTap: (widget.onTap != null) ? widget.onTap : null,
              keyboardType: widget.keyboardType == TextInputType.number
                  ? const TextInputType.numberWithOptions(
                      signed: true, decimal: true)
                  : widget.maxLines! > 1
                      ? TextInputType.multiline
                      : widget.keyboardType ?? TextInputType.text,
              textInputAction: widget.maxLines! > 1
                  ? TextInputAction.newline
                  : widget.textInputAction ?? TextInputAction.next,
              autofocus: widget.autoFocus,
              textAlign: widget.textAlign,
              onChanged: widget.onChanged,
              minLines: widget.minLines,
              maxLines:
                  (widget._controller!.text.isEmpty) ? 1 : widget.maxLines,
              maxLength: widget.maxLength,
              style: widget.style,
              inputFormatters: (widget.inputFormatters != null)
                  ? [widget.inputFormatters!]
                  : [],
              validator: (String? value) => widget.validator!(value),
              cursorColor: Theme.of(context).colorScheme.secondary,
              decoration: InputDecoration(
                fillColor: widget.color ??
                    Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .color!
                        .withOpacity(0.15),
                hintText: widget.hint,
                hintStyle: widget.hint!.length > 15
                    ? TextStyle(
                        fontSize: 14, color: widget.hintColor ?? Colors.white)
                    : TextStyle(
                        fontSize: 15, color: widget.hintColor ?? Colors.white),
                suffixIcon: (widget.endIcon != null)
                    ? SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Image(
                            image: AssetImage(widget.endIcon!),
                            width: 0,
                            color: Colors.white.withOpacity(0.6),
                          ),
                        ),
                      )
                    : (widget._controller!.text.isEmpty ||
                            !widget.showSuffixIcon ||
                            widget.showSuffixIcon == false)
                        ? null
                        : IconButton(
                            splashRadius: 16,
                            onPressed: () => setState(() {
                              widget._controller!.clear();
                            }),
                            icon: const Icon(CupertinoIcons.clear,
                                size: 18, color: Colors.white38),
                          ),
                prefixIcon: widget.starticon == null
                    ? null
                    : SizedBox(
                        width: 40,
                        child: Row(
                          children: <Widget>[
                            Icon(
                              widget.starticon,
                              color: Colors.grey,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Container(
                              width: 1,
                              height: 30,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                // suffix:
                //     (widget.endIcon != null) ? Icon(widget.endIcon) : SizedBox(),
                //       prefixIcon: Padding(
                //   // padding: const EdgeInsets.only(top: 15), // add padding to adjust icon
                //   child: Icon(widget.starticon),
                // ),
                focusColor: Theme.of(context).primaryColor,
                border: widget.border ?? InputBorder.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
