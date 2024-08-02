import 'package:flutter/cupertino.dart';

class ServiceComponent extends StatelessWidget {
   String image;


   ServiceComponent({required this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: CupertinoColors.extraLightBackgroundGray),
        child: ClipRRect(
            borderRadius: BorderRadiusDirectional.circular(12),
            child: Image.asset(image)),
      ),
    );
  }
}
