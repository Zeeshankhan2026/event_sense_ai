import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:go_router/go_router.dart';

class VendorJobCard extends StatelessWidget {
  final String statusText;
  final Color statusBg;
  final Color statusTextColor;
  final String? routes_name;
  final String title;
  final String dateText;
  final String priceText;

  final IconData icon;
  final Color iconBg;
  final Color iconColor;

  final String buttonText;
  final Color buttonColor;
  final Color buttonTextColor;
  final VoidCallback onButtonTap;

  const VendorJobCard({
    super.key,
    required this.routes_name,
    required this.statusText,
    required this.statusBg,
    required this.statusTextColor,
    required this.title,
    required this.dateText,
    required this.priceText,
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.buttonText,
    required this.buttonColor,
    required this.buttonTextColor,
    required this.onButtonTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xffEAEAEA)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Status Badge
          VendorStatusBadge(
            text: statusText,
            bgColor: statusBg,
            textColor: statusTextColor,
          ),

          const SizedBox(height: 10),

          /// Title + Icon
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// Title & Meta
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$dateText  •  $priceText',
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),

              VendorIconBox(
                icon: icon,
                bgColor: iconBg,
                iconColor: iconColor,
              ),
            ],
          ),

          const SizedBox(height: 12),

          /// Action Button
          SizedBox(
            width: double.infinity,
            height: 36,
            child: ElevatedButton(
              onPressed: (){
                Get.toNamed(routes_name!);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                buttonText,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: buttonTextColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class VendorStatusBadge extends StatelessWidget {
  final String text;
  final Color bgColor;
  final Color textColor;

  const VendorStatusBadge({
    super.key,
    required this.text,
    required this.bgColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
    );
  }
}
class VendorIconBox extends StatelessWidget {
  final IconData icon;
  final Color bgColor;
  final Color iconColor;

  const VendorIconBox({
    super.key,
    required this.icon,
    required this.bgColor,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, color: iconColor, size: 20),
    );
  }
}
