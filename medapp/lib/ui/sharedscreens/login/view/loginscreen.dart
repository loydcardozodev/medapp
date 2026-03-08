import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medapp/ui/sharedscreens/login/view/auth_textfield.dart';
import 'package:provider/provider.dart';
import 'package:medapp/routing/routes.dart';
import 'package:medapp/ui/sharedscreens/auth/viewmodel/auth_viewmodel.dart';
import 'package:medapp/util/result.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool obsecurePass = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Login",
          style: GoogleFonts.inter(
            color: Colors.black87,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        toolbarHeight: 110,
        backgroundColor: Colors.white,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                const SizedBox(height: 40),

                AuthTextField(
                  controller: emailController,
                  text: "Enter your email",
                  icon: const Icon(Icons.email),
                  keyboardType: TextInputType.emailAddress,
                ),

                const SizedBox(height: 15),

                /// PASSWORD
                TextFormField(
                  controller: passwordController,
                  obscureText: obsecurePass,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter password";
                    }
                    if (value.length < 8) {
                      return "Password must be at least 8 characters";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Password",
                    labelText: "Password",
                    fillColor: const Color.fromARGB(255, 247, 247, 247),
                    filled: true,
                    prefixIcon: const Icon(Icons.lock),
                    prefixIconColor: const Color.fromARGB(255, 3, 190, 150),

                    suffixIcon: IconButton(
                      icon: Icon(
                        obsecurePass ? Icons.visibility_off : Icons.visibility,
                        color: const Color.fromARGB(255, 3, 190, 150),
                      ),
                      onPressed: () {
                        setState(() {
                          obsecurePass = !obsecurePass;
                        });
                      },
                    ),

                    enabledBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                /// LOGIN BUTTON
                Container(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 3, 190, 150),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: GestureDetector(
                    onTap: () async {
                      if (!_formKey.currentState!.validate()) return;

                      final auth = context.read<AuthViewModel>();

                      final result = await auth.login(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                      );

                      if (result is Ok) {
                        context.go(Routes.home);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Login Failed")),
                        );
                      }
                    },
                    child: Center(
                      child: Text(
                        "Login",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                /// SIGNUP
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: Colors.black87,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.push(Routes.signup);
                      },
                      child: Text(
                        "Sign Up",
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          color: const Color.fromARGB(255, 3, 190, 150),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
