//import 'package:flutter/material.dart';
import 'package:flutter_application_3/Model/monitor.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Monitorviewmodel {
  Future<List<Monitor>> fetchMonitores() async {
    final url = Uri.parse('https://api.mockfly.dev/mocks/eb65c3bc-75eb-4a79-9c6a-478d74994037/monitores');
    List<Monitor> monitores = [];
    
    try {
      final response = await http.get(url);
    
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        var listaJson = data is List ? data : data['monitores'] ?? data['data'];

        if (listaJson != null) {
          for (var monitorData in listaJson) {
            monitores.add(Monitor.fromJson(monitorData));
          }
        }
        return monitores;
      } else {
        print('Erro na requisição: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Erro de rede: $e');
      return [];
    }
  }
}
