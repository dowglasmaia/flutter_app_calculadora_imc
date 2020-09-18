import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  String _infoText = "Informe seus dados!";

  void _restFields() {
    setState(() {
      pesoController.text = "";
      alturaController.text = "";

      _infoText = "Informe seus dados!";
    });
  }

  void _calcularDados() {
    setState(() {
      double peso = double.parse(pesoController.text);

      // altura deve ser convertido para metros
      double altura = double.parse(alturaController.text) / 100;

      /* O cálculo do IMC é feito dividindo o peso (em quilogramas) pela altura (em metros) ao quadrado*/
      double imc = peso / (altura * altura);

      print(imc);
      /* Validações */
      if (imc < 18.6) {
        _infoText = "Abaixo do Peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = "Peso Ideal (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = "Levimente Acima do Peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = "Obesidade Grau I (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = "Obesidade Grau II (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 40) {
        _infoText = "Obesidade Grau III (${imc.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //barra
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        //acções e icon
        actions: <Widget>[
          /*BUTÃO REFRESH*/
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _restFields();
            },
          )
        ],
      ),

      //corp do app
      backgroundColor: Colors.white,
      body:
          /*SingleChildScrollView  -  rolagem*/
          SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),

        /* FORM DE DADOS */
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.person_outline, size: 120.0, color: Colors.green),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Peso (kg)",
                  labelStyle: TextStyle(color: Colors.green),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.2),
                controller: pesoController,
                validator: (value) {
                  if(value.isEmpty){
                    return "Insira seu Peso";
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Altura (cm)",
                  labelStyle: TextStyle(color: Colors.green),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.2),
                controller: alturaController,
                validator: (value) {
                  if(value.isEmpty){
                    return "Insira sua Altura";
                  }
                },
              ),

              /* ### butão ###*/
              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: Container(
                  height: 50.0,
                  child:
                  /*BOTÃO CALCULAR*/
                  RaisedButton(
                    onPressed: (){
                      if(_formKey.currentState.validate()){
                        _calcularDados();
                      }
                    },
                    child: Text(
                      "Calcular",
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                    color: Colors.green,
                  ),
                ),
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
