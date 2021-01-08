import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/app/modules/new_task/new_task_controller.dart';
import 'package:to_do_list/app/shared/time_component.dart';

class NewTaskPage extends StatefulWidget {
  static String route = '/newTask';

  @override
  _NewTaskPageState createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<NewTaskController>(context, listen: false).addListener(() {
        var controller = context.read<NewTaskController>();
        if (controller.error != null) {
          _scaffoldKey.currentState
              .showSnackBar(SnackBar(content: Text(controller.error)));
        }
        if (controller.saved) {
          _scaffoldKey.currentState.showSnackBar(
              SnackBar(content: Text('Tarefa salva com sucesso!')));
          Future.delayed(Duration(seconds: 1), () => Navigator.pop(context));
        }
      });
    });
  }

  @override
  void dispose() {
    Provider.of<NewTaskController>(context, listen: false)
        .removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NewTaskController>(
      builder: (BuildContext context, controller, _) {
        return Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Form(
              key: controller.formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'NOVA TAREFA',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Data',
                      style: TextStyle(fontSize: 15, color: Colors.grey[500]),
                    ),
                    Text(
                      controller.formatedDay + controller.selectedTime,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Descrição da tarefa',
                      style: TextStyle(fontSize: 15, color: Colors.grey[500]),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Descrição obrigatória!';
                        }
                        return null;
                      },
                      controller: controller.tasktDescriptionController,
                      decoration: InputDecoration(border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Hora',
                      style: TextStyle(fontSize: 15, color: Colors.grey[500]),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TimeComponent(
                      date: controller.selectedDay,
                      onSelectedTime: (date) {
                        controller.refreshDate(date);
                      },
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    _buildButton(controller),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildButton(NewTaskController controller) {
    return InkWell(
      onTap: () {
        controller.save();
      },
      child: Center(
        child: AnimatedContainer(
          width: controller.saved ? 80 : MediaQuery.of(context).size.width,
          height: controller.saved ? 80 : 40,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              boxShadow: [
                controller.saved
                    ? BoxShadow(
                        color: Colors.grey,
                        blurRadius: 4,
                        spreadRadius: 3,
                        offset: Offset(3, 3))
                    : BoxShadow()
              ],
              borderRadius: controller.saved
                  ? BorderRadius.circular(100)
                  : BorderRadius.circular(0)),
          duration: Duration(milliseconds: 400),
          child: Center(
              child: controller.saved
                  ? Icon(
                      Icons.check,
                      color: Colors.white,
                    )
                  : Text(
                      'Salvar',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )),
        ),
      ),
    );
  }
}
