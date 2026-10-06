import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Monitoria Facil',
          style: TextStyle(
              fontSize: 25,
              color: Colors.grey[700],
              fontFamily: 'Roboto',
            ),
        ),
      ),
      body: Column(
        children:[
        Text(
          'Escolha uma opção no menu para começar!',
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey[700],
            fontFamily: 'Roboto',
          ),
        ),
        ButtonBar(
          alignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Ação do botão 1
              },
              child: Text('Botão 1'),
            ),
            ElevatedButton(
              onPressed: () {
                // Ação do botão 2
              },
              child: Text('Botão 2'),
            ),
            ElevatedButton(
              onPressed: () {
                // Ação do botão 3
              },
              child: Text('Botão 3'),
            ),
            ElevatedButton(
              onPressed: () {
                // Ação do botão 4
              },
              child: Text('Botão 4'),
            ),
            ElevatedButton(
              onPressed: () {
                // Ação do botão 5
              },
              child: Text('Botão 5'),
            ),
          ],
        ),

        ] 
        
      ),
    );
  }
}