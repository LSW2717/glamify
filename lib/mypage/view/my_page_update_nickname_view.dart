import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:glamify/user/view_model/user_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../common/component/alert_message.dart';
import '../../common/const/colors.dart';
import '../../common/const/typography.dart';
import '../../common/layout/default_layout.dart';
import '../../common/model/image_request.dart';
import '../../common/repository/image_repository.dart';
import '../../user/model/user_model.dart';
import '../../user/repository/user_repository.dart';
import '../model/update_profile_image_request_model.dart';

class UpdateNickNameView extends ConsumerStatefulWidget {
  final UserModel user;

  const UpdateNickNameView({
    required this.user,
    super.key,
  });

  @override
  ConsumerState<UpdateNickNameView> createState() => _UpdateNickNameViewState();
}

class _UpdateNickNameViewState extends ConsumerState<UpdateNickNameView> {
  String? imageUrl;
  XFile? selectedImageFile;

  Future<void> pickImage() async {
    ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        imageUrl = image.path;
        selectedImageFile = image;
      });
    }
  }

  Future<void> uploadImage() async {
    if (imageUrl == widget.user.image) return;

    if(imageUrl == null) return;

    try {
      Dio dio = Dio();
      final imageRepository = ref.read(imageRepositoryProvider);
      final response = await imageRepository
          .getUploadImageUri(ImageRequest(isProfile: false));

      final uploadUri = response.data!.uploadUri;
      final loadUri = response.data!.loadUri;
      final file = await selectedImageFile?.readAsBytes();

      await dio.put(uploadUri,
          data: file,
          options: Options(
            headers: {
              Headers.contentTypeHeader: 'image/jpeg',
              Headers.contentLengthHeader: file!.length,
            },
          ));

      setState(() {
        imageUrl = loadUri;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> updateProfileImage() async {
    if(imageUrl == widget.user.image) return;

    if(imageUrl == null) return;

    final userRepository = ref.read(userRepositoryProvider);
    try {
      final request = UpdateProfileImageRequest(profileImageUri: imageUrl!);
      await userRepository.updateProfileImage(request);
      setState(() {});
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    String nickname = '';
    return DefaultLayout(
      title: '내 정보 수정',
      needBackButton: true,
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      backAction: () {
        context.pop();
      },
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await pickImage();
                      },
                      child: Container(
                        width: 200.w,
                        height: 200.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: base3,
                        ),
                        child: Stack(
                          children: [
                            Center(
                              child: widget.user.image.isEmpty
                                  ? Icon(
                                      Icons.person,
                                      size: 150.w,
                                    )
                                  : ClipOval(
                                      child: CachedNetworkImage(
                                        imageUrl: imageUrl == null
                                            ? widget.user.image
                                            : imageUrl!,
                                        width: 200.w,
                                        height: 200.w,
                                        placeholder: (context, url) =>
                                            Image.memory(kTransparentImage),
                                        errorWidget: (context, url, error) => Container(
                                          color: base3,
                                          child: Center(
                                            child: Icon(
                                              Icons.person,
                                              size: 150.w,
                                            ),
                                          ),
                                        ),
                                        fadeInDuration: const Duration(milliseconds: 100),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                            ),
                            if (selectedImageFile != null)
                              ClipOval(
                                child: Image.file(
                                  File(selectedImageFile!.path),
                                  width: 200.w,
                                  height: 200.w,
                                  fit: BoxFit.cover,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 40.w),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '닉네임',
                          style: headerText5.copyWith(color: gray650),
                        ),
                        SizedBox(
                          width: 12.w,
                          height: 12.w,
                          child: Center(
                            child: Text(
                              '*',
                              textAlign: TextAlign.center,
                              style: headerText5.copyWith(color: Colors.red),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.w),
                    SizedBox(
                      width: 335.w,
                      height: 54.w,
                      child: TextFormField(
                        maxLines: 1,
                        onChanged: (value) {
                          nickname = value;
                        },
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                          hintText: widget.user.nickname,
                          hintStyle: headerText5.copyWith(color: gray500),
                          contentPadding: EdgeInsets.only(left: 16.w),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(width: 1, color: gray100),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(width: 1, color: main1),
                          ),
                        ),
                        style: headerText5,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        final bool confirm = await showDialog<bool>(
                              context: context,
                              builder: (BuildContext context) {
                                return const AlarmMessage(
                                  title: '수정',
                                  content: '닉네임을 수정하시겠습니까?',
                                );
                              },
                            ) ??
                            false;
                        if (confirm) {
                          try {
                            await uploadImage()
                                .then((e) async => {await updateProfileImage()})
                                .then((e) async => {
                                      await ref
                                          .read(userViewModelProvider.notifier)
                                          .updateNickname(nickname == ''
                                              ? widget.user.nickname
                                              : nickname)
                                    })
                                .then((e) async => await ref
                                    .read(userViewModelProvider.notifier)
                                    .getMe())
                                .then((e) => context.pop());
                          } catch (e) {
                            if (nickname.contains(' ')) {
                              Fluttertoast.showToast(
                                msg: "띄어쓰기는 들어갈 수 없어요!",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: 16.sp,
                              );
                            } else {
                              Fluttertoast.showToast(
                                msg: "다른 닉네임을 사용해주세요!",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: 16.sp,
                              );
                            }
                          }
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.resolveWith<Color>(
                          (Set<WidgetState> states) {
                            if (states.contains(WidgetState.pressed)) {
                              return main1; // 버튼이 눌렸을 때의 색상
                            }
                            return main1; // 기본 색상
                          },
                        ),
                        minimumSize: WidgetStateProperty.all(Size(343.w, 53.w)),
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.w),
                          ),
                        ),
                      ),
                      child: Text(
                        '저장하기',
                        style: headerText4.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(height: 17.w),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
