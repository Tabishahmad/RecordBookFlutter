import 'package:first_flutter/utils/routes.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String name = "";
  bool changedButton = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Column(
        children: [
          Image.asset("assets/images/login_image.png",
              width: 100, height: 100, fit: BoxFit.fill),
          Text(
            "Welcome $name",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: EdgeInsets.all(18.0),
            child: Column(children: [
              TextFormField(
                decoration: InputDecoration(
                    hintText: "Enter User Name", labelText: "username"),
                onChanged: (value) {
                  name = value;
                  setState(() {});
                },
              ),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(hintText: "Enter Password"),
              ),
              SizedBox(
                height: 20.0,
              ),
              InkWell (
                  onTap: () async{
                    setState(() {
                      changedButton = true;
                    });
                    await Future.delayed(Duration(seconds: 1));
                    Navigator.pushNamed(context, MyRoutes.homeRoute);
                  },
                  child: AnimatedContainer(
                    duration: Duration(seconds: 1),
                width: changedButton?50:150,
                height: 50,
                alignment: Alignment.center,
                child: changedButton ? Icon(Icons.done,color: Colors.white)
                    :Text(
                  "Login",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    // shape: changedButton ? BoxShape.circle : BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(changedButton?50:8)
                ),
              ))
              ]),
          )
        ],
      ),
    );
  }
}
