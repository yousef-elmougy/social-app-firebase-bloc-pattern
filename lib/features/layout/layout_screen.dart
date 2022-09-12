import 'package:social_app_firebase/features/features_exports.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final layoutCubit = BlocProvider.of<LayoutCubit>(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: IconButton(
              onPressed: () {},
              // => context.goTo(Routes.searchScreen),
              icon: const Icon(IconBroken.search),
            ),
          ),
        ],
        title: const Text('Social'),
      ),
      bottomNavigationBar: BlocBuilder<LayoutCubit, LayoutState>(
        builder: (BuildContext context, state) => BottomNavigationBar(
          currentIndex: layoutCubit.currentIndex,
          onTap: (index) => layoutCubit.bottomNavToggle(context, index),
          items: const [
            BottomNavigationBarItem(icon: Icon(IconBroken.home), label: 'home'),
            BottomNavigationBarItem(
                icon: Icon(IconBroken.paperPlus), label: 'post'),
            BottomNavigationBarItem(icon: Icon(IconBroken.chat), label: 'chat'),
            BottomNavigationBarItem(
                icon: Icon(IconBroken.setting), label: 'settings'),
          ],
        ),
      ),
      body: BlocBuilder<LayoutCubit, LayoutState>(
        builder: (BuildContext context, state) => IndexedStack(
          index: layoutCubit.currentIndex,
          children: layoutCubit.screens,
        ),
      ),
    );  }
}
