import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final Color textColor;
  final Color buttonColor;
  final void Function() onPressed;
  final bool autoSize;
  final Widget child;
  const CustomButton(
      {@required this.child,
      this.buttonColor,
      this.onPressed,
      this.textColor,
      Key key,
      this.autoSize = false})
      : super(key: key);

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return (_loading)
        ? CircularProgressIndicator()
        : SizedBox(
            width: widget.autoSize ? null : double.infinity,
            height: widget.autoSize ? null : 30,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              color: widget.buttonColor ?? Colors.cyan[400],
              onPressed: () async {
                setState(() {
                  _loading = true;
                });

                // ignore: await_only_futures
                if (widget.onPressed != null) await widget.onPressed();

                setState(() {
                  _loading = false;
                });
              },
              child: widget.child,
              // Text(widget.text,
              //     style: TextStyle(
              //         fontSize: widget.fontSize,
              //         fontWeight: FontWeight.normal,
              //         color: widget.textColor ?? Colors.white)),
            ),
          );
  }
}
