import 'package:flutter/material.dart';
import 'package:flutter_application_3/Model/monitor.dart';

class DetalhesMonitor extends StatelessWidget {
  final Monitor monitor;
  
  const DetalhesMonitor({
    super.key,
    required this.monitor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Mantém a cor de fundo escura coerente com o carrossel
      backgroundColor: const Color(0xFF1E2633),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Detalhes do Monitor',
          style: TextStyle(
            fontSize: 22,
            color: Colors.grey[300],
            fontFamily: 'Roboto',
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Foto de perfil destacada com borda sutil
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white24, width: 4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      )
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 90,
                    backgroundColor: Colors.grey[800],
                    backgroundImage: NetworkImage(monitor.foto),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              
              // Nome do Monitor
              Text(
                monitor.nome,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                ),
              ),
              const SizedBox(height: 32),
              
              // Alinhamento à esquerda para a seção de horários
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Horários de Atendimento',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              
              // Lista de horários estilizada em Cards (substituindo a Table padrão)
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: monitor.horarios.entries.map((entry) {
                  final dia = entry.key;
                  final horarios = entry.value.join('  •  ');
    

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[800]?.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(color: Colors.white10),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                      leading: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.blue.withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.calendar_today, color: Colors.blue, size: 20),
                      ),
                      title: Text(
                        // Deixa a primeira letra maiúscula (ex: "segunda" -> "Segunda")
                        dia.isNotEmpty ? '${dia[0].toUpperCase()}${dia.substring(1)}' : dia,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          horarios,
                          style: TextStyle(
                            color: Colors.grey[300],
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
