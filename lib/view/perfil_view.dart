import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:preojeto/model/user_model.dart'; // Certifique-se de que esse caminho está correto

class PerfilView extends StatefulWidget {
  const PerfilView({super.key});

  @override
  State<PerfilView> createState() => _PerfilViewState();
}

class _PerfilViewState extends State<PerfilView> {
  var nomeAtual = '';
  var emailAtual = '';
  var senhaAtual = '';

  // Função que verifica se há usuários e preenche com dados de teste se necessário
  void checaUser() {
    if (Usuario.usuarios.isNotEmpty) {
      nomeAtual = Usuario.usuarios[0].nome;
      emailAtual = Usuario.usuarios[0].email;
      senhaAtual = Usuario.usuarios[0].senha;
    }
  }

  bool obscureText_ = true;
  int _currentIndex = 2; // Para controlar a navegação

  // Função para alternar entre diferentes telas da BottomNavigationBar
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    if (index == 0) {
      // Lógica para a tela de Menu
      Navigator.pushReplacementNamed(context, 'menu');
    } else if (index == 1) {
      // Navegar para a tela de categorias
      Navigator.pushReplacementNamed(context, 'historico');
    } else if (index == 2) {
      Navigator.pushReplacementNamed(context, 'perfil');
    }
  }

  @override
  void initState() {
    super.initState();
    checaUser(); // Chama a função para verificar e preencher os dados do usuário
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove o botão de voltar
        backgroundColor: Color(0xFFFFD600),
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Perfil de Usuário'),
                Image.network(
                  'lib/images/heads.png',
                  height: 40,
                ),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(50, 40, 50, 10),
        child: Column(
          children: [
            SizedBox(
              height: 150,
              width: 150,
              child: ImageNetwork(
                image:
                    'lib/images/heisenberg.jpeg', // Certifique-se de que essa imagem existe
                height: 150,
                width: 150,
                borderRadius: BorderRadius.circular(100),
                curve: Curves.easeIn,
                fitWeb: BoxFitWeb.cover,
                onLoading: const CircularProgressIndicator(
                  color: Colors.indigoAccent,
                ),
              ),
            ),
            const SizedBox(height: 40),
            TextFormField(
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
              readOnly: true,
              initialValue: nomeAtual,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: 'Nome',
                labelStyle: const TextStyle(
                  color: Colors.black,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
              readOnly: true,
              initialValue: emailAtual,
              decoration: InputDecoration(
                labelText: 'E-mail',
                filled: true,
                fillColor: Colors.white,
                labelStyle: const TextStyle(
                  color: Colors.black,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
              readOnly: true,
              initialValue: senhaAtual,
              obscureText:
                  obscureText_, // Controla se a senha está oculta ou visível
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: 'Senha',
                labelStyle: const TextStyle(
                  color: Colors.black,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                // O suffixIcon deve estar dentro do InputDecoration
                suffixIcon: IconButton(
                  icon: Icon(
                    obscureText_ ? Icons.visibility_off : Icons.visibility,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      obscureText_ =
                          !obscureText_; // Alterna entre visível e oculto
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red,
                minimumSize: const Size(150, 60),
                maximumSize: const Size(150, 70),
                textStyle: const TextStyle(fontSize: 18),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                        'Deslogando...\nDirecionado para a página de Login!'),
                  ),
                );

                // Após o logout, navega para a tela de login.
                Future.delayed(const Duration(seconds: 1), () {
                  Navigator.pushReplacementNamed(context, 'splash');
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('Sair'),
                  SizedBox(width: 15),
                  Icon(Icons.logout),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.black,
        backgroundColor: const Color(0xFFFFD600),
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long),
              label: 'Pedidos'), //Utilizado Direto no Menu
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }
}
