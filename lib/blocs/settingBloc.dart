import 'package:flutter/material.dart';

class SettingBloc extends State {
  // Call the setState function on all the given states
  void rebuildWidgets({VoidCallback setStates, List<State> states}) {
    if (states != null) {
      for (State<StatefulWidget> state in states) {
        if (state != null && state.mounted) {
          state.setState(setStates ?? () {});
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // This build function will never be called.
    // It has to be overriden here because State interface requires this
    return null;
  }
}
