import 'package:flutter_riverpod/flutter_riverpod.dart';


final toggleButtonProvider =
    StateNotifierProvider<ToggleButtonViewModel, bool>((ref) {
  return ToggleButtonViewModel();
});

class ToggleButtonViewModel extends StateNotifier<bool> {
  ToggleButtonViewModel() : super(false);

  void setButton(){
    state = !state;
  }

  void stopButton(){
    state = false;
  }
}