import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/blocs/home/home_bloc.dart';
import 'package:shopping/blocs/home/home_event.dart';
import 'package:shopping/blocs/home/home_state.dart';
import 'package:shopping/ui/paths.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read();
  }

  void _handleLogout() {
    _bloc.add(const LogoutEvent());
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
            )
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
                onTap: () => Navigator.of(context).pushNamed(products),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          label: const Text('Create cart'),
          icon: const Icon(Icons.add_shopping_cart),
        ),
        body: Column(),
      ),
    );
  }
}
