import '../../../../core/usecases/usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/sign_in_usecase.dart';
import '../../domain/usecases/sign_up_usecase.dart';
import '../../domain/usecases/sign_out_usecase.dart';
import '../../domain/usecases/get_current_user_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInUseCase _signInUseCase;
  final SignUpUseCase _signUpUseCase;
  final SignOutUseCase _signOutUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;

  AuthBloc({
    required SignInUseCase signInUseCase,
    required SignUpUseCase signUpUseCase,
    required SignOutUseCase signOutUseCase,
    required GetCurrentUserUseCase getCurrentUserUseCase,
  }) : _signInUseCase = signInUseCase,
       _signUpUseCase = signUpUseCase,
       _signOutUseCase = signOutUseCase,
       _getCurrentUserUseCase = getCurrentUserUseCase,
       super(AuthInitial()) {
    on<SignInRequested>(_onSignInRequested);
    on<SignUpRequested>(_onSignUpRequested);
    on<LinkedInSignInRequested>(_onLinkedInSignInRequested);
    on<LinkedInSignUpRequested>(_onLinkedInSignUpRequested);
    on<SignOutRequested>(_onSignOutRequested);
    on<CheckAuthStatus>(_onCheckAuthStatus);
  }

  Future<void> _onSignInRequested(
    SignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    
    final result = await _signInUseCase(
      SignInParams(email: event.email, password: event.password),
    );
    
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(AuthAuthenticated(user)),
    );
  }

  Future<void> _onSignUpRequested(
    SignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    
    final result = await _signUpUseCase(
      SignUpParams(
        email: event.email,
        password: event.password,
        firstName: event.firstName,
        lastName: event.lastName,
        phone: event.phone,
        userType: event.userType,
        module: event.module,
      ),
    );
    
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(AuthRegistrationSuccess('Inscription réussie! Veuillez vous connecter.')),
    );
  }

  Future<void> _onLinkedInSignInRequested(
    LinkedInSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    
    try {
      // Simulate LinkedIn authentication flow
      await Future.delayed(const Duration(seconds: 2));
      
      // In a real implementation, you would:
      // 1. Use LinkedIn OAuth to get access token
      // 2. Fetch user profile from LinkedIn API
      // 3. Check if user exists in your database
      // 4. Sign in or create account accordingly
      
      // For now, simulate successful authentication
      final user = UserEntity(
        id: 'linkedin_user_${DateTime.now().millisecondsSinceEpoch}',
        email: 'linkedin.user@example.com',
        firstName: 'Utilisateur',
        lastName: 'LinkedIn',
        userType: 'learner', // Default to learner for LinkedIn sign-in
        selectedModules: [event.moduleType],
        role: 'learner',
        isPremium: false,
        createdAt: DateTime.now(),
      );
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthError('Erreur lors de la connexion LinkedIn: $e'));
    }
  }

  Future<void> _onLinkedInSignUpRequested(
    LinkedInSignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    
    try {
      // Simulate LinkedIn registration flow
      await Future.delayed(const Duration(seconds: 2));
      
      // In a real implementation, you would:
      // 1. Use LinkedIn OAuth to get access token
      // 2. Fetch user profile from LinkedIn API
      // 3. Extract professional information (skills, experience, etc.)
      // 4. Create user account with LinkedIn data
      
      emit(AuthRegistrationSuccess('Inscription LinkedIn réussie! Veuillez vous connecter.'));
    } catch (e) {
      emit(AuthError('Erreur lors de l\'inscription LinkedIn: $e'));
    }
  }

  Future<void> _onSignOutRequested(
    SignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    
    final result = await _signOutUseCase(NoParams());
    
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(AuthUnauthenticated()),
    );
  }

  Future<void> _onCheckAuthStatus(
    CheckAuthStatus event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    
    final result = await _getCurrentUserUseCase(NoParams());
    
    result.fold(
      (failure) => emit(AuthUnauthenticated()),
      (user) => user != null 
        ? emit(AuthAuthenticated(user))
        : emit(AuthUnauthenticated()),
    );
  }
}
