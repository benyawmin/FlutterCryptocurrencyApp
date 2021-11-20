import 'package:cryptocurrency/src/accessories/pallete.dart';
import 'package:cryptocurrency/src/blocs/latest_news_provider.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart';

class Chart extends StatefulWidget {
  const Chart({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<Chart> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool hasErr = false;
  late String errTxt;

  @override
  Widget build(BuildContext context) {
    final bloc = LatestNewsProvider.of(context);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Pallete.text_primary_color, Pallete.light_primary_color],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Crypto'),
          backgroundColor: Colors.purple[700],
        ),
        body: StreamBuilder(
            stream: bloc.loginStream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                Navigator.pop(context);
                WidgetsBinding.instance!.addPostFrameCallback((_) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => const HomeScreen()));
                });
              } else if (snapshot.hasError) {
                Navigator.pop(context);

                hasErr = true;
                errTxt = snapshot.error.toString();
              }
              return Padding(
                  padding: const EdgeInsets.all(10),
                  child: ListView(
                    children: <Widget>[
                      Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            'NBTX',
                            style: TextStyle(
                                color: Colors.purple[700],
                                fontWeight: FontWeight.w500,
                                fontSize: 30),
                          )),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: TextField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Username',
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: TextField(
                          obscureText: true,
                          controller: passwordController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                          height: 50,
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.purple[700]),
                            child: const Text('Login'),
                            onPressed: () {
                              // setState(() {
                              // isButtonPressed = true;
                              // hasErr = false;
                              showLoaderDialog(context);
                              bloc.login(
                                  nameController.text, passwordController.text);
                              // });
                            },
                          )),
                      hasErr == true
                          ? Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: Center(
                                  child: Text(
                                errTxt.toString(),
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              )))
                          : Container()
                    ],
                  ));
            }),
      ),
    );
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          CircularProgressIndicator(color: Pallete.dark_primary_color),
          Container(
              margin: const EdgeInsets.only(left: 7),
              child: const Text("Login...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
