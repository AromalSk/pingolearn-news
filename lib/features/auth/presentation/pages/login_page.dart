import 'package:flutter/material.dart';
import 'package:pingolearn/core/theme/app_pallete.dart';
import 'package:pingolearn/core/utils/show_snackbar.dart';
import 'package:pingolearn/features/news/presentation/pages/homepage.dart';
import 'package:pingolearn/features/auth/presentation/pages/signup_page.dart';
import 'package:pingolearn/features/auth/presentation/provider/login_provider.dart';
import 'package:pingolearn/features/auth/presentation/widgets/auth_button.dart';
import 'package:pingolearn/features/auth/presentation/widgets/auth_field.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "MyNews",
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
      ),
      body: Consumer<LoginProvider>(
        builder: (context, value, child) {
          if (value.state == AuthState.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (value.state == AuthState.success) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) {
                  return const Homepage();
                },
              ));
            }

            if (value.state == AuthState.failure) {
              showSnackBar(context, value.errorMessage.toString());
            }

            if (value.state == AuthState.success) {
              showSnackBar(context, "Login Successful");
            }
          });

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 5,
                    ),
                    AuthField(
                      hintText: "Email",
                      controller: emailController,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    AuthField(
                      hintText: "Password",
                      controller: passwordController,
                      isObscureText: true,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 4,
                    ),
                    AuthButton(
                      buttonText: "Login",
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          value.authLogin(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                          );
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return const SignUpPage();
                          },
                        ));
                      },
                      child: RichText(
                          text: TextSpan(
                              text: "New here?",
                              style: Theme.of(context).textTheme.bodyMedium,
                              children: [
                            TextSpan(
                              text: ' Signup',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(color: AppPallete.primaryColor),
                            )
                          ])),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
