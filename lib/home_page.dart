import 'package:flutter/material.dart';
import 'package:blink_list/todo_item.dart';
import 'package:blink_list/model/todo.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _BlinkListState();
}

class _BlinkListState extends State<HomePage> {
  final todosList = ToDo.todoList();
  final _todoController = TextEditingController();
  List<ToDo> _foundToDo = [];
  bool isDarkMode = false;

  @override
  void initState() {
    _foundToDo = todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        appBarTheme: AppBarTheme(
          backgroundColor: isDarkMode ? Colors.grey[900] : Colors.deepPurple[50],
          elevation: 0,
        ),
      ),
      home: Scaffold(
        backgroundColor: isDarkMode ? Colors.grey[900] : Colors.deepPurple[50],
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: [
                  Icon(
                    Icons.menu_rounded,
                    color: isDarkMode ? Colors.white : Colors.black87,
                    size: 30,
                  ),
                  SizedBox(width: 130),
                  Center(
                    child: Text(
                      'BlinkList',
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black87,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isDarkMode = !isDarkMode;
                  });
                },
                child: Container(
                  height: 40,
                  width: 40,
                  child: ClipRRect(
                    child: Icon(
                      Icons.nights_stay_rounded,
                      color: isDarkMode ? Colors.white : Colors.black87,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Container(
                child: Column(
                  children: [
                    searchBox(),
                    Expanded(
                      child: ListView(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 50, bottom: 20,),
                            child: Text(
                              "All ToDos",
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),

                          for (ToDo todo in _foundToDo.reversed)
                            ToDoItem(
                              todo: todo,
                              onToDoChanged: _handleToDoChange,
                              onDeleteItem: _deleteToDoItem,
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(children: [
                Expanded(child: Container(
                  margin: EdgeInsets.only(bottom: 20, right: 20, left: 20
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5,),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: _todoController,
                    style: TextStyle(
                      color: isDarkMode ? Colors.black : Colors.black,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Add a new todo item',
                      hintStyle: TextStyle(
                        color: isDarkMode ? Colors.grey : Colors.black54,
                      ),
                      border: InputBorder.none,
                    ),
                  ),


                ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                  ),
                  child: ElevatedButton(
                    child: Text('+', style: TextStyle(fontSize: 40,),),
                    onPressed: () {
                      _addToDoItem(_todoController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      minimumSize: Size(60, 60),
                      elevation: 10,
                    ),
                  ),

                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  // Function of task is done or not?
  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }
  // Function of task to delete.
  void _deleteToDoItem(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }
  // Function of task to add new note.
  void _addToDoItem(String toDo) {
    setState(() {
      todosList.add(ToDo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        todoText: toDo,
      ));
    });
    _todoController.clear();
  }

  // Function to search todo item.
  void _runFilter (String enteredKeyword){
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todosList;
    } else {
      results = todosList.where((item) => item.todoText!.toLowerCase().contains(enteredKeyword.toLowerCase())).toList();
    }
    setState(() {
      _foundToDo = results;
    });

  }

  Widget searchBox() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        style: TextStyle(
          color: isDarkMode ? Colors.black : Colors.black87,
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.black87,
            size: 18,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 25,
            minWidth: 25,
          ),
          border: InputBorder.none,
          hintText: "Search",
          hintStyle: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }

}
