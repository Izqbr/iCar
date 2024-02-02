
import 'package:flutter/material.dart';

class RefVariant extends StatelessWidget {
  const RefVariant({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 1));
          },
          child: CustomScrollView(
            slivers: <Widget>[
              SliverFillRemaining(
                child: Container(
                  color: Colors.blue,
                  child: const Center(
                    child: Text("No results found."),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
