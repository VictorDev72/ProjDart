import 'package:flutter/material.dart';


class MinhaTela extends StatefulWidget {

  const MinhaTela({super.key});

  @override
  State<MinhaTela> createState() =>  _BuildTela();
}

  class _BuildTela extends State<MinhaTela> {

    TextEditingController pesoController = TextEditingController();
    TextEditingController alturaController = TextEditingController();
    
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    void clearFields(){

    }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Calcula IMC", style: TextStyle(fontSize: 30, fontFamily: "Calibri", fontWeight: FontWeight.bold, color:Colors.amber)),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 184, 57, 206),
        actions: <Widget>[
          IconButton(
            onPressed: clearFields , 
            icon: Icon(Icons.refresh)
          )
        ]
      ) ,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.access_alarm_sharp,
                size: 100.0,
                color: Colors.purple
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  keyboardType: TextInputType.numberWithOptions(),
                  decoration: InputDecoration(
                    labelText: "Altura (cm)",
                    labelStyle: TextStyle(color: Colors.blue, fontSize: 30),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))
                    )
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.deepOrange, fontSize: 30),
                  controller: alturaController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Digitar Altura";
                    }
                    return null;
                  }
                )
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  keyboardType: TextInputType.numberWithOptions(),
                  decoration: InputDecoration(
                    labelText: "Peso (kg)",
                    labelStyle: TextStyle(color: Colors.blue, fontSize: 30),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))
                    )
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.deepOrange, fontSize: 30),
                  controller: pesoController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Digitar Peso";
                    }
                    return null;
                  }
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
