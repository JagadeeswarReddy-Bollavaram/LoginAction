import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travalizer/src/presentation/bloc/login/login_bloc.dart';
import 'package:travalizer/src/presentation/bloc/login/login_events.dart';
import 'package:travalizer/src/presentation/bloc/login/login_states.dart';
import 'package:travalizer/src/presentation/widgets/inputField.dart';
import 'package:travalizer/src/presentation/widgets/socialLoginButton.dart';
import 'package:travalizer/src/presentation/widgets/textButton.dart';
import '../../data/services/login_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => LoginBloc(),
        child: Scaffold(
          body: BlocConsumer<LoginBloc, LoginState>(
            listenWhen: (previous, current) => current is LoginAction,
            listener: (context, state) {
              if (state is LoginSuccess) {
                Navigator.pushReplacementNamed(context, '/home');
              } else if (state is LoginFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Login Failed: ${state.message}')),
                );
              }
            },
            builder: (context, state) {
              if (state is LoginLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return ListView(
                children: [
                  ClipPath(
                    clipper: CurveClipper(),
                    child: Container(
                      height: 200,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xffA03CEA), Color(0xffFB6564)],
                          begin: Alignment.topLeft,
                          end: Alignment.topRight,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.bubble_chart,
                              size: 50, color: Colors.white),
                          Text(
                            'Design Guild',
                            style: TextStyle(
                                fontSize: 32,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Join our',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff3C2C20)),
                        ),
                        const Text(
                          'community today',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff3C2C20)),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'Get connected, find designers to start a project',
                          style: TextStyle(
                              fontFamily: "Sora",
                              fontSize: 14,
                              color: Color(0xff3C2C20),
                              fontWeight: FontWeight.w400),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        // Sign Up Button
                        ButtonText(text: 'Sign Up', onPressed: () {}),
                        const SizedBox(height: 15),
                        const Center(
                            child: Text('Or, login with',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF3E334E),
                                    fontWeight: FontWeight.w400))),
                        const SizedBox(height: 15),
                        _buildSocialLoginButtons(),
                        const SizedBox(height: 30),
                        InputField(
                            label: 'Email',
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress),
                        const SizedBox(height: 20),
                        InputField(
                            label: 'Password',
                            controller: passwordController,
                            keyboardType: TextInputType.text,
                            isPassword: true),
                        const SizedBox(height: 5),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: const Text('Forgot password?'),
                          ),
                        ),
                        const SizedBox(height: 5),
                        ButtonText(
                            text: 'Login',
                            onPressed: () {
                              final email = emailController.text;
                              final password = passwordController.text;
                              HiveStorageService()
                                  .storeCredentials(email, password);
                              emailController.clear();
                              passwordController.clear();
                              context.read<LoginBloc>().add(LoginSubmitted(
                                  email: email, password: password));
                            }),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSocialLoginButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        SocialLoginButton(text: 'Facebook'),
        SocialLoginButton(text: 'LinkedIn'),
        SocialLoginButton(text: 'Google'),
      ],
    );
  }
}

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height);

    var controlPoint = Offset(size.width / 2, 2 * size.height / 3);
    var endPoint = Offset(size.width, size.height);

    path.quadraticBezierTo(
        controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
