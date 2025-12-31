import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/repositories/doctor_home_repository.dart';
import '../../data/models/home_doctor_model.dart';

part 'doctor_home_state.dart';

class DoctorHomeCubit extends Cubit<DoctorHomeState> {
  final DoctorHomeRepository _repository;

  HomeDoctorModel? _doctorProfile;

  DoctorHomeCubit(this._repository) : super(DoctorHomeInitial());

  // Getters
  HomeDoctorModel? get doctorProfile => _doctorProfile;

  // Safe emit - only emit if cubit is not closed
  void _safeEmit(DoctorHomeState state) {
    if (!isClosed) {
      emit(state);
    }
  }

  // Get Doctor Data
  Future<void> getDoctorData() async {
    try {
      _safeEmit(DoctorHomeLoading());

      final profile = await _repository.getDoctorProfile();
      _doctorProfile = profile;

      _safeEmit(DoctorHomeLoaded(profile));
    } catch (e) {
      _safeEmit(DoctorHomeError(e.toString()));
    }
  }

  // Refresh Data
  Future<void> refresh() async {
    await getDoctorData();
  }

  // Reset State
  void reset() {
    _doctorProfile = null;
    _safeEmit(DoctorHomeInitial());
  }
}
