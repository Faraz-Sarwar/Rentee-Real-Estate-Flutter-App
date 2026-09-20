import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rentee_real_estate/Utilities/app_colors.dart';
import 'package:rentee_real_estate/Utilities/app_sizing.dart';
import 'package:rentee_real_estate/components/container_icon.dart';
import 'package:rentee_real_estate/models/property_model.dart';

final class ScheduleVisitScreen extends StatefulWidget {
  final PropertyModel property;
  const ScheduleVisitScreen({super.key, required this.property});

  @override
  State<ScheduleVisitScreen> createState() => _ScheduleVisitScreenState();
}

class _ScheduleVisitScreenState extends State<ScheduleVisitScreen> {
  Widget _selectItemText({required String text, required IconData icon}) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary, size: 32),
        const SizedBox(width: AppSize.small),
        Text(text, style: TextStyle(fontWeight: FontWeight.w600)),
      ],
    );
  }

  int currentIndex = 0;
  final today = DateTime.now();
  DateTime selectedDate = DateTime.now();
  DateTime? selectedTime;

  @override
  Widget build(BuildContext context) {
    final startTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      6,
    );
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSize.medium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: ContainerIcon(
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: AppColors.white,
                    ),
                    color: const Color.fromARGB(255, 220, 220, 220),
                  ),
                ),
                const SizedBox(height: AppSize.medium),
                const Text(
                  'Book an Appointment',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: AppSize.small),
                const Text(
                  'Choose date and time to schedule a visit for this property',
                ),
                const SizedBox(height: AppSize.medium),
                Container(
                  height: MediaQuery.of(context).size.height * 0.128,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSize.medium,
                      horizontal: AppSize.medium,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            widget.property.imageUrl,
                            width: MediaQuery.of(context).size.width * 0.30,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: AppSize.medium),
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.property.name,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(widget.property.location),
                                    Spacer(),
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text:
                                                "\$${widget.property.price.toString()}/",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          TextSpan(
                                            text: "Month",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const Icon(Icons.favorite_outline),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSize.medium),

                _selectItemText(
                  text: 'Select a date',
                  icon: Icons.calendar_month,
                ),
                const SizedBox(height: AppSize.small),
                SizedBox(
                  height: 120,
                  child: ListView.builder(
                    itemCount: 7,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final date = today.add(Duration(days: index));
                      final currentDay = DateFormat('EEE').format(date);
                      final currentDate = DateFormat('dd').format(date);
                      final currentMonth = DateFormat('MMM').format(date);
                      final isDateSelected =
                          selectedDate.year == date.year &&
                          selectedDate.month == date.month &&
                          selectedDate.day == date.day;
                      return GestureDetector(
                        onTap: () => setState(() {
                          selectedDate = date;
                        }),
                        child: Container(
                          margin: EdgeInsets.all(9),
                          width: MediaQuery.of(context).size.width * 0.23,
                          decoration: BoxDecoration(
                            color: isDateSelected
                                ? AppColors.primary
                                : AppColors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(AppSize.medium),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  currentDay,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: isDateSelected
                                        ? AppColors.white
                                        : AppColors.textPrimary,
                                  ),
                                ),
                                Text(
                                  currentDate,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: isDateSelected
                                        ? AppColors.white
                                        : AppColors.textPrimary,
                                  ),
                                ),
                                Text(
                                  currentMonth,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: isDateSelected
                                        ? AppColors.white
                                        : AppColors.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: AppSize.medium),

                _selectItemText(text: 'Select time', icon: Icons.watch),
                const SizedBox(height: AppSize.small),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.18,
                  child: ListView.builder(
                    itemCount: 4,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final time = startTime.add(Duration(hours: index * 3));
                      final appointmentTime = DateFormat('h:mm a').format(time);
                      final isTimeSelected = selectedTime == time;
                      return GestureDetector(
                        onTap: () => setState(() {
                          selectedTime = time;
                        }),
                        child: Container(
                          margin: EdgeInsets.all(9),
                          width: MediaQuery.of(context).size.width * 0.28,
                          decoration: BoxDecoration(
                            color: isTimeSelected
                                ? AppColors.primary
                                : AppColors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(AppSize.medium),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  appointmentTime,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: isTimeSelected
                                        ? AppColors.white
                                        : AppColors.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: AppSize.medium),

                _selectItemText(
                  text: "Any addtional message? (Optional)",
                  icon: Icons.message_outlined,
                ),
                const SizedBox(height: AppSize.medium),
                TextFormField(
                  maxLines: 4,
                  maxLength: 200,
                  decoration: InputDecoration(
                    hintText: "Specific details you want to add?",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.textMuted),
                    ),
                    focusedBorder: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(AppSize.medium),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: Size(double.infinity, 50),
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.white,
          ),
          onPressed: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Confirm appointment',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: AppSize.small),
              const Icon(Icons.arrow_forward, size: 22),
            ],
          ),
        ),
      ),
    );
  }
}
