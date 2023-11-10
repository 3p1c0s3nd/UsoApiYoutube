import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Bienvenido',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black38,
                        blurRadius: 20,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.grey)),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Usuario",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: "Contraseña",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    searchYouTubeVideos('Flutter');
                    // Implementar   funcionalidad de inicio de sesión
                  },
                  child: Container(
                    height: 50,
                    margin: EdgeInsets.symmetric(horizontal: 50),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.blue[800],
                    ),
                    child: Center(
                      child: Text(
                        "Iniciar sesión",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    // Navegar a la pantalla de registro
                  },
                  child: Text(
                    "Registrarse",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}




Future<void> searchYouTubeVideos(String query) async {
  var apiKey = 'AIzaSyB8PzTxmzUo38BCclNkMlsuwkU4K5B5xK8'; // Reemplaza con tu clave API de YouTube
  var url = 'https://www.googleapis.com/youtube/v3/search?part=snippet&q=$query&type=video&key=$apiKey';

  var response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    // Trabaja con los datos, por ejemplo, actualiza la interfaz de usuario con los resultados
    print(data);
  } else {
    // Manejo de errores
    print('Failed to load videos');
  }
}