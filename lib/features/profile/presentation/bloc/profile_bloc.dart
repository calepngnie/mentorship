import 'package:flutter_bloc/flutter_bloc.dart';

// Events
abstract class ProfileEvent {}
class LoadProfile extends ProfileEvent {}

// States
abstract class ProfileState {}
class ProfileInitial extends ProfileState {}
class ProfileLoaded extends ProfileState {
  final String userId;
  ProfileLoaded(this.userId);
}
class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
}

// Bloc
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<LoadProfile>((event, emit) async {
      try {
        // Simuler le chargement d'un profil utilisateur
        await Future.delayed(const Duration(seconds: 1));
        emit(ProfileLoaded('user_id_demo'));
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    });
  }
}
