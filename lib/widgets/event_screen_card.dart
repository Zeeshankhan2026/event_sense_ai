import 'package:event_sense_ai/widgets/apptext.dart';
import 'package:flutter/cupertino.dart';

class EventScreenCard extends StatelessWidget {
  String? card_image;
  String? card_title;
  String? card_desc;
  String? days_left;
  String? people_icon;
  double attendence;
  String? wallet_icon;
  double cost;
  String? calender_icon;
  String date;
  String? location_icon;
  String? location;
   EventScreenCard({
   required  this.cost,
     required this.card_image,
     required this.card_title,
     required this.card_desc,
     required this.days_left,
     required this.people_icon,
     required this.attendence,
     required this.wallet_icon,
     required this.location_icon,
     required this.date,
     required this.location,
    super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                child: Image.asset(card_image.toString()),

              ),
              SizedBox(width: 8),
              Column(
                children: [
                  Row(
                    children: [
                      AppText(card_title.toString()),

                    ],
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
