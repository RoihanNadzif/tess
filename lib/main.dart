import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tess/pages/home_page.dart';
import 'package:tess/pages/product_page.dart';

void main() {
  runApp(
    DevicePreview(enabled: !kReleaseMode, builder: (context) => const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: const ProductPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _showPassword = true;
  bool _checkBox = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: .center,
            crossAxisAlignment: .center,
            spacing: 20,
            children: [
              Container(
                height: 250,
                width: 250,
                margin: EdgeInsets.all(20),
                alignment: Alignment.topCenter,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black, width: 5),
                ),
                child: Image.asset('asset/tes.png'),
              ),
              Row(
                mainAxisAlignment: .start,
                children: [
                  Text(
                    "Login",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(hintText: "username"),
              ),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  hintText: "password",
                  suffixIcon: IconButton(
                    onPressed: () {
                      print("button ditekan");
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                    },
                    icon: _showPassword
                        ? Icon(Icons.visibility)
                        : Icon(Icons.visibility_off),
                  ),
                ),
                obscureText: _showPassword,
                obscuringCharacter: "*",
              ),
              Row(
                children: [
                  Checkbox(
                    value: _checkBox,
                    onChanged: (bool? value) {
                      setState(() {
                        _checkBox = !_checkBox;
                      });
                    },
                  ),
                  Text("Remember me"),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: FilledButton(
                      onPressed: () async {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                    size: 80,
                                  ),
                                  SizedBox(height: 16),
                                  Text("Login berhasil !!!"),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("OK"),
                                ),
                              ],
                            );
                          },
                        );
                        await Future.delayed(Duration(seconds: 2));

                        if (context.mounted) {
                          Navigator.pop(context);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(
                                username: _usernameController.text,
                                password: _passwordController.text,
                              ),
                            ),
                          );
                        }
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      style: ButtonStyle(
                        backgroundColor: WidgetStateColor.resolveWith(
                          (states) => Colors.blue,
                        ),
                        fixedSize: WidgetStatePropertyAll(
                          Size(double.infinity, 50),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
