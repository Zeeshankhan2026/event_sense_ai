import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomCircleAvatar extends StatelessWidget {
  final String? imageUrl;      // optional network image
  late String? assetImage;     // fallback asset image
  final double radius;         // avatar size
  final Color borderColor;     // border color
  final double borderWidth;    // border thickness

   CustomCircleAvatar({
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
        backgroundImage: imageUrl != null && imageUrl!.isNotEmpty
            ? NetworkImage(imageUrl!)
            : null,
        child: imageUrl == null || imageUrl!.isEmpty
            ? SvgPicture.asset(
          assetImage!,
          width: radius,
          height: radius,
          fit: BoxFit.contain,
        )
            : null,
      ),

    );
  }
}
