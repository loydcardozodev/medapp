import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:medapp/routing/routes.dart';
import 'package:medapp/ui/sharedscreens/signup/view/auth_textfield.dart';
import 'package:medapp/ui/sharedscreens/auth/viewmodel/auth_viewmodel.dart';
import 'package:medapp/util/result.dart';

class Signupscreen extends StatefulWidget {
  const Signupscreen({super.key});

  @override
  State<Signupscreen> createState() => _SignupscreenState();
}

class _SignupscreenState extends State<Signupscreen> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscurePass = true;

  @override
  void dispose() {
    nameController.dispose();
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
          "Sign Up",
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

                /// NAME
                AuthTextField(
                  controller: nameController,
                  text: "Full Name",
                  label: 'Full Name',
                  icon: const Icon(Icons.person),
                ),

                const SizedBox(height: 15),

                /// EMAIL
                AuthTextField(
                  controller: emailController,
                  text: "Email",
                  label: 'Email',
                  icon: const Icon(Icons.email),
                  keyboardType: TextInputType.emailAddress,
                ),

                const SizedBox(height: 15),

                /// PASSWORD
                TextFormField(
                  controller: passwordController,
                  obscureText: obscurePass,
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
                        obscurePass ? Icons.visibility_off : Icons.visibility,
                        color: const Color.fromARGB(255, 3, 190, 150),
                      ),
                      onPressed: () {
                        setState(() {
                          obscurePass = !obscurePass;
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

                const SizedBox(height: 30),

                /// CREATE ACCOUNT BUTTON
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.9,

                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 3, 190, 150),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),

                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) return;

                      final auth = context.read<AuthViewModel>();

                      final result = await auth.signup(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                      );

                      if (result is Ok) {
                        context.go(Routes.home);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Signup Failed")),
                        );
                      }
                    },

                    child: Text(
                      "Create Account",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                /// LOGIN NAVIGATION
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),

                    GestureDetector(
                      onTap: () {
                        context.push(Routes.login);
                      },
                      child: Text(
                        "Sign in",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
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
