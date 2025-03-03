import 'package:injectable/injectable.dart';
import 'package:online_exam_app/core/services/user_service.dart';
import 'package:online_exam_app/data/model/Result/ResultModel.dart';
import 'package:online_exam_app/domain/common/result.dart';
import 'package:online_exam_app/domain/repo_contract/GetResultsRepo.dart';
@injectable
class GetResultsUseCase {
  GetResultsRepo repo;
  final UserService userService;
  @factoryMethod
  GetResultsUseCase(this.userService,this.repo,);

  String? get userId => userService.getCurrentUser()?.id;


  Future<Result<List<ResultModel>>> fetchResults() async {
    return repo.FetchResults(userId??"");
  }

  Future<Result<bool>> addResult(ResultModel result) async {
    return repo.addResult(userId??"",result);
  }

  Future<Result<bool>> deleteResult({required String userId, required String id}) async {
    return repo.deleteResult(userId,id);
  }
}
