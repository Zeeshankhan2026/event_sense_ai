import 'package:flutter/material.dart';


class EventScreenCard extends StatelessWidget {

  final String imageUrl;
  final String title;
  final String description;
  final String daysLeft;
  final String people;
  final String price;
  final String date;
  final String location;
  final String location_icon;
  final String wallet_icon;
  final String attendence;

   EventScreenCard({
    super.key,
     required this.imageUrl,
     required this.location_icon,
     required this.wallet_icon,
     required this.title,
     required this.description,
     required this.daysLeft,
     required this.people,
     required this.price,
     required this.date,
     required this.location,
     required this.attendence,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// TOP CONTENT
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// IMAGE
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: imageUrl.startsWith('http') 
                  ? Image.network(
                      imageUrl,
                      height: 72,
                      width: 72,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Image.asset(
                        imageUrl, // If network fails, try as asset (though unlikely to be same path)
                        height: 72,
                        width: 72,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => const Icon(Icons.image, size: 72),
                      ),
                    )
                  : Image.asset(
                      imageUrl,
                      height: 72,
                      width: 72,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.image, size: 72),
                    ),
              ),
              const SizedBox(width: 12),

              /// TEXT + BADGE
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xffE8EDFF),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            daysLeft,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff4C63FF),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Divider(color: Colors.grey.shade300, height: 1),

          const SizedBox(height: 10),

          /// BOTTOM ROW
          Row(
            children: [
              _infoItem(Icons.group, "people"),
              const SizedBox(width: 8),
              _infoItem(
                Icons.attach_money,
                price,
                color: Colors.green,
              ),
              const SizedBox(width: 8),
              Expanded(child: _infoItem(Icons.calendar_today, date)),
              const SizedBox(width: 8),
              Expanded(child: _statusItem(location)),
              const Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: Colors.black54,
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// SMALL INFO ITEM
  Widget _infoItem(IconData icon, String text,
      {Color color = Colors.black}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 11,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  /// STATUS ITEM
  Widget _statusItem(String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.location_on, size: 14, color: Colors.green),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 11,
              color: Colors.green,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
