


class Monitor {
  final int id;
  final String nome;
  final String foto;
  final Map<String, List<String>> horarios; 

  Monitor({required this.id, required this.nome, required this.foto, required this.horarios});

  factory Monitor.fromJson(Map<String, dynamic> json) {
    var horariosJson = json['horarios'] as Map<String, dynamic>;
    
    Map<String, List<String>> mapaHorarios = horariosJson.map(
      (chave, valor) => MapEntry(chave, List<String>.from(valor)),
    );

    return Monitor(
      id: json['id'],
      nome: json['nome'],
      foto: json['foto'],
      horarios: mapaHorarios,
    );
  }
}
