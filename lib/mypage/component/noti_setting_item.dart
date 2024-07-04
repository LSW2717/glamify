import 'package:flutter/material.dart';

import '../../common/const/colors.dart';

class NotiSettingItemContainer extends StatelessWidget {
  final Widget child;

  const NotiSettingItemContainer({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => {},
      style: ButtonStyle(
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        ),
        backgroundColor: WidgetStateProperty.resolveWith<Color>(
                (Set<WidgetState> states) {
              if (states.contains(WidgetState.pressed)) return gray50;
              return white;
            }),
        elevation: WidgetStateProperty.all<double>(0),
        splashFactory: NoSplash.splashFactory,
        overlayColor: WidgetStateProperty.resolveWith<Color?>(
              (Set<WidgetState> states) {
            if (states.contains(MaterialState.pressed)) return gray50;
            return null;
          },
        ),
        padding: WidgetStateProperty.all(EdgeInsets.zero),
      ),
      child: child,
    );
  }
}
