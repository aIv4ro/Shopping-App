import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/blocs/home/home_bloc.dart';
import 'package:shopping/blocs/home/home_event.dart';
import 'package:shopping/blocs/home/home_state.dart';
import 'package:shopping/ui/pages/home/widgets/create_product_dialog.dart';
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => BlocProvider(
                create: (context) => _bloc,
                child: const CreateProductPopup(),
              ),
            );
          },
          child: const Icon(Icons.create),
        ),
        body: Column(),
      ),
    );
  }
}
