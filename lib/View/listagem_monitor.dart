import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../Model/monitor.dart';
import '../ViewModel/monitorViewModel.dart';

class MonitorCarrosel extends StatefulWidget {
  const MonitorCarrosel({super.key});

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
    return Scaffold(
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

          
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final monitors = snapshot.data!;

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
                      enableInfiniteScroll: true,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                    ),
                  ),

                  // Indicadores dinâmicos (Bolinhas)
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

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        image: DecorationImage(
          image: NetworkImage(monitor.foto), 
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
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
    );
  }
}
