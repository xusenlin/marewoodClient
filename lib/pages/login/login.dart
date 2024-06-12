import 'package:flutter/material.dart';
import 'package:marewood_client/stores/system.dart';
import 'package:provider/provider.dart';
import '../../api/login.dart';
import '../../config/app.dart';
import '../../stores/user.dart';
import '../../stores/userProvider.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  Future<Map<String, String>> _loadLocalInfo() async {
    var user = await UserStore.getUser();
    var address = await SystemStore.getAddress();
    return {
      'username': user != null ? user.username : '',
      'address': address ?? '',
    };
  }

  @override
  Widget build(BuildContext context) {

    var userProvider = Provider.of<UserProvider>(context,listen: false);

    return FutureBuilder<Map<String, String>>(
        future: _loadLocalInfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            final data = snapshot.data;
            var name = data == null ? "" : data['username'];
            var address = data == null ? "" : data['address'];
            final TextEditingController usernameController =
                TextEditingController(text: name);
            final TextEditingController addressController =
                TextEditingController(text: address);
            final TextEditingController passwordController =
                TextEditingController();
            return Scaffold(
              appBar: AppBar(
                title: const Text('Login'),
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset("assets/img/logo.png", width: 80),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 40, top: 10),
                      child: Text("$appName $appVersion"),
                    ),
                    TextField(
                      controller: usernameController,
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0))),
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    TextField(
                      controller: passwordController,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0))),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 24.0),
                    TextField(
                      controller: addressController,
                      decoration: const InputDecoration(
                        labelText: 'Address',
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0))),
                      ),
                    ),
                    const SizedBox(height: 26.0),
                    MaterialButton(
                      color: Theme.of(context).colorScheme.primary,
                      textColor: Theme.of(context).colorScheme.onPrimary,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      minWidth: double.infinity,
                      onPressed: () async {
                        String username = usernameController.text;
                        String password = passwordController.text;
                        String address = addressController.text;
                        try {
                          if (!address.contains("http")) {
                            throw Exception(
                                'Please enter the correct HTTP address.');
                          }
                          await SystemStore.setAddress(address);
                          var user = await fetchLoginUser(username, password);
                          if (!context.mounted) return;
                          userProvider.setUser(user);
                          Navigator.pop(context);
                        } catch (e) {
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.toString())));
                        }
                      },
                      child: const Text('Login'),
                    ),
                    const SizedBox(height: 24.0),
                  ],
                ),
              ),
            );
          }
        });
  }
}
