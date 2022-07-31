import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/bloc/home/home_bloc.dart';
import 'package:shopping/bloc/home/home_event.dart';
import 'package:shopping/bloc/home/home_state.dart';
import 'package:shopping/pages/home/account_tab.dart';
import 'package:shopping/pages/home/home_tab.dart';
import 'package:shopping/pages/home/pending_tab.dart';
import 'package:shopping/routes/paths.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    HomeTab(),
    PendingTab(),
    AccountTab(),
  ];

  void _onItemTapped(index) => setState(() => _selectedIndex = index);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<HomeBloc>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping'),
        actions: [
          BlocListener<HomeBloc, HomeState>(
            listener: (context, state) {
              if (state.status == HomeStatus.loggedOut) {
                Navigator.of(context).pushReplacementNamed(login);
              }
            },
            child: IconButton(
              onPressed: () => bloc.add(const CloseSession()),
              icon: const Icon(Icons.logout),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Pending',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(createOrder);
        },
        child: const Icon(Icons.add),
      ),
      body: _pages.elementAt(_selectedIndex),
    );
  }
}