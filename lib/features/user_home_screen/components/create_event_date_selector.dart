import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CreateEventDateSelector extends StatefulWidget {
  final String? initialDate;
  final String? initialTime;
  final Function(String)? onDateSelected;
  final Function(String)? onTimeSelected;

  const CreateEventDateSelector({
    super.key,
    this.initialDate,
    this.initialTime,
    this.onDateSelected,
    this.onTimeSelected,
  });

  @override
  State<CreateEventDateSelector> createState() => _CreateEventDateSelectorState();
}

class _CreateEventDateSelectorState extends State<CreateEventDateSelector> {
  late TextEditingController _startDateController;
  late TextEditingController _endDateController;

  @override
  void initState() {
    super.initState();
    _startDateController = TextEditingController(text: widget.initialDate ?? '');
    _endDateController = TextEditingController(text: widget.initialTime ?? '');
  }

  Future<void> _startDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 5),
    );
    if (picked != null) {
      final formatted = "${picked.day}/${picked.month}/${picked.year}";
      _startDateController.text = formatted;
      widget.onDateSelected?.call(formatted);
    }
  }
  Future<void> _endDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 5),
    );
    if (picked != null) {
      final formatted = "${picked.day}/${picked.month}/${picked.year}";
      _endDateController.text = formatted;
      widget.onTimeSelected?.call(formatted);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: const Text("Start Date",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
              ),
              const SizedBox(height: 8),
              Container(
                width: 42.w,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(color: Colors.grey.shade100)
                ),
                child: TextField(
                  controller: _startDateController,
                  readOnly: true,
                  onTap: _startDate,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: Colors.grey.shade100)),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: Colors.grey.shade100)),

                    hintText: "Start date",
                    prefixIcon: const Icon(Icons.calendar_today),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ],
          ),),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: const Text("End Date",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            ),
            const SizedBox(height: 8),
            Container(
              width: 42.w,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: Colors.grey.shade100)
              ),
              child: TextField(
                controller: _endDateController,
                readOnly: true,
                onTap: _endDate,

                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: Colors.grey.shade100)),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: Colors.grey.shade100)),
                  hintText: "End date",
                  prefixIcon: const Icon(Icons.calendar_today),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ],
        )

      ],
    );
  }
}
