import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glamify/common/layout/default_layout.dart';
import 'package:glamify/mypage/component/report_container.dart';
import 'package:glamify/mypage/view_model/report_view_model.dart';
import 'package:go_router/go_router.dart';

import '../../common/const/colors.dart';

class ReportListView extends ConsumerWidget {
  const ReportListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reportState = ref.watch(reportViewModelProvider);
    return DefaultLayout(
      backAction: () => context.pop(),
      needBackButton: true,
      title: '문의하기',
      action: [
        IconButton(
          onPressed: () {
            context.go('/report/sendReport');
          },
          icon: const Icon(Icons.add),
        ),
      ],
      child: switch (reportState) {
        LoadingReportListState _ => const Center(
            child: CircularProgressIndicator(
              color: main1,
            ),
          ),
        LoadedReportListState _ => ListView.builder(
            itemCount: reportState.response.total,
            itemBuilder: (context, index) {
              final report = reportState.response;
              return ReportContainer(report: report.inquiries[index]);
            },
          ),
        ErrorReportListState _ => Center(child: Text(reportState.errorMessage)),
        _ => const Center(
          child: Text('Unknown state'),
        ),
      },
    );
  }
}
