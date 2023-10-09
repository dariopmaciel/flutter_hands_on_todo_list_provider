//esta classe controla o total de tarefas e o total de tarefas finalizadas.
//Usando estas informações para compor o CARD,  QTD tarefas totais e QTD tarefas finalizadas, na farra de tarefas

class TotalTasksModel {
  final int totalTasks;
  final int totalTasksFinisk;
  
  TotalTasksModel({
    required this.totalTasks,
    required this.totalTasksFinisk,
  });
}
