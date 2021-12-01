import 'package:cryptocurrency/src/accessories/pallete.dart';
import 'package:cryptocurrency/src/blocs/latest_news_provider.dart';
import 'package:cryptocurrency/src/widgets/user_secure_storage.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<LoginScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool hasErr = false;
  late String errTxt;
  bool isChecked = false;

  @override
  void initState() {
    super.initState();

    init();
  }

  Future init() async {
    final name = await UserSecureStorage.getUserName() ?? '';
    final password = await UserSecureStorage.getPassword() ?? '';

    setState(() {
      nameController.text = name;
      passwordController.text = password;
    });
  }

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
          backgroundColor: Pallete.dark_primary_color,
        ),
        body: StreamBuilder(
            stream: bloc.loginStream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                final String token = snapshot.data['key'];
                Navigator.pop(context);
                WidgetsBinding.instance!.addPostFrameCallback((_) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => HomeScreen(token)));
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
                      Row(
                        children: [
                          Checkbox(
                              value: isChecked,
                              onChanged: (bool? value) {
                                setState(() {
                                  isChecked = value!;
                                });
                              }),
                          Text(
                            'Remember me',
                            style:
                                TextStyle(color: Pallete.secondary_text_color),
                          )
                        ],
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
                            onPressed: () async {
                              // setState(() {
                              // isButtonPressed = true;
                              // hasErr = false;
                              showLoaderDialog(context);
                              if (isChecked) {
                                await UserSecureStorage.setUserName(
                                    nameController.text);
                                await UserSecureStorage.setPassword(
                                    passwordController.text);
                              }
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
