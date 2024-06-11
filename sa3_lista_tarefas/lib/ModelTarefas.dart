// Definição da classe Tarefa
class Tarefa {
  String titulo;
  bool concluida;

  Tarefa({required this.titulo, this.concluida = false});
}

// Definição da classe Tarefas
class Tarefas {
  String descricao; // Descrição da tarefa
  bool concluida; // Indica se a tarefa foi concluída ou não
  DateTime dataHora; // Data e hora da tarefa

  // Construtor da classe Tarefas
  Tarefas({
    required this.descricao, // Parâmetro obrigatório: descrição da tarefa
    required this.concluida, // Parâmetro obrigatório: estado de conclusão da tarefa
    required this.dataHora, // Parâmetro obrigatório: data e hora da tarefa
  });
}
