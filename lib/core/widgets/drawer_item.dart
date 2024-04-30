import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maqam_v2/features/drawer/presentation/controller/drawer_cubit.dart';
import 'package:maqam_v2/features/drawer/presentation/controller/drawer_state.dart';
import '../constants.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    super.key,
    required this.title,
    required this.icon,
    required this.index,
    this.onTap,
  });

  final String title;
  final IconData icon;
  final int index;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DrawerCubit, DrawerPageState>(
      listener: (context, state) {},
      builder: (context, state) {
        final selectedIndex = DrawerCubit.get(context).currentIndex;
        bool isSelectedIndex() => index == selectedIndex;

        return ListTile(
          leading: Icon(
            icon,
            color: isSelectedIndex() ? Colors.orange : Colors.white,
            size: 30,
          ),
          title: Text(
            title,
            style: TextStyle(
                color: isSelectedIndex() ? Colors.orange : Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          onTap: onTap ??
              () {
                DrawerCubit.get(context).changeTab(index);

                zoomDrawerController.close?.call();
              },
        );
      },
    );
  }
}
