import 'package:flutter_riverpod/legacy.dart';
import 'package:rentee_real_estate/models/appointment_model.dart';
import 'package:rentee_real_estate/models/property_model.dart';
import 'package:rentee_real_estate/repositories/appointment/appointments_repo.dart';
import 'package:rentee_real_estate/view_models/appointmets_vm/appointment_state.dart';

final appointmentsVmProvider =
    StateNotifierProvider<AppointmentsVm, AppointmentState>(
      (ref) => AppointmentsVm(ref.read(appointmentsRepoProvider)),
    );

class AppointmentsVm extends StateNotifier<AppointmentState> {
  final AppointmentsRepo _appointmentsRepo;
  AppointmentsVm(this._appointmentsRepo) : super(AppointmentState());

  Future<void> bookAppointment({
    required PropertyModel property,
    required DateTime visitDate,
    required DateTime visitTime,
  }) async {
    state = AppointmentState(isLoading: true);
    try {
      await _appointmentsRepo.saveAppointment(
        property: property,
        date: visitDate,
        time: visitTime,
      );
      state = AppointmentState(isLoading: false);
    } catch (e) {
      state = AppointmentState(error: e.toString());
    }
  }

  Stream<List<AppointmentModel>> loadAppointments() {
    try {
      return _appointmentsRepo.getAppointments();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
