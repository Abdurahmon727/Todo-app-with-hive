import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/Pages/vars.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: Drawer(),
        appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent,
          title: const Text('Todo List'),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.lightBlueAccent,
          child: const Icon(Icons.add),
          onPressed: () {
            String? newOne;
            showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: Container(
                        color: const Color(0xFF757575),
                        child: Container(
                          padding: const EdgeInsets.all(30),
                          decoration: const BoxDecoration(
                              color: CupertinoColors.white,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  topLeft: Radius.circular(20))),
                          child: Column(children: [
                            const Text(
                              'Add Task',
                              style: TextStyle(
                                  fontSize: 30, color: Colors.lightBlueAccent),
                            ),
                            TextField(
                              autofocus: true,
                              textAlign: TextAlign.center,
                              onChanged: (value) {
                                if (value.isEmpty) {
                                  newOne = null;
                                } else {
                                  newOne = value;
                                }
                              },
                            ),
                            const SizedBox(height: 20),
                            GestureDetector(
                              onTap: () {
                                if (newOne != null) {
                                  setState(() {
                                    tasks.add(newOne ?? '');
                                    isChecked.add(false);
                                  });
                                  localFile.put('tasks', tasks);
                                  localFile.put('checks', isChecked);
                                }

                                Navigator.pop(context);
                              },
                              child: Container(
                                height: 50,
                                width: double.infinity,
                                child: const Center(
                                  child: Text('Add',
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white)),
                                ),
                                decoration: const BoxDecoration(
                                    color: Colors.lightBlueAccent,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                              ),
                            )
                          ]),
                        ),
                      ),
                    ),
                  );
                });
          },
        ),
        backgroundColor: Colors.lightBlueAccent,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(
                left: 30,
              ),
              child: SizedBox(
                  height: 30,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('${tasks.length} Tasks, ',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18)),
                  )),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15))),
                child: ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        trailing: Checkbox(
                          value: isChecked[index],
                          onChanged: (value) {
                            setState(() {
                              isChecked[index] = value ?? false;
                            });
                            localFile.put('checks', isChecked);
                          },
                        ),
                        title: GestureDetector(
                          child: Text(
                            '${tasks[index]}',
                            style: TextStyle(
                                decoration: (isChecked[index])
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none),
                          ),
                          onLongPress: () {
                            //todo
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('Deleting todo'),
                                content:
                                    const Text('You are deleting your todo'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        tasks.removeAt(index);
                                        isChecked.removeAt(index);
                                        isCrossed.removeAt(index);
                                      });
                                      localFile.put('tasks', tasks);
                                      localFile.put('checks', isChecked);
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Delete'),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
