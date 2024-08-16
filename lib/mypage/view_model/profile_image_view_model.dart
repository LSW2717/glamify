import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glamify/common/repository/image_repository.dart';
import 'package:glamify/user/repository/user_repository.dart';
import 'package:image_picker/image_picker.dart';

import '../../common/model/image_request.dart';
import '../../mypage/model/update_profile_image_request_model.dart';


final profileImageProvider =
    StateNotifierProvider<ProfileImageViewModel, String>((ref) {
  final userRepository = ref.watch(userRepositoryProvider);
  final imageRepository = ref.watch(imageRepositoryProvider);
  return ProfileImageViewModel(userRepository,imageRepository);
});

class ProfileImageViewModel extends StateNotifier<String> {
  final UserRepository userRepository;
  final ImageRepository imageRepository;

  ProfileImageViewModel(
    this.userRepository,
    this.imageRepository,
  ) : super('');

  Future<void> pickImage() async {
    Dio dio = Dio();
    ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    final response =
    await imageRepository.getUploadImageUri(ImageRequest(isProfile: true));
    try {
      final uploadUri = response.data!.uploadUri;
      final loadUri = response.data!.loadUri;
      final file = await image?.readAsBytes();
      await dio.put(uploadUri,
          data: file,
          options: Options(
            headers: {
              Headers.contentTypeHeader: 'image/jpeg',
              Headers.contentLengthHeader: file!.length,
            },
          ));
      state = loadUri;
      print(state);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> updateProfileImage() async {
    try {
      final request = UpdateProfileImageRequest(profileImageUri: state);
      await userRepository.updateProfileImage(request);
    } catch (e) {
      print(e.toString());
    }
  }
}
