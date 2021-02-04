import 'package:ar_post/app/ar/ar_actions_bloc.dart';
import 'package:ar_post/app/post/posts_bloc.dart';
import 'package:ar_post/presentation/account/account_widget.dart';
import 'package:ar_post/presentation/ar/ar_widget.dart';
import 'package:ar_post/presentation/posts/feed_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../injection.dart';

class NavigationWidget extends StatefulWidget {
  const NavigationWidget({Key key}) : super(key: key);

  @override
  _NavigationWidgetState createState() => _NavigationWidgetState();
}

class _NavigationWidgetState extends State<NavigationWidget>
    with SingleTickerProviderStateMixin {
  final _pages = [
    const FeedWidget(),
    const ArWidget(),
    const AccountWidget(),
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<PostsBloc>(),
      child: BlocProvider(
        create: (_) => getIt<ArActionsBloc>(),
        child: BlocBuilder<ArActionsBloc, ArActionsState>(
          builder: (context, state) {
            return Scaffold(
              body: _pages[_selectedIndex],
              bottomNavigationBar:
                  state.action == ArAction.capturing ? null : _buildNavbar(),
            );
          },
        ),
      ),
    );
  }

  Widget _buildNavbar() {
    return Builder(
      builder: (context) {
        return BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_rounded),
              label: 'FEED',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.camera),
              label: 'AR',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'ACCOUNT',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Theme.of(context).primaryColor,
          onTap: (index) => _onItemTapped(index, context.read<ArActionsBloc>()),
        );
      },
    );
  }

  void _onItemTapped(int index, ArActionsBloc bloc) {
    if (index != 1) {
      bloc.add(const ArActionsEvent.notifyDisposed());
    }
    setState(() {
      _selectedIndex = index;
    });
  }
}
