import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'contato_form.dart'; // Tela de formulário de contato
import '../models/contato.dart'; // Modelo de contato

class ContatosPage extends StatefulWidget {
  @override
  _ContatosPageState createState() => _ContatosPageState();
}

class _ContatosPageState extends State<ContatosPage> {
  List<Contato> itens = [];

  void _addOrEditContato({Contato? contato}) async {
    final result = await showDialog<Contato>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(contato == null ? 'Novo Contato' : 'Editar Contato'),
          content: SizedBox(
            height: 300,
            child: ContatoForm(
              onSubmit: (novoContato) {
                Navigator.of(context).pop(novoContato); // Retorna o novo contato
              },
              onDelete: contato != null
                  ? () {
                      _deleteContato(contato); // Chama a função de exclusão
                      Navigator.of(context).pop(); // Fecha o diálogo após a exclusão
                    }
                  : null, // Não passa nada se for novo contato
              contato: contato,
            ),
          ),
        );
      },
    );

    // Verifica se o resultado não é nulo
    if (result != null && contato == null) {
      setState(() {
        itens.add(result); // Adiciona novo contato
      });
    }
  }

  void _deleteContato(Contato contato) {
    setState(() {
      itens.remove(contato);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contatos'),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.orange,
            padding: EdgeInsets.all(16),
            alignment: Alignment.center,
            child: Text(
              'Agenda Marco',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: itens.length,
              itemBuilder: (context, index) {
                final contato = itens[index];
                return Slidable(
                  startActionPane: ActionPane(
                    motion: const DrawerMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) => _deleteContato(contato),
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Excluir',
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: Text(contato.nome),
                    subtitle: Text(contato.telefone),
                    onTap: () => _addOrEditContato(contato: contato),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addOrEditContato(),
        child: Icon(Icons.add),
        backgroundColor: Colors.orange,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
