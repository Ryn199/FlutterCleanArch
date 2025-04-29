import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterclean/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      body: Column(
        children: [
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.email),
              border: OutlineInputBorder(),
              labelText: 'Email',
            ),
          ),
          SizedBox(height: 15),
          TextFormField(
            controller: passwordController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock),
              border: OutlineInputBorder(),
              labelText: 'Password',
            ),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  context.go('/register');
                },
                child: Text('register'),
              )
            ],
          ),
          SizedBox(height: 15),
          BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthStateError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                  ),
                );
              }
              if (state is AuthStateLoaded) {
                context.go('/product');
              }
            },
            builder: (context, state) {
              return ElevatedButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(AuthEventLogin(
                        email: emailController.text,
                        password: passwordController.text));
                  },
                  child: Text(state is AuthStateLoading ? 'Loading' : 'Login'));
            },
          ),
        ],
      ),
    );
  }
}
