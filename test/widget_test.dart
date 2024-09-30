import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:agendamarco2/main.dart';

void main() {
  testWidgets('Adicionar um contato', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verifique se a tela de contatos é exibida.
    expect(find.text('Agenda Marco'), findsOneWidget);

    // Clique no botão de adicionar.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle(); // Aguarda a animação de transição

    // Verifique se o campo de nome está presente.
    expect(find.byType(TextFormField),
        findsNWidgets(3)); // Verifica se há 3 campos (Nome, Telefone, E-mail)

    // Preencha o formulário.
    await tester.enterText(
        find.byType(TextFormField).at(0), 'João da Silva'); // Nome
    await tester.enterText(
        find.byType(TextFormField).at(1), '123456789'); // Telefone
    await tester.enterText(
        find.byType(TextFormField).at(2), 'joao@example.com'); // E-mail

    // Clique no botão Salvar.
    await tester.tap(find.text('Salvar'));
    await tester.pumpAndSettle(); // Aguarda a animação de retorno

    // Verifique se o novo contato foi adicionado à lista.
    expect(find.text('João da Silva'), findsOneWidget);
    expect(find.text('123456789'), findsOneWidget);
    expect(find.text('joao@example.com'),
        findsNothing); // O e-mail não deve aparecer na lista
  });
}
