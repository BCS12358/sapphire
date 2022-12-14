import 'package:flutter/material.dart';

class DissmissableBackground extends StatelessWidget {
  const DissmissableBackground({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.centerEnd,
      color: Colors.red,
      child: const Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
        child: Icon(Icons.delete),
      ),
    );
  }
}
