import 'package:flutter/material.dart';
import 'package:marewood_client/stores/system.dart';
import 'package:marewood_client/stores/themeProvider.dart';
import 'package:provider/provider.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';
import '../../api/login.dart';
import '../../config/app.dart';
import '../../stores/user.dart';
import '../../stores/userProvider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState()  => LoginState();
}

class LoginState extends State<Login>{

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  InputDecoration textFieldDecoration (Color themeColor,String labelText){
    return InputDecoration(
      filled: true,
      fillColor: const Color.fromARGB(255, 241, 244, 255),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Colors.transparent, // 未对焦时去掉边框
        ),
      ),
      labelText: labelText,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: themeColor, // 设置对焦时的边框颜色
          width: 2.0,
        ),
      ),
    );
  }


  void initLocalData() async {
    var user = await UserStore.getUser();
    var address = await SystemStore.getAddress();
    if(user!=null){
      usernameController.text = user.username;
    }
    if(address!=null){
      addressController.text = address;
    }
  }

  Future<void> submitLogin(BuildContext context) async {
    var userProvider = Provider.of<UserProvider>(context,listen: false);

    String username = usernameController.text;
    String password = passwordController.text;
    String address = addressController.text;
    try {
      if (!address.contains("http")) {
        throw Exception('Please enter the correct HTTP address.');
      }
      await SystemStore.setAddress(address);
      var user = await fetchLoginUser(username, password);
      if (!context.mounted) return;
      userProvider.setUser(user);
      Navigator.pop(context);
    } catch (e) {
      if (!context.mounted) return;
      TDToast.showText(e.toString(), context: context);
    }
  }

  @override
  void initState() {
    initLocalData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    var themeProvider = Provider.of<ThemeProvider>(context);


    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(color: Colors.white),
          Image.asset("assets/img/login.png",fit: BoxFit.cover),
          SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                    Image.asset("assets/img/logo.png", width: 80),
                    const SizedBox(height: 24.0),
                    Text(appName,style: TextStyle(color: themeProvider.themeColor,fontSize: 20,fontWeight: FontWeight.w700,letterSpacing:10)),
                    const SizedBox(height: 24.0),
                    TextField(
                      controller: usernameController,
                      decoration: textFieldDecoration(themeProvider.themeColor,"Username"),
                    ),
                    const SizedBox(height: 24.0),
                    TextField(
                      controller: passwordController,
                      decoration: textFieldDecoration(themeProvider.themeColor,"Password"),
                      obscureText: true,
                    ),
                    const SizedBox(height: 24.0),
                    TextField(
                      controller: addressController,
                      decoration: textFieldDecoration(themeProvider.themeColor,"Address"),
                    ),
                    const SizedBox(height: 60.0),
                    MaterialButton(
                      color: themeProvider.themeColor,
                      textColor: Theme.of(context).colorScheme.onPrimary,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      minWidth: double.infinity,
                      onPressed: () async => await submitLogin(context),
                      child: const Text('Login'),
                    ),
                    const SizedBox(height: 24.0),
                    Row(
                      children: [
                        TextButton(
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            child: const Text("Back Home"),
                        )
                      ],
                    ),
                    // SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}