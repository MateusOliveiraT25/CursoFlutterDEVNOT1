import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Classe para controlar as operações relacionadas às tarefas em SharedPreferences
class ListaTarefaController {
  final String
      email; // E-mail do usuário para diferenciar as chaves SharedPreferences
  late SharedPreferences
      _prefs; // Objeto SharedPreferences para acessar os dados

  // Construtor da classe
  ListaTarefaController({required this.email});

  // Método para carregar as tarefas do SharedPreferences
  Future<List<Map<String, dynamic>>> loadTasks() async {
    // Obter uma instância do SharedPreferences
    _prefs = await SharedPreferences.getInstance();

    // Obter a lista de tarefas e a lista de tarefas concluídas do SharedPreferences
    List<String>? taskList = _prefs.getStringList('${email}tasks');
    List<String>? taskCompletedList =
        _prefs.getStringList('${email}tasks_completed');

    // Verificar se as listas não são nulas e têm o mesmo tamanho
    if (taskList != null &&
        taskCompletedList != null &&
        taskList.length == taskCompletedList.length) {
      // Se forem válidas, criar uma lista de mapas contendo as tarefas e seus estados de conclusão
      List<Map<String, dynamic>> tasks = [];
      for (int i = 0; i < taskList.length; i++) {
        tasks.add({
          'titulo': taskList[i],
          'concluida': taskCompletedList[i] == 'true'
        });
      }
      return tasks; // Retornar a lista de tarefas
    } else {
      return []; // Caso contrário, retornar uma lista vazia
    }
  }

  // Método para salvar as tarefas no SharedPreferences
  Future<void> saveTasks(List<Map<String, dynamic>> tasks) async {
    // Obter uma instância do SharedPreferences
    _prefs = await SharedPreferences.getInstance();

    // Criar listas separadas para os títulos das tarefas e seus estados de conclusão
    List<String> taskList = [];
    List<String> taskCompletedList = [];

    // Preencher as listas com os dados das tarefas fornecidas
    for (int i = 0; i < tasks.length; i++) {
      taskList.add(tasks[i]['titulo']); // Adicionar o título da tarefa à lista
      taskCompletedList.add(tasks[i]['concluida']
          ? 'true'
          : 'false'); // Adicionar o estado de conclusão à lista
    }

    // Salvar as listas no SharedPreferences usando chaves específicas para o usuário
    await _prefs.setStringList('${email}tasks', taskList);
    await _prefs.setStringList('${email}tasks_completed', taskCompletedList);
  }

  // Método para adicionar uma nova tarefa
  Future<void> addTask(String task) async {
    // Carregar as tarefas existentes do SharedPreferences
    List<Map<String, dynamic>> currentTasks = await loadTasks();

    // Adicionar a nova tarefa à lista de tarefas existentes
    currentTasks.add({'titulo': task, 'concluida': false});

    // Salvar as tarefas atualizadas no SharedPreferences
    await saveTasks(currentTasks);
  }

  // Método para atualizar uma tarefa existente
  Future<void> updateTask(int index, String newTask) async {
    // Carregar as tarefas existentes do SharedPreferences
    List<Map<String, dynamic>> currentTasks = await loadTasks();

    // Atualizar o título da tarefa no índice fornecido
    currentTasks[index]['titulo'] = newTask;

    // Salvar as tarefas atualizadas no SharedPreferences
    await saveTasks(currentTasks);
  }

  // Método para excluir uma tarefa
  Future<void> deleteTask(int index) async {
    // Carregar as tarefas existentes do SharedPreferences
    List<Map<String, dynamic>> currentTasks = await loadTasks();

    // Remover a tarefa no índice fornecido
    currentTasks.removeAt(index);

    // Salvar as tarefas atualizadas no SharedPreferences
    await saveTasks(currentTasks);
  }

  // Método para marcar uma tarefa como concluída
  Future<void> markTaskCompleted(int index) async {
    // Carregar as tarefas existentes do SharedPreferences
    List<Map<String, dynamic>> currentTasks = await loadTasks();

    // Marcar a tarefa no índice fornecido como concluída
    currentTasks[index]['concluida'] = true;

    // Salvar as tarefas atualizadas no SharedPreferences
    await saveTasks(currentTasks);
  }
}
