import 'package:event_sense_ai/core/widgets/apptext.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

class NotificationDetailsCard extends StatelessWidget {
  final String eventName;
  final String agreedPrice;
  final String scope;
  final String date;
  final String time;
  final String location;
  final String imageUrl;

  const NotificationDetailsCard({
    Key? key,
    required this.eventName,
    required this.agreedPrice,
    required this.scope,
    required this.date,
    required this.time,
    required this.location,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Event Image
          Stack(
            children:[
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  imageUrl,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 16.h,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        eventName,
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ]
          ),
          // Event Title and Price
          Gap(2.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText("Agreed Price", fontSize: 20,fontWeight: FontWeight.w600,color: Colors.grey,),
                Text(
                  agreedPrice,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
          // Scope
          Gap(1.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                scope,
                style: TextStyle(color: Colors.blue.shade700),
              ),
            ),
          ),
          // Date, Time, and Location
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height : 7.h,
                        width:  16.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Color(0xff253EA77A).withOpacity(0.2)
                        ),
                        child: Icon(Icons.calendar_today, size: 20, color: Colors.grey)),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText("Date",fontWeight: FontWeight.w700,fontSize: 14,color: Colors.grey.shade500,),
                        Text(
                          date,
                          style: TextStyle(color: Colors.black54,fontSize: 16,fontWeight: FontWeight.w800,),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Container(
                        height : 7.h,
                        width:  16.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Color(0xff253EA77A).withOpacity(0.2)
                        ),
                        child: Icon(Icons.alarm_sharp, size: 20, color: Colors.grey)),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText("Time",fontWeight: FontWeight.w700,fontSize: 14,color: Colors.grey.shade500,),
                        Text(
                          time,
                          style: TextStyle(color: Colors.black54,fontSize: 16,fontWeight: FontWeight.w800,),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Container(
                        height : 7.h,
                        width:  16.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Color(0xff253EA77A).withOpacity(0.2)
                        ),
                        child: Icon(Icons.location_on_outlined, size: 20, color: Colors.grey)),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText("Location",fontWeight: FontWeight.w700,fontSize: 14,color: Colors.grey.shade500,),
                        Text(
                          location,
                          style: TextStyle(color: Colors.black54,fontSize: 16,fontWeight: FontWeight.w800,),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
