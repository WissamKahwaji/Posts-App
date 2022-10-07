part of 'add_delete_update_bloc.dart';

abstract class AddDeleteUpdateState extends Equatable {
  const AddDeleteUpdateState();

  @override
  List<Object> get props => [];
}

class AddDeleteUpdateInitial extends AddDeleteUpdateState {}

class LoadingAddDeleteUpdatePostsState extends AddDeleteUpdateState {}

class ErrorAddDeleteUpdatePostState extends AddDeleteUpdateState {
  final String message;

  const ErrorAddDeleteUpdatePostState({required this.message});
  @override
  List<Object> get props => [message];
}

class MessageAddDeleteUpdatePostState extends AddDeleteUpdateState {
  final String message;

  const MessageAddDeleteUpdatePostState({required this.message});
  @override
  List<Object> get props => [message];
}
