/* RF001 Login / Logout
●	A tela de login contém campos de e-mail, senha, logotipo e botões de "Entrar" e "Cadastrar".
●	Validação correta de e-mail (formato) e campos vazios.
●	O botão "Entrar" aciona o login, e "Cadastrar" navega para o cadastro de usuário.
●	O logout redireciona para a tela de login, descartando dados.
*/

import 'package:flutter/material.dart';
import 'package:preojeto/model/user_model.dart'; // Importa a classe Usuario

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  // Identificador do Formulário
  final formKey = GlobalKey<FormState>();

  final primaryColor = const Color.fromARGB(255, 0, 0, 0);

  // Controladores dos campos de texto
  final txtValor1 = TextEditingController();
  final txtValor2 = TextEditingController();

  bool _rememberMe = false;
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Plano de Fundo
      body: Container(
        color: const Color(0xFFFFD600),
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(50, 60, 50, 60),
            child: Column(
              children: [
                const SizedBox(height: 20),

                // Logo
                const Image(
                  image: AssetImage("lib/images/logo.jpeg"),
                  width: 200,
                ),
                const SizedBox(height: 15),

                // Texto de identificação de tela => Login
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Login',
                        style: TextStyle(fontSize: 18, color: primaryColor)),
                  ],
                ),
                const SizedBox(height: 5),

                // Campo e-mail ou usuário
                TextFormField(
                  controller: txtValor1,
                  style: const TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Usuário ou e-mail',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira seu e-mail ou usuário';
                    } else if (!RegExp(r"^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value) &&
                        !Usuario.usuarios.any((user) => user.nome == value)) {
                      return 'Formato de e-mail ou usuário inválido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Campo Senha
                TextFormField(
                  controller: txtValor2,
                  style: const TextStyle(fontSize: 18),
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Senha',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe sua senha';
                    } else if (value.length < 6) {
                      return 'A senha deve ter pelo menos 6 caracteres';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                // Lembre de mim
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Checkbox(
                      value: _rememberMe,
                      onChanged: (bool? value) {
                        setState(() {
                          _rememberMe = value!;
                        });
                      },
                      activeColor: Colors.blue,
                      checkColor: Colors.white,
                    ),
                    const Text('Lembre de mim'),
                    const SizedBox(width: 30),

                    // TextButton Esqueci a senha
                    TextButton(
                      onPressed: () {
                        // Redireciona para a tela de "Esqueci a senha"
                        Navigator.pushNamed(context, 'esqueci_senha');
                      },
                      child: const Text(
                        "Esqueci a senha",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),

                // Botão de Login
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(300, 50),
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(fontSize: 15),
                  ),
                  onPressed: () {
                    // Validação do formulário
                    if (formKey.currentState!.validate()) {
                      String emailOuUsuario = txtValor1.text;
                      String senha = txtValor2.text;

                      // Verifica se o login é do administrador (usuário: admin, senha: 123456)
                      if (emailOuUsuario == 'admin@email.com' && senha == '123456') {
                        // Redireciona para a tela de admin
                        Navigator.pushNamed(context, 'menu');
                      } else {
                        // Verifica se o usuário existe no vetor
                        Usuario? usuario = Usuario.usuarios.firstWhere(
                          (user) =>
                              (user.email == emailOuUsuario ||
                                  user.nome == emailOuUsuario) &&
                              user.senha == senha,
                          orElse: () => Usuario(
                              nome: '', email: '', senha: ''), // Objeto vazio
                        );

                        if (usuario.nome.isNotEmpty) {
                          // Login bem-sucedido
                          Navigator.pushNamed(context, 'menu');
                        } else {
                          // Login falhou
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Login ou senha inválidos'),
                            ),
                          );
                        }
                      }
                    }
                  },
                  child: const Text('Login'),
                ),
                const SizedBox(height: 15),

                // Botão Cadastro
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(300, 50),
                    backgroundColor: const Color.fromRGBO(122, 124, 125, 1),
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(fontSize: 15),
                  ),
                  onPressed: () {
                    // Redirecionar para a tela de cadastro
                    Navigator.pushNamed(context, 'cadastro');
                  },
                  child: const Text('Cadastrar'),
                ),
                const SizedBox(height: 10),

                // Botão pequeno para ver itens sem login
                /*TextButton(
                  onPressed: () {
                    // Redirecionar para a tela de itens sem login
                    Navigator.pushNamed(context, 'itens');
                  },
                  child: const Text(
                    'Ver Itens sem Login',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Função para realizar logout (incluída no menu ou onde for apropriado)
void logout(BuildContext context) {
  Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
}
