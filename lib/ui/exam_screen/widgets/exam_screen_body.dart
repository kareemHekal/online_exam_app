import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app/core/theme/colors_manager.dart';
import 'package:online_exam_app/core/utils/config.dart';
import 'package:online_exam_app/core/utils/text_style_manger.dart';
import 'package:online_exam_app/data/model/Result/ResultModel.dart';
import 'package:online_exam_app/data/model/questions_response/question.dart';
import 'package:online_exam_app/ui/exam_screen/view/summary_exam_screen.dart';
import 'package:online_exam_app/ui/exam_screen/view_model/get_questions_cubit.dart';
import 'package:online_exam_app/ui/exam_screen/view_model/get_questions_intent.dart';
import 'package:online_exam_app/ui/exam_screen/widgets/LinearProgress_custom.dart';
import 'package:online_exam_app/ui/exam_screen/widgets/answer_builder.dart';
import 'package:online_exam_app/ui/exam_screen/widgets/next&back_customButton.dart';

class ExamScreenBody extends StatelessWidget {
  final GetQuestionsSuccessState getQuestionsSuccessState;

  const ExamScreenBody({
    super.key,
    required this.getQuestionsSuccessState,
  });

  // int quesionCurrent = 1;
  @override
  Widget build(BuildContext context) {
    final int totalQuestions =
        getQuestionsSuccessState.questionResponse?.questions?.length ?? 0;
    final cubit = GetQuestionsCubit.get(context);

    return BlocBuilder<GetQuestionsCubit, GetQuestionsState>(
      buildWhen: (previous, current) {
        if (current is GetQuestionsUpdatedState ||
            current is GetQuestionsResetState) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        final Question? currentQuestion = getQuestionsSuccessState
            .questionResponse?.questions?[cubit.questionCurrent - 1];

        if (state is GetQuestionsUpdatedState) {
          cubit.questionCurrent = state.quesionCurrent;
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Question ${cubit.questionCurrent} of ${totalQuestions.toString()}",
                textAlign: TextAlign.center,
                style: AppTextStyle.medium14.copyWith(color: AppColors.grey),
              ),
              LinearProgressCustom(
                quesionCurrent: cubit.questionCurrent,
                totalQuestions: totalQuestions,
              ),
              Config.spaceSmall,
              Flexible(
                child: Text(
                  currentQuestion?.question ?? '',
                  style: AppTextStyle.medium18,
                ),
              ),
              Config.spaceSmall,
              AnswerBuilder(
                answers: currentQuestion?.answers ?? [],
                answerType: AnswerType.single,
                correctAnswerKey: currentQuestion?.correct ?? '',
                questionId: currentQuestion?.id ?? '',
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  spacing: 16,
                  children: [
                    Expanded(
                      child: OutlinedFilledButton(
                          text: "Back",
                          onTap: () {
                            cubit.doIntent(PreviousQuestionIntent());
                          },
                          borderSide: true),
                    ),
                    Expanded(
                      child: OutlinedFilledButton(
                          text: cubit.questionCurrent == totalQuestions
                              ? "Submit"
                              : "Next",
                          onTap: () {
                            if (cubit.questionCurrent == totalQuestions) {
                              ResultModel result = ResultModel(
                                subject:getQuestionsSuccessState.questionResponse?.questions![0].subject ,
                                examId: getQuestionsSuccessState.questionResponse?.questions?[0].exam?.id,
                                message: getQuestionsSuccessState.questionResponse?.message,
                                questions: getQuestionsSuccessState.questionResponse?.questions,
                                exam: getQuestionsSuccessState.questionResponse?.questions?[0].exam,
                              );
                              cubit.doIntent(addResultIntent(result: result));
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SummaryExamScreen(
                                    correctAnswers: cubit.correctAnswers,
                                    countOfQuestions: totalQuestions,
                                  ),
                                ),
                              );
                            } else {
                              cubit.doIntent(NextQuestionIntent());
                            }
                          },
                          borderSide: false),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
