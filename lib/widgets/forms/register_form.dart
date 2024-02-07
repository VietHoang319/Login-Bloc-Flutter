import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:test_login/blocs/register/register_bloc.dart';
import 'package:test_login/blocs/register/register_event.dart';
import 'package:test_login/blocs/register/register_state.dart';
import 'package:test_login/models/formz/gender.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: const Text(
                '新規アカウント登録',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: StepProgressBar(),
            ),
            const RegisterFormMain(),
            const ButtonBox(),
          ],
        ),
      ),
    );
  }
}

class StepProgressBar extends StatelessWidget {
  final _activeColor = const Color.fromRGBO(55, 198, 147, 1);
  final _inactiveColor = const Color.fromRGBO(217, 217, 217, 1);

  const StepProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
      return SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Row(
              children: _iconViews(state.step),
            ),
            const SizedBox(
              height: 8,
            ),
          ],
        ),
      );
    });
  }

  List<Widget> _iconViews(int currentStep) {
    var list = <Widget>[];
    for (int i = 1; i <= 4; i++) {
      var circleColor = (currentStep >= i) ? _activeColor : _inactiveColor;
      var lineColor = currentStep > i ? _activeColor : _inactiveColor;
      var iconColor = (currentStep >= i) ? _activeColor : _inactiveColor;

      list.add(
        Container(
          width: 20.0,
          height: 20.0,
          padding: const EdgeInsets.all(0),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(22.0)),
            border: Border.all(
              color: circleColor,
              width: 2.0,
            ),
          ),
          child: Icon(
            Icons.circle,
            color: iconColor,
            size: 12.0,
          ),
        ),
      );

      //line between icons
      if (i != 4) {
        list.add(Expanded(
            child: Container(
              height: 3.0,
              color: lineColor,
            )));
      }
    }

    return list;
  }
}

class RegisterFormMain extends StatelessWidget {
  const RegisterFormMain({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
      if (state.step == 1) {
        return FormStep1(state: state);
      } else {
        return FormStep2(state: state);
      }
    });
  }
}

class FormStep1 extends StatelessWidget {
  const FormStep1({super.key, required this.state});

  final RegisterState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          child: RichText(
            text: const TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: '事業所コード',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: '必須',
                  style: TextStyle(
                    fontWeight: FontWeight.w100,
                    fontSize: 12,
                    color: Color.fromRGBO(230, 0, 22, 1),
                  ),
                ),
              ],
            ),
          ),
        ),
        TextFormField(
          initialValue: state.officeCode.value,
          keyboardType: TextInputType.text,
          autocorrect: false,
          textCapitalization: TextCapitalization.none,
          decoration: InputDecoration(
              errorText: state.officeCode.displayError != null
                  ? 'Office Code error'
                  : null),
          onChanged: (value) {
            context.read<RegisterBloc>().add(OfficeCodeChanged(value));
          },
        ),
      ],
    );
  }
}

class FormStep2 extends StatefulWidget {
  const FormStep2({super.key, required this.state});

  final RegisterState state;

  @override
  State<FormStep2> createState() {
    return _FormStep2State();
  }
}

class _FormStep2State extends State<FormStep2> {
  late RegisterState _state;
  TextEditingController dateOfBirth = TextEditingController();

  Future<void> selectDate(RegisterState state) async {
    DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      locale: const Locale("ja", "JA"),
      initialDate: state.birthday.value,
    );

