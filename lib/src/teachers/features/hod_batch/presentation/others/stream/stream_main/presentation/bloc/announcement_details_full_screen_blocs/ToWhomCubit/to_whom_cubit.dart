import 'package:bloc/bloc.dart';

class ToWhomOverlayCubit extends Cubit<bool> {
  ToWhomOverlayCubit() : super(false);

  void showOverlay() => emit(true);
  void hideOverlay() => emit(false);
}
