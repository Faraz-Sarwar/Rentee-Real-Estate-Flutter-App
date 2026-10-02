import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:rentee_real_estate/Utilities/app_colors.dart';
import 'package:rentee_real_estate/Utilities/app_sizing.dart';
import 'package:rentee_real_estate/Utilities/show_message.dart';
import 'package:rentee_real_estate/components/custom_button.dart';
import 'package:rentee_real_estate/components/row_horizental_text.dart';
import 'package:rentee_real_estate/models/appointment_model.dart';
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
    final apnmtVM = ref.watch(appointmentsVmProvider);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSize.medium,
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
                            AppointmentModel property = data[index];
                            String date = DateFormat(
                              'dd/MM',
                            ).format(property.date);
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
                                        width:
                                            MediaQuery.of(context).size.height *
                                            0.15,
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
                                                  fontSize: 11,
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
                                                  message:
                                                      'Your appointment has been canceled',
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
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
                                                style: TextStyle(fontSize: 13),
                                              ),
                                              onPressed: () async {
                                                final initialDate =
                                                    property.date;
                                                final newSelectDate = await showDialog<DateTime>(
                                                  context: context,
                                                  builder: (context) => StatefulBuilder(
                                                    builder: (context, setState) => AlertDialog.adaptive(
                                                      title: const Text(
                                                        'Pick a new date',
                                                      ),
                                                      content: SizedBox(
                                                        height: 300,
                                                        width: 300,
                                                        child: CalendarDatePicker(
                                                          initialDate:
                                                              initialDate,
                                                          firstDate: DateTime(
                                                            2000,
                                                          ),
                                                          lastDate: DateTime(
                                                            2100,
                                                          ),
                                                          onDateChanged:
                                                              (
                                                                DateTime
                                                                newDate,
                                                              ) {
                                                                setState(() {
                                                                  property.date =
                                                                      newDate;
                                                                });
                                                              },
                                                        ),
                                                      ),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                              context,
                                                            );
                                                          },
                                                          child: Text('Cancel'),
                                                        ),
                                                        TextButton(
                                                          onPressed: () async {
                                                            await ref
                                                                .read(
                                                                  appointmentsVmProvider
                                                                      .notifier,
                                                                )
                                                                .rescheduleAppointment(
                                                                  property.date,
                                                                  property.id,
                                                                );
                                                            Navigator.pop(
                                                              context,
                                                            );
                                                            Utils.showMessage(
                                                              message:
                                                                  "Your appointment have been rescehdule to ${DateFormat('dd MMM yy').format(property.date)} ",
                                                              toastLength: Toast
                                                                  .LENGTH_LONG,
                                                            );
                                                          },
                                                          child: Text('Okay'),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
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
