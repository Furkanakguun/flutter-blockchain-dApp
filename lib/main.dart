import 'package:flutter/material.dart';
import 'package:flutter_dapp/contract_linking.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  ThemeData _buildAppTheme() {
    final ThemeData base = ThemeData.dark();
    return base.copyWith(
        brightness: Brightness.dark,
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 72, fontWeight: FontWeight.bold),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ContractLinking(),
      child: MaterialApp(
          title: 'Hello World Dapp',
          theme: _buildAppTheme(),
          home: const HelloWorld()),
    );
  }
}

class HelloWorld extends StatefulWidget {
  const HelloWorld({Key? key}) : super(key: key);

  @override
  State<HelloWorld> createState() => _HelloWorldState();
}

class _HelloWorldState extends State<HelloWorld> {
  TextEditingController yourNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Getting the value and object or contract_linking
    var contractLink = Provider.of<ContractLinking>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 3, 170, 8),
        title: Text(
          "Hello World from Blockchain !",
          style: GoogleFonts.courierPrime(
            textStyle: TextStyle(
              color: Color.fromARGB(255, 245, 245, 243),
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: contractLink.isLoading
              ? const CircularProgressIndicator()
              : SingleChildScrollView(
                  child: Form(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Hello ",
                              style: GoogleFonts.courierPrime(
                                textStyle: TextStyle(
                                  color: Color.fromARGB(255, 224, 224, 224),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 32,
                                ),
                              ),
                            ),
                            Text(
                              contractLink.deployedName!,
                              style: GoogleFonts.courierPrime(
                                textStyle: TextStyle(
                                  color: Colors.teal,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 32,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 29),
                          child: TextFormField(
                            controller: yourNameController,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Your Name",
                                hintText: "What is your name ?",
                                icon: Icon(Icons.drive_file_rename_outline)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: ElevatedButton(
                            child: Text(
                              'Set Name',
                              style: GoogleFonts.courierPrime(
                                textStyle: TextStyle(
                                  color: Color.fromARGB(255, 245, 245, 243),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 3, 170, 8),
                            ),
                            onPressed: () async {
                              await contractLink
                                  .setName(yourNameController.text);
                              yourNameController.clear();
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
