import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../static/loading_indicator.dart';
import '../../../../../static/user_button.dart';
import '../blocs/sign_in/sign_in_bloc.dart';
import '../blocs/sign_in/sign_in_event.dart';
import '../blocs/sign_in/sign_in_state.dart';
import 'home_screen.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SignInView();
  }
}

class SignInView extends StatefulWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Dept-Connect')),
      ),
      body: Stack(
        children: [
          BlocConsumer<SignInBloc, SignInState>(
            listener: (context, state) {
              if (state is SignInFailureState) {
                if(state.errorMessage == "Exception: [firebase_auth/network-request-failed] A network error (such as timeout, interrupted connection or unreachable host) has occurred."){
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Network connection error. Please check your internet connection and try again.")),
                  );
                }
                else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.errorMessage)),
                  );
                }
              } else if (state is SignInSuccessState) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => HomeScreen(user: state.user),
                ));
              }
            },
            builder: (context, state) {
              return Stack(
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 100),
                          const Text(
                            "Sign In",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            key: const Key('signIn_emailInput_textField'),
                            controller: _emailController,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.black, width: 1.5),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            key: const Key('signIn_passwordInput_textField'),
                            controller: _passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelText: 'Password',
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.black, width: 1.5),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          DropdownButtonFormField<String>(
                            value: state.userType.isNotEmpty
                                ? state.userType
                                : null,
                            items: ['Parent', 'Teacher', 'Student']
                                .map((userType) => DropdownMenuItem(
                              value: userType,
                              child: Text(userType),
                            ))
                                .toList(),
                            onChanged: (newValue) {
                              context
                                  .read<SignInBloc>()
                                  .add(UserTypeChanged(newValue!));
                            },
                            decoration: const InputDecoration(
                              labelText: 'Select User Type',
                              labelStyle: TextStyle(color: Colors.black),
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.black, width: 1.5),
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),
                          UserButton(
                            label: 'Sign In',
                            onPressed: () {
                              // Validate the fields
                              if (_emailController.text.isEmpty ||
                                  _passwordController.text.isEmpty ||
                                  state.userType.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                    Text('Please fill in all fields.'),
                                  ),
                                );
                              } else {
                                // Dispatch the event
                                context.read<SignInBloc>().add(SignInSubmitted(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                  userType: state.userType,
                                ));
                              }
                            },
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                  // Overlay progress indicator
                  if (state is SignInLoadingState)
                    const LoaderTransparent(colorValue: Colors.black),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
