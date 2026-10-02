import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rentee_real_estate/Utilities/app_colors.dart';
import 'package:rentee_real_estate/Utilities/app_sizing.dart';
import 'package:rentee_real_estate/Utilities/show_message.dart';
import 'package:rentee_real_estate/components/custom_button.dart';
import 'package:rentee_real_estate/components/row_horizental_text.dart';
import 'package:rentee_real_estate/view_models/appointmets_vm/appointments_vm.dart';

class AppointmentScheduleScreen extends ConsumerStatefulWidget {
  const AppointmentScheduleScreen({super.key});

  @override
  ConsumerState<AppointmentScheduleScreen> createState() =>
      _AppointmentScheduleScreenState();
}

class _AppointmentScheduleScreenState
    extends ConsumerState<AppointmentScheduleScreen> {
  @override
  Widget build(BuildContext context) {
    final fetchAppointmentProvider = ref.watch(fetchAppointmentsProvider);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSize.small,
            vertical: AppSize.large,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Schedule appointments",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: AppSize.small),
              const Text('View and manage your upcoming property visits'),
              const SizedBox(height: AppSize.large),
              fetchAppointmentProvider.when(
                data: (data) => data.length == 0
                    ? Center(
                        child: const Text(
                          'No appointments booked at this time',
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            final property = data[index];
                            String date = DateFormat(
                              'dd/MM',
                            ).format(property.date);
                            print(date);
                            return Container(
                              margin: EdgeInsets.only(bottom: AppSize.medium),
                              height: MediaQuery.of(context).size.height * 0.18,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppSize.small,
                                  vertical: AppSize.medium,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.network(
                                        property.imageUrl,
                                        width: 150,
                                        height:
                                            MediaQuery.of(context).size.height *
                                            0.15,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(width: AppSize.medium),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          property.name,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(property.location),
                                        Text(
                                          '\$${property.price.toString()} /per month',
                                        ),
                                        Row(
                                          children: [
                                            RowHorizentalText(
                                              icon: Icons.calendar_month,
                                              text: DateFormat(
                                                'dd, MMM, yyy',
                                              ).format(property.date),
                                              size: 20,
                                            ),
                                            const SizedBox(width: 8),
                                            RowHorizentalText(
                                              icon: Icons.timer_sharp,
                                              text: DateFormat(
                                                'hh,mm',
                                              ).format(property.time),
                                              size: 20,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomButton(
                                              color: AppColors.border,
                                              buttonContent: const Text(
                                                'Cancel',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: AppColors.textPrimary,
                                                ),
                                              ),
                                              onPressed: () async {
                                                await ref
                                                    .read(
                                                      appointmentsVmProvider
                                                          .notifier,
                                                    )
                                                    .cancelAppointment(
                                                      property.id,
                                                    );
                                                Utils.showMessage(
                                                  'Your appointment has been canceled',
                                                );
                                              },
                                              width: 80,
                                              height: 34,
                                            ),
                                            const SizedBox(
                                              width: AppSize.small,
                                            ),
                                            CustomButton(
                                              buttonContent: const Text(
                                                'Reschedule',
                                                style: TextStyle(fontSize: 12),
                                              ),
                                              onPressed: () {},
                                              width: 100,
                                              height: 34,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                error: (err, stackTrace) => Center(child: Text(err.toString())),
                loading: () => Center(child: const CircularProgressIndicator()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