    context.read<RegisterBloc>().add(BirthdayChanged(picked!));
    if(_state.email.displayError == null) {
      dateOfBirth.text = picked.toIso8601String();
    }
  }

  @override
  void initState() {
    _state = widget.state;
    dateOfBirth.text = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(bottom: 15),
          child: const Text(
            'A001事務所',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          child: RichText(
            text: const TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: 'ニックネーム',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: '必須',
                  style: TextStyle(
                    fontWeight: FontWeight.w100,
                    fontSize: 12,
                    color: Color.fromRGBO(230, 0, 22, 1),
                  ),
                ),
              ],
            ),
          ),
        ),
        TextFormField(
          initialValue: _state.username.value,
          keyboardType: TextInputType.text,
          autocorrect: false,
          textCapitalization: TextCapitalization.none,
          decoration: InputDecoration(
              errorText: _state.username.displayError != null
                  ? 'Username error'
                  : null),
          onChanged: (value) {
            context.read<RegisterBloc>().add(UsernameChanged(value));
          },
        ),
        const SizedBox(height: 20),
        Container(
          alignment: Alignment.topLeft,
          child: RichText(
            text: const TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: 'メールアドレス',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: '必須',
                  style: TextStyle(
                    fontWeight: FontWeight.w100,
                    fontSize: 12,
                    color: Color.fromRGBO(230, 0, 22, 1),
                  ),
                ),
              ],
            ),
          ),
        ),
        TextFormField(
          keyboardType: TextInputType.text,
          autocorrect: false,
          textCapitalization: TextCapitalization.none,
          decoration: InputDecoration(
            errorText:
            _state.email.displayError != null ? 'Username error' : null,
            // border: const OutlineInputBorder(
            //     borderRadius: BorderRadius.all(Radius.circular(6))),
            // contentPadding: EdgeInsets.all(5),
          ),
          onChanged: (value) {
            context.read<RegisterBloc>().add(EmailChanged(value));
          },
        ),
        const SizedBox(height: 20),
        Container(
          alignment: Alignment.topLeft,
          child: RichText(
            text: const TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: '生年月',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: '必須',
                  style: TextStyle(
                    fontWeight: FontWeight.w100,
                    fontSize: 12,
                    color: Color.fromRGBO(230, 0, 22, 1),
                  ),
                ),
              ],
            ),
          ),
        ),
        TextFormField(
          controller: dateOfBirth,
          style: const TextStyle(backgroundColor: Colors.white),
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.calendar_today),
          ),
          readOnly: true,
          onTap: () {
            selectDate(_state);
          },
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: RichText(
                      text: const TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: '生別',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: '必須',
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 12,
                              color: Color.fromRGBO(230, 0, 22, 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  DropdownButton(
                    isExpanded: true,
                    value: _state.gender.value,
                    items: listGender
                        .map(
                          (gender) =>
                          DropdownMenuItem(
                            value: gender.value,
                            child: Text(gender.label),
                          ),
                    )
                        .toList(),
                    onChanged: (value) {
                      context.read<RegisterBloc>().add(GenderChanged(value!));
                    },
                  ),
                ],
              ),
            ),
            const Spacer(),
            const Spacer(flex: 5),
          ],
        ),
        const SizedBox(height: 20),
        Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: RichText(
                text: const TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: '通知許可',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: '必須',
                      style: TextStyle(
                        fontWeight: FontWeight.w100,
                        fontSize: 12,
                        color: Color.fromRGBO(230, 0, 22, 1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5),
            Container(
              alignment: Alignment.topLeft,
              child: Switch(
                activeColor: const Color.fromRGBO(35, 101, 228, 1),
                value: _state.notificationFlag,
                onChanged: (value) {
                  context
                      .read<RegisterBloc>()
                      .add(NotificationFlagChanged(value));
                },
              ),
            )
          ],
        )
      ],
    );
  }
}

class ButtonBox extends StatefulWidget {
  const ButtonBox({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ButtonBoxState();
  }
}

class _ButtonBoxState extends State<ButtonBox> {
  void _onNextStep(int step) {
    if (step < 3) {
      context.read<RegisterBloc>().add(NextStepChanged(step + 1));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Row(
          children: [
            Expanded(
              flex: 5,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromRGBO(217, 217, 217, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                child: const Text(
                  '戻る',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const Spacer(),
            Expanded(
              flex: 5,
              child: ElevatedButton(
                onPressed: () {
                  _onNextStep(state.step);
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromRGBO(55, 198, 147, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                child: const Text(
                  '次へ',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
