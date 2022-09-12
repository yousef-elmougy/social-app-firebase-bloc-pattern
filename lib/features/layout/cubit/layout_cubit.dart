import '../../chat/presentation/screens/chat_screen.dart';
import '../../post/presentation/screens/home_screen.dart';
import '../../post/presentation/screens/create_post_screen.dart';
import '../../user/presentation/screens/settings/settings_screen.dart';
import 'package:social_app_firebase/features/features_exports.dart';

part 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutInitial());

  int currentIndex = 0;

  bottomNavToggle(context,int index) {
    if (index == 1) {
      Routes.newPostScreenScreen.goTo(context);
    }  else {
      currentIndex = index;
      emit(BottomNavToggle());
    }
  }

  List<Widget> screens = [
    const HomeScreen(),
    const NewPostScreen(),
    const ChatScreen(),
    const SettingsScreen(),
  ];
}
