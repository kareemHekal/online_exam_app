import 'package:online_exam_app/data/model/questions_response/exam.dart';
import 'package:online_exam_app/domain/common/result.dart';

abstract class GetAllExamsOnSubjectDatasourceContract {
  Future<Result<List<Exam>>> getAllExamsOnSubject(String subjectId);
}
