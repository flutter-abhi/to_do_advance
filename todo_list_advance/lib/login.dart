import 'package:flutter/material.dart';
import 'todoList.dart';

int _userIndex = -1;

//login page info
//
class UserModelClass {
  String userName;
  String password;
  UserModelClass({required this.userName, required this.password});
}

List userDataList = [
  UserModelClass(userName: "Lalit", password: "Admin"),
  UserModelClass(userName: "prajwal", password: "Admin"),
  UserModelClass(userName: "abhishek", password: "Admin"),
];

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //finding user in list if find return true
  bool findUser(value) {
    _userIndex =
        userDataList.indexWhere((element) => element.userName == value);
    if (_userIndex != -1) {
      return true;
    }
    return false;
  }

// password check if pass is match return true
  bool passchek(value) {
    if (value == userDataList[_userIndex].password) {
      return true;
    }
    return false;
  }

  //for eye Icon
  bool displayPass = true;

  TextEditingController userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   title: const Text(
      //     "Login page",
      //     style: TextStyle(color: Colors.black),
      //   ),
      //   centerTitle: true,
      // ),
      body: Container(
        color: Colors.grey.shade300,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
                top: 100, right: 15, left: 15, bottom: 20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        // (displayPass)
                        //     ? Image.network(
                        //         "https://w7.pngwing.com/pngs/340/946/png-transparent-avatar-user-computer-icons-software-developer-avatar-child-face-heroes-thumbnail.png",
                        //         height: 90,
                        //         width: 90,
                        //       )
                        //   :
                        Image.network(
                          "https://ps.w.org/user-avatar-reloaded/assets/icon-256x256.png?rev=2540745",
                          height: 90,
                          width: 90,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: userNameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Plese Enter Username";
                            } else if (value.contains('@')) {
                              return "Dont use @ ";
                            } else if (!findUser(value)) {
                              return " User not Found ";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.person),
                            // helperText: "Username",
                            label: const Text("Enter user Name"),
                            hintText: "Enter user Name",
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          obscureText: displayPass,
                          obscuringCharacter: '*',
                          controller: _passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Plese Enter password";
                            } else if (!passchek(value)) {
                              return "Incorrect password";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: (displayPass)
                                ? IconButton(
                                    icon: const Icon(
                                        Icons.visibility_off_outlined),
                                    onPressed: () {
                                      setState(() {
                                        displayPass = !displayPass;
                                      });
                                    },
                                  )
                                : IconButton(
                                    icon: const Icon(Icons.visibility),
                                    onPressed: () {
                                      setState(() {
                                        displayPass = !displayPass;
                                      });
                                    },
                                  ),
                            label: const Text("Enter user Password"),
                            hintText: "Enter user Password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 4, bottom: 20, left: 10, right: 10),
                          child: Row(
                            children: [
                              GestureDetector(
                                child: const Text("Create Account"),
                              ),
                              const Spacer(),
                              GestureDetector(
                                child: const Text("Forgot password"),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  shape: ContinuousRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  backgroundColor: Colors.green.shade400,
                                  content: const Text("Login sucsseful"),
                                ),
                              );
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (builder) {
                                return const Todo_list_home();
                              }));

                              //login sucssesful zalyavar ethe
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.red.shade400,
                                  content: const Text(
                                    "Login Fail (:",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              );
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 10, bottom: 60),
                            height: 50,
                            width: 250,
                            decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(10)),
                            child: const Center(
                                child: Text(
                              "Login",
                              style: TextStyle(fontSize: 26),
                            )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
