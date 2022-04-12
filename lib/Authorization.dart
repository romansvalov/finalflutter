import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthPage extends StatefulWidget {
  AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _pwdHidden = true;

  final _formKey = GlobalKey<FormState>();

  final _login = TextEditingController();
  final _passwd = TextEditingController();

  @override
  void dispose() {
    _login.dispose();
    _passwd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _LoginForm(),
    );
  }

  void _isValid() async {
    final prefs = await SharedPreferences.getInstance();
    var _summ = _login.text + _passwd.text;

    if (prefs.getInt('password') == _passwd.text.hashCode) {
      if (_summ.hashCode == prefs.getInt('login')) {
        Navigator.pushNamed(context, '/ list');
      }
    } else {
      showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('Данные введены неверно'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('ясно'),
                onPressed: () {
                  Navigator.pushNamed(context, '/');
                },
              ),
            ],
          );
        },
      );
    }
  }

  Widget _LoginForm() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 70),
        child: ListView(
          children: [
            const SizedBox(
              height: 50,
            ),
            const Text(
              'АВТОРИЗАЦИЯ',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 60,
            ),
            TextFormField(
              controller: _login,
              decoration: const InputDecoration(
                labelText: 'Телефон',
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.black12, width: 2)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.blueAccent, width: 2)),
              ),
              onSaved: (String? value) {
              },
              validator: (String? val) =>
              val!.isEmpty ? 'Введите номер телефона' : null,
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _passwd,
              obscureText: _pwdHidden,
              maxLength: 10,
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.black12, width: 2)),
                focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.blueAccent, width: 2)),
                labelText: 'Пароль',
                suffixIcon: IconButton(
                  icon:
                  Icon(_pwdHidden ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _pwdHidden = !_pwdHidden;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(width: 60, height: 50,
              child: ElevatedButton(
                  onPressed: () {
                    _isValid();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(36.0),
                    ),
                  ),
                  child: const Text('ВХОД')),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 14),
                primary: Colors.blueAccent,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/ reg');
              },
              child: const Text('РЕГИСТРАЦИЯ'),
            )
          ],
        ),
      ),
    );
  }
}


class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  bool _pwdHide = true;
  final _formKey = GlobalKey<FormState>();
  final _loginCtrl = TextEditingController();
  final _pwdCtrl = TextEditingController();
  final _returnpwdCtrl = TextEditingController();
  final _nameCtrl = TextEditingController();

  @override
  void dispose() {
    _loginCtrl.dispose();
    _pwdCtrl.dispose();
    _returnpwdCtrl.dispose();
    _nameCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(45.0),
          children: [
            const SizedBox(
              height: 80,
            ),
            const Text(
              'РЕГИСТРАЦИЯ',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black45
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: _nameCtrl,
              decoration: const InputDecoration(
                labelText: 'Имя',
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(36)),
                    borderSide: BorderSide(color: Colors.black12, width: 2)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(36)),
                    borderSide: BorderSide(color: Colors.blueAccent, width: 2)),
              ),
              onSaved: (String? value) {
              },
              validator: (String? val) =>
              val!.isEmpty ? 'Имя:' : null,
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: _loginCtrl,
              decoration: const InputDecoration(
                labelText: 'Телефон:',
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(36)),
                    borderSide: BorderSide(color: Colors.black12, width: 2)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(36)),
                    borderSide: BorderSide(color: Colors.blueAccent, width: 2)),
              ),
              onSaved: (String? value) {
              },
              validator: (String? val) =>
              val!.isEmpty ? 'Номер телефона' : null,
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: _pwdCtrl,
              obscureText: _pwdHide,
              maxLength: 10,
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(36)),
                    borderSide: BorderSide(color: Colors.black12, width: 2)),
                focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(36)),
                    borderSide: BorderSide(color: Colors.blueAccent, width: 2)),
                labelText: 'Пароль',
                suffixIcon: IconButton(
                  icon:
                  Icon(_pwdHide ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _pwdHide = !_pwdHide;
                    });
                  },
                ),
              ),
              validator: _check,
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: _returnpwdCtrl,
              obscureText: _pwdHide,
              maxLength: 10,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(36)),
                    borderSide: BorderSide(color: Colors.black12, width: 2)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(36)),
                    borderSide: BorderSide(color: Colors.blueAccent, width: 2)),
                labelText: 'Повторить пароль',
              ),
              validator: _check,
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(width: 60, height: 60,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(36.0),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _isValid();
                    }
                  },
                  child: const Text('РЕГИСТРАЦИЯ')),
            ),
            const SizedBox(
              height: 15,
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 16),
                primary: Colors.blueAccent,
              ),
              onPressed: () {Navigator.pushNamed(context, '/');},
              child: const Text('ЗАКРЫТЬ'),
            )
          ],
        ),
      ),
    );
  }

  String? _check(String? value) {
    if (_pwdCtrl.text.length < 4) {
      return 'Слишком короткий пароль';
    } else if (_pwdCtrl.text != _returnpwdCtrl.text) {
      return 'Пароли не совпадают';
    } else {
      return null;
    }
  }

  void _isValid() async {
    final prefs = await SharedPreferences.getInstance();
    var _chkSum = _loginCtrl.text + _pwdCtrl.text;
    prefs.setString('name', _nameCtrl.text);
    prefs.setInt('password', _pwdCtrl.text.hashCode);
    prefs.setInt('login', _chkSum.hashCode);
    _registrationDlg(prefs: prefs);
  }

  Future<void> _registrationDlg({prefs}) async {
    var name = prefs.getString('name');
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('УСПЕХ!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Вы зарегистрированы.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('ПРОДОЛЖИТЬ'),
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
            ),
          ],
        );
      },
    );
  }
}
