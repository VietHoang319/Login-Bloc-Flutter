import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_login/blocs/register/register_bloc.dart';
import 'package:test_login/widgets/forms/register_form.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          '新規登録',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        shape: const Border(
            bottom: BorderSide(
          color: Colors.grey,
          width: 1,
        )),
      ),
      body: SingleChildScrollView(
        child: BlocProvider(
          create: (ctx) {
            return RegisterBloc();
          },
          child: const RegisterForm(),
        ),
      ),
    );
  }
}
