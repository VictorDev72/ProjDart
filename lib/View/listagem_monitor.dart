import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_application_3/View/detalhes_monitor.dart';
import '../Model/monitor.dart';
import '../ViewModel/monitorViewModel.dart';

class MonitorCarrosel extends StatefulWidget {
  final String? diaFiltro;

  const MonitorCarrosel({super.key, this.diaFiltro});

  @override
  _MonitorCarroselState createState() => _MonitorCarroselState();  
}

class _MonitorCarroselState extends State<MonitorCarrosel> {
  final Monitorviewmodel _monitorViewModel = Monitorviewmodel();
  final CarouselSliderController _controller = CarouselSliderController();
  int _currentIndex = 0; 
  late Future<List<Monitor>> _fetchMonitoresFuture;

  @override
  void initState() {
    super.initState();
    _fetchMonitoresFuture = _monitorViewModel.fetchMonitores();
  }

  @override
  Widget build(BuildContext context) {
    String tituloTela = widget.diaFiltro != null 
        ? 'Monitores: ${widget.diaFiltro}' 
        : 'Monitoria Facil';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          tituloTela,
          style: TextStyle(
              fontSize: 25,
              color: Colors.grey[700],
              fontFamily: 'Roboto',
            ),
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
        ),
      ),
      backgroundColor: const Color(0xFF1E2633),
      body: FutureBuilder<List<Monitor>>(
        future: _fetchMonitoresFuture,
        builder: (context, snapshot) {
          
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          }
          
          if (snapshot.hasError) {
            return const Center(
              child: Text(
                'Ocorreu um erro ao carregar os dados.',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            );
          }

          if (snapshot.hasData) {
            List<Monitor> monitors = snapshot.data!;
            
            if (widget.diaFiltro != null) {
              monitors = _monitorViewModel.filtrarMonitoresPorDia(monitors, widget.diaFiltro!);
            }

            if (monitors.isEmpty) {
              return const Center(
                child: Text(
                  'Nenhum monitor disponível para este dia.',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              );
            }

            return Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CarouselSlider.builder(
                    carouselController: _controller,
                    itemCount: monitors.length,
                    itemBuilder: (context, index, realIndex) {
                      return _buildMonitorCard(monitors[index]);
                    },
                    options: CarouselOptions(
                      height: 380,
                      viewportFraction: 0.45,
                      enlargeCenterPage: true,
                      enlargeStrategy: CenterPageEnlargeStrategy.scale,
                      enableInfiniteScroll: monitors.length > 1,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                    ),
                  ),

                  Positioned(
                    bottom: 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: monitors.asMap().entries.map((entry) {
                        return Container(
                          width: 7.0,
                          height: 7.0,
                          margin: const EdgeInsets.symmetric(horizontal: 4.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withValues(
                              alpha: _currentIndex == entry.key ? 0.9 : 0.3,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            );
          }

          return const Center(
            child: Text(
              'Nenhum monitor encontrado.',
              style: TextStyle(color: Colors.white),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMonitorCard(Monitor monitor) {
    final diasDisponiveis = monitor.horarios.keys.join(', ');

    return GestureDetector(
        onTap: () {
        // 1. Navega para a tela de detalhes passando o monitor selecionado
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetalhesMonitor(monitor: monitor),
          ),
        );
      },
      child:  Container(
        width: double.infinity, 
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.grey[800], 
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: Stack(
            fit: StackFit.expand, 
            children: [
              Image.network(
                monitor.foto,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.white24),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.broken_image, color: Colors.white38, size: 40),
                        SizedBox(height: 8),
                        Text(
                          'Erro ao carregar foto',
                          style: TextStyle(color: Colors.white38, fontSize: 12),
                        ),
                      ],
                    ),
                  );
                },
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.85),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                left: 15,
                right: 15,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      monitor.nome,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Dias: $diasDisponiveis', 
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    );
    
  }
}
