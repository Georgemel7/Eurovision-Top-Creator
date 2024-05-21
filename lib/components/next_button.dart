import 'package:flutter/material.dart';

import '../constants.dart';

class NextButton extends StatelessWidget {
  const NextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
          color: Color.fromRGBO(238, 222, 185, 1.0),
          borderRadius: BorderRadius.all(
            Radius.circular(kOutlineBorderRadius),
          )),
      child: const Center(child: Text('Next', style: TextStyle(fontSize: 16),),),
    );
  }
}
class DefButton extends StatelessWidget {
  const DefButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.height,
    this.outlineBorderRadius,
  });

  final Function onPressed;
  final String text;
  final double? height;
  final bool? outlineBorderRadius;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: (){onPressed();},
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return kThemeColor;
              }
              return kThemeColor;
            },
          ),
          shape: MaterialStateProperty.resolveWith<OutlinedBorder>((states) =>
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular((outlineBorderRadius ?? false) ? kOutlineBorderRadius : kBorderRadius))),
          fixedSize: MaterialStateProperty.resolveWith<Size>(
                 (states) => Size(double.infinity, height ?? 0))
    ),
      child: SizedBox(
        width: double.infinity,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

