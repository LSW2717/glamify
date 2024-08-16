import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glamify/mypage/view_model/report_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../chat/model/report_request_model.dart';
import '../../common/component/alert_message.dart';
import '../../common/const/colors.dart';
import '../../common/const/typography.dart';
import '../../common/layout/default_layout.dart';
import '../component/contact_text_form_field.dart';
import '../model/inquiry_request_model.dart';

class SendReportView extends ConsumerWidget {
  const SendReportView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String title = '';
    String description = '';
    return DefaultLayout(
      title: '문의하기작성',
      resizeToAvoidBottomInset: true,
      needBackButton: true,
      backAction: () => context.pop(),
      child: Container(
        width: 390.w,
        height: 844.h,
        padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 13.w),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          behavior: HitTestBehavior.opaque,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    ContactTextFormField(
                      onChanged: (value) {
                        title = value;
                      },
                      maxLine: 1,
                      hintText: '제목',
                      height: 52,
                    ),
                    SizedBox(height: 12.w),
                    ContactTextFormField(
                      maxLine: 30,
                      onChanged: (value) {
                        description = value;
                      },
                      hintText: '문의할 내용을 적어주세요.',
                      height: 300,
                    ),
                    SizedBox(height: 260.h),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 30.w),
                  child: ElevatedButton(
                    onPressed: () async {
                      final bool confirm = await showDialog<bool>(
                            context: context,
                            builder: (BuildContext context) {
                              return const AlarmMessage(
                                title: '저장',
                                content: '등록하시겠습니까?',
                              );
                            },
                          ) ??
                          false;
                      if (confirm) {
                        final InquiryRequest request = InquiryRequest(
                            title: title, description: description);
                        await ref
                            .read(reportViewModelProvider.notifier)
                            .sendReport(request)
                            .then((_) => {
                                  ref.read(reportViewModelProvider.notifier)
                                      .getAllReport()
                                      .then((_) => {
                                            context.pop(),
                                          }),
                                });
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.resolveWith<Color>(
                        (Set<WidgetState> states) {
                          if (states.contains(WidgetState.pressed)) {
                            return main1;
                          }
                          return main1;
                        },
                      ),
                      minimumSize: WidgetStateProperty.all(Size(343.w, 53.w)),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    child: Text(
                      '문의하기',
                      style: headerText4.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
