import 'package:flutter/widgets.dart';

class AccountTab extends StatefulWidget {
  const AccountTab({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AccountTabState();
}

class AccountTabState extends State<AccountTab> {
  @override
  Widget build(BuildContext context) {
    return const Text('Index 2: Account');
  }
}
