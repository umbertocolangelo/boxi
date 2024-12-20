import 'package:flutter/material.dart';

class UnAuthWidget extends StatefulWidget {
  const UnAuthWidget({Key? key}) : super(key: key);

  @override
  _UnAuthWidgetState createState() => _UnAuthWidgetState();

}

class _UnAuthWidgetState extends State<UnAuthWidget> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
      return Center(
        child: Container(
          margin: const EdgeInsets.only(top: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [
                          Colors.black.withOpacity(1),
                          Colors.black.withOpacity(0.2),
                        ],
                      ),
                    ),
                    child: const Icon(
                      Icons.lock,
                      color: Colors.white,
                      size: 90,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 15),
              //const Opacity(
              //opacity: 0.6,
              /*child:*/ const Text(
                "Devi accedere con le tue credenziali per poter proseguire con questa pagina",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,),
              ),
              //),
              const SizedBox(
                height: 30,
              ),
              TextButton(
                onPressed: () {
                  /*
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                  */
                },
                style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6))),
                child: const Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }
}