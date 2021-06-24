import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextForm extends StatefulWidget {
  final TextEditingController controller;
  final Size screenSize;
  final String hintText;
  final int maxLength;

  CustomTextForm({
    @required this.controller,
    @required this.screenSize,
    @required this.hintText,
    @required this.maxLength,
  });

  @override
  _CustomTextFormState createState() => _CustomTextFormState();
}

class _CustomTextFormState extends State<CustomTextForm> {

  String text = "";
  @override
  void initState() {
    super.initState();

    widget.controller.addListener(() {
      if (widget.controller.text.length <= 150) {
        text = widget.controller.text;
      } else {
        widget.controller.value = new TextEditingValue(
            text: text,
            selection: new TextSelection(
                baseOffset: 150,
                extentOffset: 150,
                affinity: TextAffinity.downstream,
                isDirectional: true),
            composing: new TextRange(start: 0, end: 150)
        );
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: widget.screenSize.width - 20,
              child: TextFormField(
                validator: (input) => input.trim().length > widget.maxLength
                    ? 'Please enter a ${widget.hintText} less than ${widget.maxLength} characters'
                    : null,
//                maxLength: widget.maxLength,
                controller: widget.controller,
                textCapitalization: TextCapitalization.sentences,
//                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                enableSuggestions: false,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(150)
                ],
                decoration: InputDecoration(
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: 'Add a ${widget.hintText}...',
                    border: InputBorder.none),
              ),
            ),
          ],
        ),
        Divider(),
      ],
    );
  }
}
