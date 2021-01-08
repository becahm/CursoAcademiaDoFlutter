import 'package:flutter/material.dart';

class TimeComponent extends StatefulWidget {
  DateTime date;
  ValueChanged<DateTime> onSelectedTime;
  TimeComponent({
    Key key,
    this.date,
    this.onSelectedTime,
  }) : super(key: key);

  @override
  _TimeComponentState createState() => _TimeComponentState();
}

class _TimeComponentState extends State<TimeComponent> {
  final List<int> _hours = List.generate(24, (index) => index++);
  final List<int> _min = List.generate(60, (index) => index++);
  final List<int> _sec = List.generate(60, (index) => index++);

  String _selectedHour = '00';
  String _selectedMin = '00';
  String _selectedSec = '00';

  void invokeCallback() {
    var newDate = DateTime(
        widget.date.year,
        widget.date.month,
        widget.date.day,
        int.parse(_selectedHour),
        int.parse(_selectedMin),
        int.parse(_selectedSec));
    widget.onSelectedTime(newDate);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildBox(_hours, (hour) {
            _selectedHour = hour;
            invokeCallback();
          }),
          _buildBox(_min, (min) {
            _selectedMin = min;
            invokeCallback();
          }),
          _buildBox(_sec, (sec) {
            _selectedSec = sec;
            invokeCallback();
          }),
        ],
      ),
    );
  }

  Widget _buildBox(List<int> options, ValueChanged<String> onChanged) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Theme.of(context).primaryColor,
        boxShadow: [
          BoxShadow(
              blurRadius: 4,
              spreadRadius: 0,
              offset: Offset(2, 5),
              color: Theme.of(context).primaryColor)
        ],
      ),
      child: ListWheelScrollView(
        onSelectedItemChanged: (index) {
          onChanged(index.toString().padLeft(2, '0'));
        },
        physics: FixedExtentScrollPhysics(),
        perspective: 0.007,
        itemExtent: 60,
        children: options
            .map<Text>((e) => Text(e.toString().padLeft(2, '0'),
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                )))
            .toList(),
      ),
    );
  }
}
