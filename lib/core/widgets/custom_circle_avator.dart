import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomCircleAvatar extends StatelessWidget {
  final String? imageUrl;      // optional network image
  final String assetImage;     // fallback asset image
  final double radius;         // avatar size
  final Color borderColor;     // border color
  final double borderWidth;    // border thickness

  const CustomCircleAvatar({
    Key? key,
    this.imageUrl,
    required this.assetImage,
    this.radius = 50,
    this.borderColor = Colors.blue,
    this.borderWidth = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(borderWidth),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: borderWidth),
      ),
      child: CircleAvatar(
        radius: radius,
        backgroundColor: Colors.grey[200],
        child: imageUrl != null && imageUrl!.isNotEmpty
            ? Image.network(imageUrl!)
            : SvgPicture.asset(assetImage,),
      ),
    );
  }
}
