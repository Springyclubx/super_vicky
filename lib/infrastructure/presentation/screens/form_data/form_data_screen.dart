import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:super_vicky/domain/constants/format_date_constants.dart';
import 'package:super_vicky/infrastructure/presentation/states/form_data_state.dart';
import 'package:super_vicky/infrastructure/util/formatters/input_format/currency_input_formatter.dart';
import 'package:super_vicky/infrastructure/util/formatters/input_format/hour_input_formatter.dart';

import '../../../../extension/util.dart';
import '../../../util/exports_widget.dart';

/// Screen of register new item
class RegisterScreen extends StatelessWidget {
  /// Default constructor
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FormDataState(),
      child: Scaffold(
        appBar: appBarDefault(context: context, title: 'Registro'),
        body: const _Body(),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8,
            ),
            child: Container(
              constraints: const BoxConstraints(
                maxWidth: 800,
              ),
              child: const Column(
                spacing: 8,
                children: [
                  _RowItem(
                    children: [
                      _TextFormHour(),
                      _TextFormDate(),
                    ],
                  ),
                  _RowItem(
                    children: [
                      _TextFormModel(),
                      _TextFormCode(),
                    ],
                  ),

                  _RowItem(
                    children: [
                      _TextFormQuantity(),
                      _TextFormValue(),
                    ],
                  ),
                  _TextFormTotalValue(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _RowItem extends StatelessWidget {
  const _RowItem({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        for (final item in children)
          Expanded(
            child: item,
          ),
      ],
    );
  }
}

class _TextFormHour extends StatelessWidget {
  const _TextFormHour();

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<FormDataState>(context);

    return TextFormDefault(
      hintText: 'Hora',
      controller: state.hourController,
      inputFormatters: [HourInputFormatter()],
    );
  }
}

class _TextFormDate extends StatelessWidget {
  const _TextFormDate();

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<FormDataState>(context);

    return TextFormDefault(
      hintText: 'Data',
      controller: state.dateController,
      inputFormatters: [DateInputFormatter()],
      suffixIcon: const _CalendarButton(),
    );
  }
}

class _CalendarButton extends StatelessWidget {
  const _CalendarButton();

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<FormDataState>(context, listen: false);
    return IconButton(
      onPressed: () async {
        final date = await showDatePickerDefault(
          context: context,
          firstDate: DateTime(2000),
          lastDate: DateTime.now(),
          initialDate: tryParseDate(
            FormatDate.dateMonthYear,
            state.dateController.text,
          ),
        );
        state.selectDate(date.$2);
      },
      icon: const Icon(
        Icons.calendar_month,
        size: 16,
      ),
    );
  }
}

class _TextFormModel extends StatelessWidget {
  const _TextFormModel();

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<FormDataState>(context);

    return TextFormDefault(
      hintText: 'Modelo',
      controller: state.modelController,
    );
  }
}

class _TextFormCode extends StatelessWidget {
  const _TextFormCode();

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<FormDataState>(context);

    return TextFormDefault(
      hintText: 'Código',
      controller: state.codeController,
    );
  }
}

class _TextFormQuantity extends StatelessWidget {
  const _TextFormQuantity();

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<FormDataState>(context);

    return TextFormDefault(
      hintText: 'Quantidade',
      controller: state.quantityController,
      onChanged: (value) => state.reload(),
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
    );
  }
}

class _TextFormValue extends StatelessWidget {
  const _TextFormValue();

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<FormDataState>(context);

    return TextFormDefault(
      hintText: 'Valor',
      controller: state.valueController,
      onChanged: (value) => state.reload(),
      inputFormatters: [CurrencyTextInputFormatter()],
    );
  }
}

class _TextFormTotalValue extends StatelessWidget {
  const _TextFormTotalValue();

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<FormDataState>(context);

    return TextFormDefault(
      hintText: 'Valor total (Quantidade * Valor)',
      controller: state.totalValueController,
      enabled: false,
      inputFormatters: [CurrencyTextInputFormatter()],
    );
  }
}
