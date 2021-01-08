import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/app/modules/home/home_controller.dart';
import 'package:to_do_list/app/modules/new_task/new_task_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (BuildContext context, controller, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Atividades',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            backgroundColor: Colors.white,
          ),
          bottomNavigationBar: FFNavigationBar(
            onSelectTab: (index) =>
                controller.changeSelectedTab(context, index),
            items: [
              FFNavigationBarItem(
                iconData: Icons.check_circle,
                label: 'Finalizados',
              ),
              FFNavigationBarItem(
                iconData: Icons.view_week,
                label: 'Semanal',
              ),
              FFNavigationBarItem(
                iconData: Icons.calendar_today,
                label: 'Calendário',
              ),
            ],
            selectedIndex: controller.selectedTab,
            theme: FFNavigationBarTheme(
              barHeight: 70,
              itemWidth: 60,
              barBackgroundColor: Theme.of(context).primaryColor,
              unselectedItemIconColor: Colors.white,
              unselectedItemLabelColor: Colors.white,
              selectedItemBackgroundColor: Colors.white,
              selectedItemIconColor: Theme.of(context).primaryColor,
              selectedItemBorderColor: Theme.of(context).primaryColor,
            ),
          ),
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              itemCount: controller.listTodos?.keys?.length ?? 0,
              itemBuilder: (_, index) {
                var todos = controller.listTodos.values.elementAt(index);
                var dayKey = controller.listTodos.keys.elementAt(index);
                controller.setDayTitle(index, dayKey);
                return Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, right: 10, left: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              controller.day,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 30),
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              await Navigator.pushNamed(
                                  context, NewTaskPage.route,
                                  arguments: dayKey);
                              controller.update();
                            },
                            icon: Icon(
                              Icons.add_circle,
                              color: Theme.of(context).primaryColor,
                              size: 30,
                            ),
                          )
                        ],
                      ),
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: todos.length ?? 0,
                        itemBuilder: (_, index) {
                          var todo = todos[index];
                          var todoHora =
                              '${todo.dataHora.hour.toString().padLeft(2, '0')}:${todo.dataHora.minute.toString().padLeft(2, '0')}';
                          return Dismissible(
                            key: Key(todo.id.toString()),
                            direction: DismissDirection.endToStart,
                            background: Container(
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.all(10),
                              color: Colors.red,
                              child: Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                            onDismissed: (_) {
                              controller.delete(todo);
                              todos.removeAt(index);
                            },
                            confirmDismiss: (_) =>
                                _buildConfirmDismiss(context),
                            child: ListTile(
                              title: Text(
                                todo.descricao,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    decoration: todo.finalizado
                                        ? TextDecoration.lineThrough
                                        : null),
                              ),
                              leading: Checkbox(
                                activeColor: Theme.of(context).primaryColor,
                                onChanged: (bool value) {
                                  controller.changeTodoStatus(todo);
                                },
                                value: todo.finalizado,
                              ),
                              trailing: Text(
                                todoHora,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    decoration: todo.finalizado
                                        ? TextDecoration.lineThrough
                                        : null),
                              ),
                            ),
                          );
                        })
                  ],
                );
              },
            ),
          ),
          //drawer: Drawer(),
        );
      },
    );
  }

  Future<bool> _buildConfirmDismiss(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Tem certeza que deseja excluir o item?',
          textAlign: TextAlign.center,
        ),
        actions: [
          FlatButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Sim'),
          ),
          FlatButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Não'),
          ),
        ],
      ),
    );
  }
}
