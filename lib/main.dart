import 'package:flutter/material.dart';
import 'package:tip_calculator/widgets/bill_amount.dart';
import 'package:tip_calculator/widgets/person_counter.dart';
import 'package:tip_calculator/widgets/tip_slider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YuTip',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const YuTip(),
    );
  }
}

class YuTip extends StatefulWidget {
  const YuTip({super.key});

  @override
  State<YuTip> createState() => _YuTipState();
}

class _YuTipState extends State<YuTip> {
  int _personCount = 1;
  double _tipPercentage = 0.0;
  double _billTotal = 0.0;

  double totalPerPerson() {
    return ((_billTotal * _tipPercentage) + (_billTotal)) / _personCount;
  }

  double totalTip(){
    return ((_billTotal * _tipPercentage));
  }
  void increment() {
    setState(() {
      _personCount = _personCount + 1;
    });
  }

  void decrement() {
    setState(() {
      if (_personCount > 1) {
        _personCount--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    double total = totalPerPerson();
    double tip = totalTip();
    final style = theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.onPrimary, fontWeight: FontWeight.bold);
    return Scaffold(
      appBar: AppBar(
        title: const Text('YuTip'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.inversePrimary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text(
                      'Total Per Person',
                      style: style,
                    ),
                    Text(
                      '$total',
                      style: style.copyWith(
                          color: theme.colorScheme.onPrimary,
                          fontSize: theme.textTheme.displaySmall?.fontSize),
                    )
                  ],
                )),
          ),
          //Form
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border:
                      Border.all(color: theme.colorScheme.primary, width: 2),
                ),
                child: Column(
                  children: [
                    BillAmountField(
                      billAmount: _billTotal.toString(),
                      onChanged: (value) => {
                        setState(() {
                          _billTotal = double.parse(value);
                        })
                      },
                    ),
                    //Split Bill area
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Split",
                          style: theme.textTheme.titleMedium,
                        ),
                        PersonCounter(
                          theme: theme,
                          personCount: _personCount,
                          onDecrement: decrement,
                          onIncrement: increment,
                        )
                      ],
                    ),

                    //Tip Area
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tip',
                          style: theme.textTheme.titleMedium,
                        ),
                        Text(
                          '$tip',
                          style: theme.textTheme.titleMedium,
                        )
                      ],
                    ),

                    //Slider Text
                    Text('${(_tipPercentage * 100).round()}%'),

                    //Slider
                    TipSlider(
                      tipPercentage: _tipPercentage,
                      onChanged: (double value) {
                        setState(() {
                          _tipPercentage = value;
                        });
                      },
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }
}
