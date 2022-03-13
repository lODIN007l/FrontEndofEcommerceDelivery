import 'package:delivery_app/src/pages/login/login_controller.dart';
import 'package:delivery_app/src/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lottie/lottie.dart';

Logincontroller _con = Logincontroller();

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Logincontroller _con = new Logincontroller();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      _con.init(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Stack(
            children: [
              const Positioned(
                left: -100,
                top: -80,
                child: LoginCircle(),
              ),
              const Positioned(
                child: Text(
                  'LOGIN',
                  style: TextStyle(
                      fontFamily: 'NimbusSans',
                      fontSize: 26,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                top: 60,
                left: 25,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: 150,
                      bottom: MediaQuery.of(context).size.height * 0.10,
                    ),
                    child: Lottie.asset('assets/json/delivery.json',
                        width: 400, height: 250, fit: BoxFit.fill),
                  ),

                  //const _BannerImage(),
                  const _EmailText(),
                  const _PasswordW(),
                  const _IngresarBtn(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '¿No tienes cuenta?',
                        style: TextStyle(
                          color: MyColors.primaryColor,
                        ),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, 'register');
                        },
                        child: Text(
                          'Registrate',
                          style: TextStyle(
                              color: MyColors.primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginCircle extends StatelessWidget {
  const LoginCircle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      height: 230,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: MyColors.primaryColor),
    );
  }
}

class _IngresarBtn extends StatelessWidget {
  const _IngresarBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      child: ElevatedButton(
        onPressed: () {
          _con.loginM(context);
        },
        child: const Text(
          'INGRESAR',
          style: TextStyle(fontSize: 20),
        ),
        style: ElevatedButton.styleFrom(
            primary: MyColors.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            padding: const EdgeInsets.symmetric(vertical: 15)),
      ),
    );
  }
}

class _PasswordW extends StatelessWidget {
  const _PasswordW({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: _con.passwordCtrl,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(15),
          prefixIcon: Icon(
            Icons.vpn_key,
            color: MyColors.primaryColor,
          ),
          hintStyle: TextStyle(color: MyColors.primaryColorDark),
          hintText: 'Contraseña',
        ),
      ),
    );
  }
}

class _EmailText extends StatelessWidget {
  const _EmailText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: _con.emailCtrl,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(15),
          prefixIcon: Icon(
            Icons.email,
            color: MyColors.primaryColor,
          ),
          hintStyle: TextStyle(color: MyColors.primaryColorDark),
          hintText: 'Correo Electronico',
        ),
      ),
    );
  }
}

class _BannerImage extends StatelessWidget {
  const _BannerImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 100,
        bottom: MediaQuery.of(context).size.height * 0.22,
      ),
      child: Image.asset(
        'assets/img/delivery.png',
        width: 200,
        height: 200,
      ),
    );
  }
}
