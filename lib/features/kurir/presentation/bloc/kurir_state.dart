
import 'package:equatable/equatable.dart';
import 'package:flutterclean/features/kurir/presentation/bloc/kurir_bloc.dart';

import '../../domain/entities/kurir.dart';

abstract class KurirState extends Equatable {
  void add(KurirEventGetAll kurirEventGetAll) {}
}

class KurirInitial extends KurirState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class KurirStateLoading extends KurirState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class KurirStateError extends KurirState {
  final String message;

  KurirStateError({required this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class KurirStateLoadedAll extends KurirState {
  final List<Kurir> kurirs;

  KurirStateLoadedAll({required this.kurirs});

  @override
  List<Object?> get props => [kurirs];
}


class KurirStateLoaded extends KurirState {
  final Kurir kurir;

  KurirStateLoaded({required this.kurir});

  @override
  // TODO: implement props
  List<Object?> get props => [kurir];
}

class KurirStateSuccess extends KurirState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}