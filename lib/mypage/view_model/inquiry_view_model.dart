import 'package:flutter/cupertino.dart';
import 'package:glamify/mypage/model/inquiry_request_model.dart';
import 'package:glamify/mypage/model/skip_and_limit_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/inquiry_response_model.dart';
import '../repository/report_repository.dart';

part 'inquiry_view_model.g.dart';


@riverpod
class InquiryViewModel extends _$InquiryViewModel {

  @protected
  late ReportRepository repository;

  @override
  InquiryListState build() {

    repository = ref.watch(reportRepositoryProvider);
    getAllInquiries();
    return const LoadingInquiryListState();
  }

  Future<void> getAllInquiries() async{
    state = const LoadingInquiryListState();
    try {
      final SkipAndLimit request = SkipAndLimit(skip: 0, limit: 100);
      final response = await repository.getInquiries(request);
      print(response.data);
      if(response.data != null){
        state = LoadedInquiryListState(response.data!);
      }
    } catch (e) {
      print(e.toString());
      state = ErrorInquiryListState(e.toString());
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




abstract class InquiryListState {
  const InquiryListState();
}

class LoadingInquiryListState extends InquiryListState {
  const LoadingInquiryListState();
}

class LoadedInquiryListState extends InquiryListState {
  final InquiryResponse response;

  const LoadedInquiryListState(this.response);
}

class ErrorInquiryListState extends InquiryListState {
  final String errorMessage;

  const ErrorInquiryListState(this.errorMessage);
}
