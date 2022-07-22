import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/repositories/auth_repository.dart';
import 'package:shopping/routes/paths.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late AuthRepository authRepository;
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    Text(
      'Index 0: Home',
    ),
    Text(
      'Index 1: Business',
    ),
    Text(
      'Index 2: School',
    ),
  ];

  void _onItemTapped(index) => setState(() => _selectedIndex = index);

  @override
  void initState() {
    super.initState();
    authRepository = context.read();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      appBar: AppBar(
        title: const Text('Shopping'),
        actions: [
          IconButton(
            onPressed: () {
              authRepository.logout().then(
                (value) {
                  Navigator.of(context).pushReplacementNamed(login);
                },
              );
            },
            icon: const Icon(
              Icons.logout,
            ),
          )
        ],
      ),
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
    );
  }
}
