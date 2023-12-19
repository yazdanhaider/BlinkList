import 'package:blink_list/model/todo.dart';
import 'package:flutter/material.dart';

class ToDoItem extends StatelessWidget {
  final ToDo todo;
  final onToDoChanged;
  final onDeleteItem;

  const ToDoItem({Key? key, required this.todo, required this.onToDoChanged, required this.onDeleteItem,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          onToDoChanged(todo);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        tileColor: Colors.white,
        leading: Icon(todo.isDone? Icons.check_box : Icons.check_box_outline_blank,
            color: Colors.deepPurple),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              todo.todoText!,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                decoration: todo.isDone? TextDecoration.lineThrough : null,
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: () {
                onDeleteItem(todo.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}