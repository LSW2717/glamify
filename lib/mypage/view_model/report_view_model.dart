import 'package:flutter/cupertino.dart';
import 'package:glamify/chat/model/report_request_model.dart';
import 'package:glamify/mypage/model/inquiry_request_model.dart';
import 'package:glamify/mypage/model/skip_and_limit_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/inquiry_response_model.dart';
import '../repository/report_repository.dart';

part 'report_view_model.g.dart';


@riverpod
class ReportViewModel extends _$ReportViewModel {

  @protected
  late ReportRepository repository;

  @override
  ReportListState build() {

    repository = ref.watch(reportRepositoryProvider);
    getAllReport();
    return const LoadingReportListState();
  }

  Future<void> getAllReport() async{
    state = const LoadingReportListState();
    try {
      final SkipAndLimit request = SkipAndLimit(skip: 0, limit: 100);
      final response = await repository.getInquiries(request);
      print(response.data);
      if(response.data != null){
        state = LoadedReportListState(response.data!);
      }
    } catch (e) {
      print(e.toString());
      state = ErrorReportListState(e.toString());
    }
  }


  Future<void> sendReport(InquiryRequest request) async {
    try {
      await repository.sendInquiry(request);
    } catch (e) {
      print(e.toString());
    }

  }
}




abstract class ReportListState {
  const ReportListState();
}

class LoadingReportListState extends ReportListState {
  const LoadingReportListState();
}

class LoadedReportListState extends ReportListState {
  final InquiryResponse response;

  const LoadedReportListState(this.response);
}

class ErrorReportListState extends ReportListState {
  final String errorMessage;

  const ErrorReportListState(this.errorMessage);
}
