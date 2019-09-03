import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Empty state widget with icon text and action button (all optional)
class EmptyState extends StatelessWidget {
  const EmptyState({
    this.icon,
    this.text,
    this.showButton = false,
    this.buttonText,
    this.onButtonTap,
  });

  // Big icon of the empty state
  final IconData icon;
  // Text of the empty state
  final String text;
  // Boolean to show or not the action button
  final bool showButton;
  // The text of the action button if showButton is true
  final String buttonText;
  // The function to call when the user click on the action button
  final VoidCallback onButtonTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        icon != null
            ? Icon(
                icon,
                color: Colors.grey[350],
                size: 80,
              )
            : Container(),
        Padding(
          padding: const EdgeInsets.all(15),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
        ),
        showButton
            ? Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: RaisedButton(
                  onPressed: onButtonTap,
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  child: Text(buttonText),
                ),
              )
            : Container(),
      ],
    );
  }
}
