import 'package:flutter/material.dart';

class Example extends StatelessWidget {
  const Example({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: DataOwnerStatefull()
      ),
    );
  }
}

class DataOwnerStatefull extends StatefulWidget {
  const DataOwnerStatefull({Key? key}) : super(key: key);

  @override
  _DataOwnerStatefullState createState() => _DataOwnerStatefullState();
}

class _DataOwnerStatefullState extends State<DataOwnerStatefull> {
  var _value = 0;

  void _increment(){
    _value += 1;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton(
            onPressed: _increment,
            child: const Text('Жми')
        ),
        DataConsumerStateles()
      ],
    );
  }
}

class DataConsumerStateles extends StatelessWidget {
  const DataConsumerStateles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final value =
           context.dependOnInheritedWidgetOfExactType<DataProviderInherited>(
             aspect: 'one'
           )?.valueOne ?? 0;
        // context.findAncestorStateOfType<_DataOwnerStatefullState>()?._value ?? 0;
    return Container(
      child: Column(
        children: [
          Text('$value'),
          DataConsumerStatefull()
        ],
      ),
    );
  }
}

class DataConsumerStatefull extends StatefulWidget {
  const DataConsumerStatefull({Key? key}) : super(key: key);

  @override
  _DataConsumerStatefullState createState() => _DataConsumerStatefullState();
}

class _DataConsumerStatefullState extends State<DataConsumerStatefull> {
  @override
  Widget build(BuildContext context) {
    final value = context.findAncestorStateOfType<_DataOwnerStatefullState>()?._value ?? 0;

    return Text('$value');
  }
}

class DataProviderInherited extends InheritedModel<String> {
  final int valueOne;
  final int valueTwo
  ;
  const DataProviderInherited({
    Key? key,
    required Widget child,
    required this.valueOne,
    required this.valueTwo,
  }) : super(key: key, child: child);

  static DataProviderInherited of(BuildContext context) {
    final DataProviderInherited? result = context.dependOnInheritedWidgetOfExactType<DataProviderInherited>();
    assert(result != null, 'No DataProviderInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(DataProviderInherited old) {
    return  valueOne !=old.valueOne || valueTwo !=old.valueTwo;
  }

  @override
  bool updateShouldNotifyDependent(covariant DataProviderInherited oldWidget, Set<String> dependencies) {
    final isValueOneUpdated = 
        valueOne != oldWidget.valueOne && dependencies.contains('one');
    final isValueTwoUpdated = 
        valueTwo != oldWidget.valueTwo && dependencies.contains('two');
    return isValueOneUpdated || isValueTwoUpdated;
  }
}

class SimpleCalcWidgetModel extends ChangeNotifier{
  int? _firstNumber;
  int? _secondNumber;
  int? summResult;

  set firstNumber(String value) => _firstNumber = int.tryParse(value);
  set secondNumber(String value) => _secondNumber = int.tryParse(value);

  void summ(){
    int? summResult;
    if(_firstNumber!=null && _secondNumber!=null){
      summResult = _firstNumber! + _secondNumber!;
    }else{
      summResult = null;
    }
    if(this.summResult != summResult){
      this.summResult = summResult;
      notifyListeners();
    }
  }
}

class SimpleCalcWidgetProvider extends InheritedNotifier<SimpleCalcWidgetModel> {
  final SimpleCalcWidgetModel model;

  SimpleCalcWidgetProvider({
    Key? key,
    required Widget child,
    required this.model,
  }) : super(key: key,notifier: model, child: child);

  static SimpleCalcWidgetModel? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<SimpleCalcWidgetProvider>()
        ?.model;
  }
}
