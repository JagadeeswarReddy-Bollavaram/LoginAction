import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travalizer/login/bloc/login_bloc.dart';
import 'package:travalizer/login/bloc/login_events.dart';
import 'package:travalizer/login/bloc/login_states.dart';
import 'login_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isHidden = true;

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
                  const CurvedHeader(),
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
                        _buildGradientButton(context, 'Sign Up', () {
                          // Add Sign Up Logic
                        }),
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
                        _buildInputField('Email', emailController,
                            TextInputType.emailAddress),
                        const SizedBox(height: 20),
                        _buildInputField(
                            'Password', passwordController, TextInputType.text,
                            isPassword: true),
                        const SizedBox(height: 5),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              // Add Forgot Password Logic
                            },
                            child: const Text('Forgot password?'),
                          ),
                        ),
                        const SizedBox(height: 5),
                        _buildGradientButton(context, 'Login', () {
                          final email = emailController.text;
                          final password = passwordController.text;
                          HiveStorageService()
                              .storeCredentials(email, password);
                          emailController.clear();
                          passwordController.clear();
                          context.read<LoginBloc>().add(
                              LoginSubmitted(email: email, password: password));
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

  Widget _buildGradientButton(
      BuildContext context, String text, VoidCallback onPressed) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xffA03CEA), Color(0xffFB6564)],
          begin: Alignment.topLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        ),
        child: Text(
          text,
          style: const TextStyle(
              fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
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

  Widget _buildInputField(String label, TextEditingController controller,
      TextInputType keyboardType,
      {bool isPassword = false}) {
    return SizedBox(
      height: 72,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xff3C2C20)),
          ),
          const SizedBox(height: 5),
          SizedBox(
            height: 48,
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xffBA977D), // Border color
                      width: 1.0, // Border width
                    ),
                    borderRadius: BorderRadius.circular(10)),
                suffixIcon: isPassword
                    ? IconButton(
                        icon: isHidden
                            ? const Icon(
                                Icons.visibility_off,
                                color: Color(0xffBA977D),
                              )
                            : const Icon(
                                Icons.visibility_rounded,
                                color: Color(0xffBA977D),
                              ),
                        onPressed: () {
                          setState(() {
                            isHidden = !isHidden;
                          });
                        },
                      )
                    : null,
              ),
              obscureText: isPassword && isHidden,
              keyboardType: keyboardType,
            ),
          ),
        ],
      ),
    );
  }
}

class SocialLoginButton extends StatelessWidget {
  final String text;

  const SocialLoginButton({required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      width: 116,
      child: TextButton(
        onPressed: () {
          // Add social login logic
        },
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          side: const BorderSide(
            color: Color(0xffAFA2C3), // Border color
            width: 1.0, // Border width
          ),
        ),
        child: Text(text,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Color(0xff3E334E),
            )),
      ),
    );
  }
}

class CurvedHeader extends StatelessWidget {
  const CurvedHeader();

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CurveClipper(),
      child: Container(
        height: 200,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffA03CEA), Color(0xffFB6564)],
            begin: Alignment.topLeft,
            end: Alignment.topRight,
          ),
          // borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.bubble_chart, size: 50, color: Colors.white),
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
