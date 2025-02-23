import 'package:injectable/injectable.dart';
import 'package:online_exam_app/data/model/user_response/user_response.dart';
import 'package:online_exam_app/domain/common/result.dart';
import 'package:online_exam_app/domain/repo_contract/profile_repo_contract.dart';

@injectable
class GetProfileUseCase {
  final ProfileRepoContract profileRepo;

  GetProfileUseCase(this.profileRepo);

  Future<Result<UserResponse>> invoke() async {
    return await profileRepo.getProfileData();
  }
}

@injectable
class UpdateProfileUseCase {
  final ProfileRepoContract profileRepo;

  UpdateProfileUseCase(this.profileRepo);

  Future<Result<UserResponse>> invoke({
    required String username,
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    String? password,
  }) async {
    return await profileRepo.updateProfileData(
      username: username,
      firstName: firstName,
      lastName: lastName,
      email: email,
      phone: phone,
      password: password,
    );
  }
}
