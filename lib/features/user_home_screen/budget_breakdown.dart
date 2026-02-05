
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_sense_ai/core/routes/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../core/controller/event_controller.dart';
import '../../core/models/event_model.dart';
import '../../core/widgets/app_buttons.dart';
import '../../core/widgets/apptext.dart';
import '../../core/widgets/custom_headerbar.dart';

class BudgetBreakdown extends StatefulWidget {
  BudgetBreakdown({super.key});

  @override
  State<BudgetBreakdown> createState() => _BudgetBreakdownState();
}

class _BudgetBreakdownState extends State<BudgetBreakdown> {
  final controller = Get.find<EventController>();
  final Map<int, TextEditingController> _textControllers = {};
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    // Initialize currentEventId from arguments if available
    if (Get.arguments != null) {
      if (Get.arguments is EventModel) {
        controller.currentEventId = (Get.arguments as EventModel).eventId;
      } else if (Get.arguments is String) {
        controller.currentEventId = Get.arguments;
      }
    }
  }


  void _syncControllers(List rawCategories) {
    if (controller.categories.length != rawCategories.length) return;
    
    for (int i = 0; i < controller.categories.length; i++) {
      if (!_textControllers.containsKey(i)) {
        _textControllers[i] = TextEditingController(
          text: controller.categories[i].allocated.toStringAsFixed(0),
        );
      } else {
      }
    }
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: controller.eventStream(controller.currentEventId),
          builder: (context, eventSnapshot) {
            if (!eventSnapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final eventData = eventSnapshot.data!.data();
            if (eventData == null) {
              return Center(child: AppText("No event found for ID: ${controller.currentEventId}"));
            }

            final double eventTotalBudget = (eventData["eventBudget"] as num).toDouble();

            return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: controller.blueprintStream(controller.currentEventId),
              builder: (context, blueprintSnapshot) {
                if (!blueprintSnapshot.hasData || blueprintSnapshot.data!.data() == null) {
                  return const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 12),
                        Text("Loading Budget Breakdown..."),
                      ],
                    ),
                  );
                }

                final blueprintData = blueprintSnapshot.data!.data()!;
                final List rawCategories = blueprintData["categories"] as List? ?? [];

                // Initialize controller categories if not done yet
                if (!_initialized && rawCategories.isNotEmpty) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    controller.loadFromBlueprint(
                      rawCategories: rawCategories,
                      eventBudget: eventTotalBudget,
                    );
                    setState(() {
                      _initialized = true;
                    });
                  });
                  return const Center(child: CircularProgressIndicator());
                }

                if (_initialized) {
                  _syncControllers(rawCategories);
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomHeaderBar(
                        title: "AI Budget Breakdown",
                        showBackButton: true,
                        onBack: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      Gap(2.w),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF4F6FF),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: const Color(0xFF4A6CFF),
                            width: 1.2,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              "Total Estimated Budget",
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54,
                            ),
                            Gap(1.h),
                            AppText(
                              "Budget",
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                            ),
                            Gap(1.h),
                            AppText(
                              "\$${eventTotalBudget.toStringAsFixed(0)}",
                              type: AppTextType.heading4,
                              fontSize: 24,
                            ),
                            Gap(2.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Obx(() => _BudgetInfo(
                                      icon: Icons.account_balance_wallet_outlined,
                                      label: "Allocated",
                                      value: controller.allocatedBudget,
                                      valueColor: Colors.green,
                                    )),
                                Obx(() => _BudgetInfo(
                                      icon: Icons.hourglass_bottom,
                                      label: "Remaining",
                                      value: controller.remainingBudget,
                                      valueColor: controller.remainingBudget < 0 ? Colors.red : Colors.blue,
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Gap(1.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText(
                            "Distribution",
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                          ),
                          Obx(() {
                            final percent = eventTotalBudget > 0 
                                ? (controller.allocatedBudget / eventTotalBudget) * 100 
                                : 0.0;
                            return AppText(
                              "${percent.toStringAsFixed(0)}% Allocated",
                              fontSize: 14,
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                            );
                          })
                        ],
                      ),
                      const SizedBox(height: 8),
                      Obx(() => ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Row(
                              children: controller.categories.asMap().entries.map((entry) {
                                final index = entry.key;
                                final cat = entry.value;
                                final flex = eventTotalBudget > 0 ? (cat.allocated / eventTotalBudget) : 0.0;

                                final List<Color> cycleColors = [
                                  Colors.indigo,
                                  Colors.purple.shade200,
                                  Colors.blue,
                                  Colors.pinkAccent,
                                  Colors.orange,
                                  Colors.grey.shade400,
                                ];

                                return _segment(flex.toDouble(), cycleColors[index % cycleColors.length]);
                              }).toList(),
                            ),
                          )),
                      Gap(1.h),
                      AppText(
                        'Categories Breakdown',
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                      Gap(1.h),
                      Expanded(
                        child: Obx(() => ListView.builder(
                              itemCount: controller.categories.length,
                              itemBuilder: (context, index) {
                                final category = controller.categories[index];
                                final String name = category.name;

                                final List<Color> cycleColors = [
                                  Colors.blue,
                                  Colors.purple,
                                  Colors.orange,
                                  Colors.green,
                                  Colors.red,
                                  Colors.indigo,
                                ];
                                final color = cycleColors[index % cycleColors.length];

                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 12.0),
                                  child: Container(
                                    padding: const EdgeInsets.all(14),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.05),
                                          blurRadius: 6,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: 16.w,
                                              height: 6.h,
                                              decoration: BoxDecoration(
                                                color: color.withOpacity(0.2),
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                              child: Center(
                                                child: Icon(Icons.category_outlined, color: color),
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          AppText(
                                                            name,
                                                            color: Colors.indigo.shade900,
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: 16,
                                                          ),
                                                          Text(
                                                            "Estimated Budget",
                                                            style: const TextStyle(fontSize: 12, color: Colors.black54),
                                                          ),
                                                        ],
                                                      ),
                                                      const Icon(Icons.lock_outline, size: 20, color: Colors.grey),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 6),
                                        AppText(
                                          "Suggested Amount",
                                          fontSize: 10,
                                          fontWeight: FontWeight.w700,
                                          color: color,
                                        ),
                                        const SizedBox(height: 6),
                                        Container(
                                          width: 100.w,
                                          height: 5.h,
                                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade100,
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: TextField(
                                            keyboardType: TextInputType.number,
                                            controller: _textControllers[index],
                                            onChanged: (value) {
                                              final double newValue = double.tryParse(value) ?? 0;
                                              controller.updateCategoryBudget(index, newValue);
                                            },
                                            decoration: const InputDecoration(
                                              prefixText: "\$ ",
                                              border: InputBorder.none,
                                              isDense: true,
                                            ),
                                            style: const TextStyle(fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )),
                      ),
                      Gap(1.h),
                      Row(
                        children: [
                          Expanded(
                            child: Obx((){
                              return AppButtonWidget(
                                width: 100.w,
                                height: 5.h,
                                buttonColor: const Color(0xFF2F3C7E),
                                loader: controller.isLoading.value,
                                text: "Approved Budget",
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                onPressed: controller.isLoading.value ? null :  () async {
                                  final userId = FirebaseAuth.instance.currentUser!.uid;
                                  final isSaved =   await controller.saveBudget(userId, controller.currentEventId);
                                 if(!isSaved) return;
                                  await   controller.UpdateEventStatus(controller.currentEventId);
                                  Get.offAllNamed(AppRoutes.main);
                                },
                              );
                            }
                            ),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            width: 15.w,
                            height: 5.h,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(width: 1, color: Colors.grey.shade400),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.refresh, color: Colors.black38),
                              onPressed: () {
                                controller.refreshAllocation();
                                // After refresh, we need to update text controllers
                                for (int i = 0; i < controller.categories.length; i++) {
                                  _textControllers[i]?.text = controller.categories[i].allocated.toStringAsFixed(0);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      Gap(1.h),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _segment(double flex, Color color) {
    return Expanded(
      flex: (flex * 100).toInt(),
      child: Container(
        height: 10,
        color: color,
      ),
    );
  }

}
class _BudgetInfo extends StatelessWidget {
  final IconData icon;
  final String label;
  final double value;
  final Color valueColor;

  const _BudgetInfo({
    required this.icon,
    required this.label,
    required this.value,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(2.h),
        Row(
          children: [
            Icon(icon,size: 18,),
            AppText(label, color: Colors.grey.shade600,fontSize: 14,fontWeight: FontWeight.w800,),

          ],
        ),
        Text(
          "\$${(value as num).round()}",
          style:  TextStyle(
            fontSize: 24,
            color: valueColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
