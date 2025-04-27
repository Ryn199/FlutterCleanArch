import 'package:dartz/dartz.dart';
import 'package:flutterclean/features/kurir/data/models/kurir_model.dart';
import 'package:flutterclean/features/kurir/domain/entities/kurir.dart';
import 'package:flutterclean/features/kurir/domain/repositories/kurir_repositories.dart';

class KurirUsecasesGetAll {
  final KurirRepositories kurirRepositories;

  KurirUsecasesGetAll({required this.kurirRepositories});

  Future<Either<Exception, List<Kurir>>> execute() async {
    return await kurirRepositories.getAllKurir();
  }
}

class KurirUsecasesGetById {
  final KurirRepositories kurirRepositories;

  KurirUsecasesGetById({required this.kurirRepositories});

  Future<Either<Exception, Kurir>> execute({required String id}) async {
    return await kurirRepositories.getKurirById(id: id);
  }
}

class KurirUsecasesAdd {
  final KurirRepositories kurirRepositories;

  KurirUsecasesAdd({required this.kurirRepositories});

  Future<Either<Exception, void>> execute({required KurirModel kurir}) async {
    return await kurirRepositories.addKurir(kurir: kurir);
  }
}

class KurirUsecasesEdit {
  final KurirRepositories kurirRepositories;

  KurirUsecasesEdit({required this.kurirRepositories});

  Future<Either<Exception, void>> execute({required KurirModel kurir}) async {
    return await kurirRepositories.editKurir(kurir: kurir);
  }
}

class KurirUsecasesDelete {
  final KurirRepositories kurirRepositories;

  KurirUsecasesDelete({required this.kurirRepositories});

  Future<Either<Exception, void>> execute({required String id}) async {
    return await kurirRepositories.deleteKurir(id : id);
  }

}