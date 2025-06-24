import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/presentation/modules/login/bloc/login_bloc.dart';
import 'package:todolist/presentation/modules/login/bloc/login_event.dart';
import 'package:todolist/presentation/modules/login/bloc/login_state.dart';

class LoginScreen extends StatefulWidget{
  const LoginScreen({super.key});

  @override
   State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>{
  final TextEditingController _emailController = TextEditingController();

  void _onLoginPressed(){
    final email = _emailController.text.trim();
    if (email.isNotEmpty) {
      context.read<LoginBloc>().add(LoginSubmitted(email));
    }
  }

 @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state){
            if (state is LoginSuccess){
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Welcome ${state.username}!")),
              );
            } else if (state is LoginFailure){
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Enter your email", style: TextStyle(fontSize: 18)),
              const SizedBox(height: 10),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Email...',
                ),
              ),
              const SizedBox(height: 20),
              BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state){
                  if (state is LoginLoading){
                    return const CircularProgressIndicator();
                  }
                  return ElevatedButton(
                    onPressed: _onLoginPressed, 
                    child: const Text("Login"),
                  );
                }
              )
            ],
          ),
        )
      )
    );
  }
  
}