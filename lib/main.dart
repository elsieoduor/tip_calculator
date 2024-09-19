import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tip_calculator/providers/ThemeProvider.dart';
import 'package:tip_calculator/providers/TipCalculatorModel.dart';
import 'package:tip_calculator/widgets/bill_amount.dart';
import 'package:tip_calculator/widgets/person_counter.dart';
import 'package:tip_calculator/widgets/theme_provider.dart';
import 'package:tip_calculator/widgets/tip_row.dart';
import 'package:tip_calculator/widgets/tip_slider.dart';
import 'package:tip_calculator/widgets/total_per_person.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => TipCalculatorModel()),
      ChangeNotifierProvider(create: (context) => ThemeProvider())
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'YuTip',
      theme: themeProvider.currentTheme,
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
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<TipCalculatorModel>(context);
    var theme = Theme.of(context);

    final style = theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.onPrimary, fontWeight: FontWeight.bold
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('YuTip'),
        actions: const [
          ToggleThemeButton()
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TotalPerPerson(
              theme: theme, style: style, total: model.totalPerPerson),
          //Form
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border:
                      Border.all(color: theme.colorScheme.primary, width: 2),
                ),
                child: Column(
                  children: [
                    BillAmountField(
                      billAmount: model.billTotal.toString(),
                      onChanged: (value) =>
                          {model.updateBillTotal(double.parse(value))},
                    ),
                    //Split Bill area

                    PersonCounter(
                      theme: theme,
                      personCount: model.personCount,
                      onDecrement: () {
                        if (model.personCount > 1) {
                          model.updatePersonCount(model.personCount - 1);
                        }
                      },
                      onIncrement: () {
                        model.updatePersonCount(model.personCount + 1);
                      },
                    ),

                    //Tip Area
                    TipRow(
                      theme: theme,
                      tip: model.billTotal,
                      percentage: model.tipPercentage,
                    ),

                    //Slider Text
                    Text('${(model.tipPercentage * 100).round()}%'),

                    //Slider
                    TipSlider(
                      tipPercentage: model.tipPercentage,
                      onChanged: (double value) {
                        model.updateTipPercentage(value);
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

