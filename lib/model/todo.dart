class ToDo {
  String? id;
  String? todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false
  });

  static List<ToDo> todoList() {
    return [
      ToDo(id: '01', todoText: 'Gym Workout', isDone: true ),
      ToDo(id: '02', todoText: 'Breakfast Meal', isDone: true ),
      ToDo(id: '03', todoText: 'Study Hour', ),
      ToDo(id: '04', todoText: 'Check Emails', ),
      ToDo(id: '05', todoText: 'LeetCode', ),
      ToDo(id: '06', todoText: '30 Minutes Nap', ),
    ];
  }
}