enum TipoTransacao { receita, despesa }

class Transacao {
  final String id;
  final String descricao;
  final double valor;
  final TipoTransacao tipo;
  final DateTime data;

  Transacao({
    required this.id,
    required this.descricao,
    required this.valor,
    required this.tipo,
    required this.data
  });

  Map<String, dynamic> toJson() {
    return {
      'descricao': descricao,
      'valor': valor,
      'tipo': tipo.toString()
    };
  }

  factory Transacao.fromJson(Map<String, dynamic> json) {
    return Transacao(
      id: json['id'] as String,
      descricao: json['descricao'] as String,
      valor: (json['valor'] as num).toDouble(),
      tipo: (json['tipo'] as String) == TipoTransacao.receita.toString() ? TipoTransacao.receita : TipoTransacao.despesa,
      data: DateTime.parse(json['created_at'] as String)
    );
  }

}