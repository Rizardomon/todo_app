import 'package:flutter/cupertino.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      title: 'Cupertino App',
      home: CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('data'),
        ),
        backgroundColor: CupertinoColors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Cupertino App'),
              CupertinoButton(
                child: const Text('Teste'),
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
