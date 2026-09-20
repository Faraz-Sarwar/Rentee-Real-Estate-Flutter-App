import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:rentee_real_estate/models/property_model.dart';
import 'package:rentee_real_estate/repositories/appointment/appointments.dart';
import 'package:rentee_real_estate/view_models/appointmets_vm/appointment_state.dart';

final appointmentsVmProvider =
    StateNotifierProvider<AppointmentsVm, AppointmentState>(
      (ref) => AppointmentsVm(ref.read(appointmentsRepoProvider)),
    );

class AppointmentsVm extends StateNotifier<AppointmentState> {
  bool _isloading = false;
  bool get isLoading => _isloading;
  final AppointmentsRepo _appointmentsRepo;
  AppointmentsVm(this._appointmentsRepo) : super(AppointmentState());

  Future<void> bookAppointment({
    required PropertyModel property,
    required DateTime visitDate,
    required DateTime visitTime,
  }) async {
    try {
      await _appointmentsRepo.saveAppointment(
        property: property,
        date: visitDate,
        time: visitTime,
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
