import 'package:event_sense_ai/core/widgets/apptext.dart';
import 'package:event_sense_ai/utils/app_colors.dart';
import 'package:event_sense_ai/utils/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class JobStatusCard extends StatelessWidget {
  final JobStatus status;
  final String title;
  final String estimate;
  final IconData icon;
  final VoidCallback onButtonTap;
  final int? applicationsCount;
  const JobStatusCard({
    super.key,
    required this.status,
    required this.title,
    required this.estimate,
    required this.icon,
    required this.onButtonTap,
    this.applicationsCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _statusChip(),
          const SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      SvgPicture.asset(AppIcons.wallet_icon, color: Colors.black54,),
                      Text(
                        ": AI Est: $estimate",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _iconBgColor(),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: _iconColor()),
              ),
            ],
          ),

          const SizedBox(height: 14),
          _actionButton(),
        ],
      ),
    );
  }

  // ---------------- STATUS CHIP ----------------
  Widget _statusChip() {
    switch (status) {
      case JobStatus.notStarted:
        return _chip("Not Started", Colors.grey.shade300.withOpacity(0.3), Colors.black);
      case JobStatus.posted:
        return _chip("Posted", Colors.blue.withOpacity(0.1), Colors.blue);
      case JobStatus.application:
        return _chip(
          "$applicationsCount Applications",
          Colors.orange.withOpacity(0.1),
          Colors.orange,
        );
      case JobStatus.booked:
        return _chip(
          "Vendor Booked",
          Colors.green.withOpacity(0.1),
          Colors.green,
        );
    }
  }

  Widget _chip(String text, Color bg, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 12, color: textColor),
      ),
    );
  }

  // ---------------- BUTTON ----------------
  Widget _actionButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onButtonTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: _buttonColor(),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: AppText(_buttonText(),
          color: _textColor(),fontSize: 14,fontWeight: FontWeight.w700,),
      ),
    );
  }

  String _buttonText() {
    switch (status) {
      case JobStatus.notStarted:
        return "Post Job";
      case JobStatus.posted:
        return "Posted";
      case JobStatus.application:
        return "View Application";
      case JobStatus.booked:
        return "View Booking";
    }
  }
  Color _textColor() {
    switch (status) {
      case JobStatus.notStarted:
        return Colors.black54;
      case JobStatus.posted:
        return Colors.black54;
      case JobStatus.application:
        return Colors.white;
      case JobStatus.booked:
        return Colors.black54;
    }
  }

  Color _buttonColor() {
    switch (status) {
      case JobStatus.notStarted:
        return Colors.grey.shade300.withOpacity(0.3);
      case JobStatus.posted:
        return Colors.grey.shade300.withOpacity(0.3);
      case JobStatus.application:
        return AppColors.fieldColor;
      case JobStatus.booked:
        return Colors.grey.shade300;
    }
  }

  // ---------------- ICON COLORS ----------------
  Color _iconBgColor() {
    switch (status) {
      case JobStatus.notStarted:
        return Colors.pink.shade100.withOpacity(0.2);
      case JobStatus.posted:
        return Colors.pink.shade100.withOpacity(0.2);
      case JobStatus.application:
        return Colors.orange.shade100;
      case JobStatus.booked:
        return Colors.green.withOpacity(0.1);
    }
  }

  Color _iconColor() {
    switch (status) {
      case JobStatus.notStarted:
        return Colors.pink.withOpacity(0.6);
      case JobStatus.posted:
        return Colors.pink.withOpacity(0.6);
      case JobStatus.application:
        return Colors.orange;
      case JobStatus.booked:
        return Colors.green.shade300;
    }
  }
}

enum JobStatus {
  notStarted,
  posted,
  application,
  booked,
}
