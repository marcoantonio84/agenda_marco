import 'package:flutter/material.dart';
import '../models/contato.dart';

class ContatoForm extends StatefulWidget {
  final Function(Contato) onSubmit;
  final Function? onDelete; // Adicionando função onDelete
  final Contato? contato;

  const ContatoForm({
    Key? key,
    required this.onSubmit,
    this.onDelete,
    this.contato,
  }) : super(key: key);

  @override
  _ContatoFormState createState() => _ContatoFormState();
}

class _ContatoFormState extends State<ContatoForm> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.contato != null) {
      _nomeController.text = widget.contato!.nome;
      _telefoneController.text = widget.contato!.telefone;
      _emailController.text = widget.contato!.email;
    }
  }

  void _saveContato() {
    if (_formKey.currentState!.validate()) {
      print("Salvando contato: ${_nomeController.text}");
      widget.onSubmit(Contato(
        nome: _nomeController.text,
        telefone: _telefoneController.text,
        email: _emailController.text,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _nomeController,
            decoration: const InputDecoration(labelText: 'Nome'),
            validator: (value) {
              if (value!.isEmpty) return 'Campo obrigatório';
              return null;
            },
          ),
          TextFormField(
            controller: _telefoneController,
            decoration: const InputDecoration(labelText: 'Telefone'),
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value!.isEmpty) return 'Campo obrigatório';
              return null;
            },
          ),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: 'E-mail'),
            validator: (value) {
              if (value!.isEmpty || !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                return 'E-mail inválido';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: _saveContato,
                child: const Text('Salvar'),
              ),
              if (widget.contato != null) // Exibe o botão de excluir somente se for edição
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    if (widget.onDelete != null) {
                      widget.onDelete!(); // Chama a função de exclusão
                    }
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }
}
