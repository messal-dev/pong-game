import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/controller.dart';
import './models/item.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isInit = false;

  void startHandler() {
    final provider = Provider.of<Controller>(context, listen: false);
    provider.start();
  }

  void onTapHandler(int value) {
    final provider = Provider.of<Controller>(context, listen: false);
    provider.checkValue(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Game')),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Consumer<Controller>(
                builder: (ctx, provider, _) {
                  if (!isInit) {
                    provider.init();
                    isInit = !isInit;
                  }

                  return Container(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      itemCount: provider.data.length,
                      itemBuilder: (ctx, index) {
                        final items = provider.data;
                        final Item data =
                            index > items.length ? 0 : items[index];

                        return Material(
                          child: InkWell(
                            onTap: () => onTapHandler(data.value),
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: data.isError
                                    ? Colors.red
                                    : data.isChecked
                                        ? Colors.white
                                        : Colors.green,
                                border: Border.all(color: Colors.blue),
                              ),
                              child: data.isChecked
                                  ? Text(
                                      data.randomValue > 10
                                          ? ''
                                          : data.randomValue.toString(),
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    )
                                  : null,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            Center(
              child: TextButton(
                child: Text('Start'),
                onPressed: startHandler,
              ),
            )
          ],
        ),
      ),
    );
  }
}
