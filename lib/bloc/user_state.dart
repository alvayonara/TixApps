part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class UserInitial extends UserState {
  @override
  List<Object> get props => [];
}

// State data-data sudah load
class UserLoaded extends UserState {
  final User user;

  UserLoaded(this.user);

  // Save data user
  @override
  List<Object> get props => [user];
}
