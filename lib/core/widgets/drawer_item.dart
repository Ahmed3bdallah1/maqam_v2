import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maqam_v2/features/trips/presentation/controllers/trips_state.dart';
import '../../features/trips/presentation/controllers/trips_cubit.dart';
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
    return BlocConsumer<TripsCubit, TripsState>(
      listener: (context, state) {},
      builder: (context, state) {
        final selectedIndex = TripsCubit.get(context).currentIndex;
        bool isSelectedIndex() {
          return index == selectedIndex;
        }

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
                TripsCubit.get(context).changeTab(index);

                zoomDrawerController.close?.call();
              },
        );
      },
    );
  }
}
