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
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
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
                      color: Color(0xFF757575),
                      child: Container(
                        padding: EdgeInsets.all(30),
                        decoration: BoxDecoration(
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
                          SizedBox(height: 20),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (newOne != null) {
                                  Tasks.add(newOne);
                                  isChecked.add(false);
                                  isCrossed.add(TextDecoration.none);
                                }
                              });
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
            padding: EdgeInsets.only(top: 60, left: 30, right: 30, bottom: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.list,
                    size: 30,
                  ),
                ),
                const SizedBox(height: 10),
                const Text('Todoey',
                    style: TextStyle(
                        fontSize: 50,
                        color: Colors.white,
                        fontWeight: FontWeight.w700)),
                Text('${Tasks.length} Tasks',
                    style: const TextStyle(color: Colors.white, fontSize: 18))
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15))),
              child: ListView.builder(
                  itemCount: Tasks.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      trailing: Checkbox(
                        value: isChecked[index],
                        onChanged: (value) {
                          setState(() {
                            if (value == true) {
                              isCrossed[index] = TextDecoration.lineThrough;
                            } else {
                              isCrossed[index] = TextDecoration.none;
                            }
                          });

                          isChecked[index] = value;
                        },
                      ),
                      title: GestureDetector(
                        child: Text(
                          '${Tasks[index]}',
                          style: TextStyle(decoration: isCrossed[index]),
                        ),
                        onLongPress: () {
                          setState(() {
                            Tasks.removeAt(index);
                            isChecked.removeAt(index);
                            isCrossed.removeAt(index);
                          });
                        },
                      ),
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }
}
