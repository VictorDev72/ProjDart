import 'package:flutter/material.dart';
import 'package:flutter_application_3/View/listagem_monitor.dart';


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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0), 
                      child: Image.asset(
                        'assets/images/cotuca.png', 
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Monitorias',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),


            ListTile(
              leading: Icon(Icons.home),
              title: Text('Todos os Monitores'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MonitorCarrosel(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.calendar_month),
              title: Text('Segunda'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MonitorCarrosel(diaFiltro: 'segunda'),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.calendar_month),
              title: Text('Terça'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MonitorCarrosel(diaFiltro: 'terca'),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.calendar_month),
              title: Text('Quarta'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MonitorCarrosel(diaFiltro: 'quarta'),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.calendar_month),
              title: Text('Quinta'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MonitorCarrosel(diaFiltro: 'quinta'),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.calendar_month),
              title: Text('Sexta'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MonitorCarrosel(diaFiltro: 'sexta'), 
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.calendar_month),
              title: Text('Sabado'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MonitorCarrosel(diaFiltro: 'sabado'), 
                  ),
                );
              },
            ),

          ],
        ),
      ),

      body: Center(
        child:  Text(
          'Escolha uma opção no menu para começar!',
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey[700],
            fontFamily: 'Roboto',
          ),
        ),
      )
      
      );
        
        
        
  
  }
}