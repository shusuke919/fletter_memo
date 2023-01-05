import 'package:flutter/material.dart';

class AddMemoPage extends StatelessWidget {
  const AddMemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('っっっd'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Text('タイトル'),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey)
              ),
                width: MediaQuery.of(context).size.width*0.8,
            child: TextField(
              decoration: InputDecoration(border: InputBorder.none,
              contentPadding: const EdgeInsets.only(left: 10)
              ),
            )
            ),
          ],
        ),
      ),
    );
  }
}
