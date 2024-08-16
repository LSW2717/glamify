import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../common/const/colors.dart';
import '../../common/const/typography.dart';
import '../model/inquiry_response_model.dart';

class ReportContainer extends StatelessWidget {
  final InquiryDescriptionResponse report;

  const ReportContainer({
    required this.report,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
        listTileTheme: ListTileTheme.of(context).copyWith(dense: true),
      ),
      child: ExpansionTile(
        iconColor: gray600,
        collapsedIconColor: gray600,
        trailing: const Text(''),
        title: report.inquiryAnswers.isEmpty
            ? Text('답변요청', style: headerText5.copyWith(color: main1))
            : Text('답변완료', style: headerText5.copyWith(color: gray600)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 6.w),
            Text(
              report.title,
              style: headerText4.copyWith(color: gray800),
            ),
            SizedBox(height: 6.w),
            Text(
              DateFormat('yyyy.MM.dd').format(report.registerDate),
              style: bodyText1.copyWith(color: gray700),
            ),
          ],
        ),
        childrenPadding: EdgeInsets.all(16.w),
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: gray50,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.all(10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Q.',
                  style: headerText3.copyWith(color: gray600),
                  softWrap: true,
                ),
                Text(
                  report.title,
                  style: headerText4.copyWith(color: gray800),
                  softWrap: true,
                ),
                Text(
                  report.description,
                  style: headerText4.copyWith(color: gray600),
                  softWrap: true,
                ),
                SizedBox(height: 10.w),
                report.inquiryAnswers.isEmpty
                    ? const SizedBox.shrink()
                    : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: report.inquiryAnswers.map((answer) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'A.',
                          style: headerText3.copyWith(color: gray600),
                          softWrap: true,
                        ),
                        Text(
                          answer.description,
                          style: headerText4.copyWith(color: gray800),
                          softWrap: true,
                        ),
                        Text(
                          DateFormat('yyyy.MM.dd HH:mm').format(answer.registerDate),
                          style: bodyText1.copyWith(color: gray700),
                        ),
                        SizedBox(height: 10.w),
                      ],
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
