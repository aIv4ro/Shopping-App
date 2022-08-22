import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/blocs/home/home_bloc.dart';
import 'package:shopping/blocs/home/home_event.dart';
import 'package:shopping/blocs/home/home_state.dart';
import 'package:shopping/ui/paths.dart';
import 'package:shopping/ui/theme/theme_bloc.dart';
import 'package:shopping/ui/theme/theme_event.dart';
import 'package:shopping/ui/theme/theme_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeBloc _homeBloc;
  late final ThemeBloc _themeBloc;

  @override
  void initState() {
    super.initState();
    _homeBloc = context.read();
    _themeBloc = context.read();
  }

  void _handleLogout() {
    _homeBloc.add(const LogoutEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state.status == HomeStatus.loggedout) {
          Navigator.of(context).pushReplacementNamed(login);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Shopping'),
          actions: [
            IconButton(
              onPressed: _handleLogout,
              icon: const Icon(Icons.logout),
            ),
            IconButton(
              onPressed: () => _themeBloc.add(const ToggleThemeEvent()),
              icon: BlocBuilder<ThemeBloc, ThemeState>(
                builder: (context, state) {
                  return Icon(
                    state.isDarkTheme ? Icons.dark_mode : Icons.light_mode,
                  );
                },
              ),
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                child: Text('Drawer Header'),
              ),
              ListTile(
                leading: const Icon(Icons.inventory_2),
                title: const Text('Products'),
                onTap: () => Navigator.of(context).pushNamed(products),
              ),
              const Divider(thickness: 2),
              ListTile(
                leading: const Icon(Icons.shopping_cart),
                title: const Text('Pending carts'),
                onTap: () => Navigator.of(context).pushNamed(pendingOrders),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => Navigator.of(context).pushNamed(createOrder),
          label: const Text('Create cart'),
          icon: const Icon(Icons.add_shopping_cart),
        ),
        body: Column(),
      ),
    );
  }
}
