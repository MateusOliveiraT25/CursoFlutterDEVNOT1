import 'package:flutter/material.dart';
import 'package:sa3_lista_tarefas/ModelTarefas.dart';
import 'package:sa3_lista_tarefas/ViewLogin.dart'; // Importe a tela de login
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sa3_lista_tarefas/TarefasController.dart';

// Página de lista de tarefas, um StatefulWidget
class ListaTarefaPage extends StatefulWidget {
  final String email;

  ListaTarefaPage({required this.email});

  @override
  _ListaTarefaPageState createState() => _ListaTarefaPageState(email: email);
}

class _ListaTarefaPageState extends State<ListaTarefaPage> {
  bool _showCompletedTasks =
      false; // Estado para controlar se devemos exibir apenas tarefas concluídas
  List<Tarefa> tasks = []; // Lista de tarefas
  final TextEditingController _controller =
      TextEditingController(); // Controlador para o campo de texto
  late ListaTarefaController _listaTarefaController;
  final String email;

  _ListaTarefaPageState({required this.email}) {
    _listaTarefaController = ListaTarefaController(email: email);
  }

  @override
  void initState() {
    super.initState();
    _loadTasks(); // Carregar tarefas ao iniciar
  }

  // Método para carregar tarefas
  Future<void> _loadTasks() async {
    List<Map<String, dynamic>> loadedTasks =
        await _listaTarefaController.loadTasks();
    setState(() {
      tasks = loadedTasks
          .map((task) =>
              Tarefa(titulo: task['titulo'], concluida: task['concluida']))
          .toList();
    });
  }

  // Método para salvar tarefas
  Future<void> _saveTasks() async {
    List<Map<String, dynamic>> taskMapList = tasks
        .map((tarefa) =>
            {'titulo': tarefa.titulo, 'concluida': tarefa.concluida})
        .toList();
    await _listaTarefaController.saveTasks(taskMapList);
  }

  // Método para alternar a exibição de tarefas concluídas
  void _toggleShowCompletedTasks() {
    setState(() {
      _showCompletedTasks = !_showCompletedTasks;
    });
  }

  // Método para fazer logout
  void _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('${email}email');
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
          builder: (context) =>
              LoginScreen()), // Navegar para a tela de login e remover todas as outras rotas da pilha
      (Route<dynamic> route) => false,
    );
  }

  // Método para excluir uma tarefa
  void _deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
      _saveTasks();
    });
  }

  // Método para atualizar uma tarefa
  void _updateTask(int index) {
    showDialog(
      context: context,
      builder: (context) {
        final TextEditingController _updateController =
            TextEditingController(text: tasks[index].titulo);
        return AlertDialog(
          title: Text('Atualizar Tarefa'),
          content: TextField(
            controller: _updateController,
            decoration: InputDecoration(
              hintText: 'Editar tarefa',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  tasks[index].titulo = _updateController.text;
                  _saveTasks();
                  Navigator.of(context).pop();
                });
              },
              child: Text('Atualizar'),
            ),
          ],
        );
      },
    );
  }

  // Método para alternar o estado de conclusão de uma tarefa
  void _toggleTaskCompleted(int index) {
    String taskTitle = tasks[index].titulo.trim(); // Remover espaços em branco
    if (taskTitle.isNotEmpty) {
      setState(() {
        tasks[index].concluida = !tasks[index].concluida;
        _saveTasks(); // Salva as tarefas atualizadas
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tarefas'),
        actions: <Widget>[
          // Botão para alternar a exibição de tarefas concluídas
          IconButton(
            icon: Icon(Icons.filter_alt),
            onPressed: _toggleShowCompletedTasks,
            tooltip: _showCompletedTasks
                ? 'Exibir todas as tarefas'
                : 'Exibir apenas tarefas concluídas',
          ),
          // Botão para fazer logout
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: ListView.builder(
        // Usamos um operador ternário para decidir quantas tarefas exibir com base no estado _showCompletedTasks
        itemCount: _showCompletedTasks
            ? tasks.length
            : tasks.where((task) => !task.concluida).length,
        itemBuilder: (context, index) {
          // Obtemos a lista de tarefas a serem exibidas com base no estado _showCompletedTasks
          List<Tarefa> displayedTasks = _showCompletedTasks
              ? tasks
              : tasks.where((task) => !task.concluida).toList();
          // Obtemos a tarefa na lista filtrada pelo índice atual
          Tarefa task = displayedTasks[index];
          return ListTile(
            title: Text(
              task.titulo,
              style: TextStyle(
                decoration: task.concluida ? TextDecoration.lineThrough : null,
              ),
            ),
            onTap: () => _updateTask(tasks.indexOf(task)),
            onLongPress: () => _deleteTask(tasks.indexOf(task)),
            trailing: Checkbox(
              value: task.concluida,
              onChanged: (value) => _toggleTaskCompleted(tasks.indexOf(task)),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Nova Tarefa'),
                content: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Digite a tarefa',
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      String newTaskTitle = _controller.text.trim();
                      if (newTaskTitle.isNotEmpty) {
                        setState(() {
                          tasks.add(Tarefa(titulo: newTaskTitle));
                          _saveTasks();
                          _controller.clear();
                          Navigator.of(context).pop();
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Por favor, insira o título da tarefa'),
                        ));
                      }
                    },
                    child: Text('Adicionar'),
                  ),
                  TextButton(
                    onPressed: () {
                      _controller.clear();
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancelar'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
