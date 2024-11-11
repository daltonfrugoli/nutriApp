import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';

class DynamicConsultation extends StatefulWidget {
  final String type; // Esta variável define o tipo de conteúdo
  final Map<String, dynamic> item;

  const DynamicConsultation(
      {super.key, required this.type, required this.item});

  @override
  DynamicConsultationState createState() => DynamicConsultationState();
}

class DynamicConsultationState extends State<DynamicConsultation> {
  @override
  Widget build(BuildContext context) {
    List<Widget> children;
    Map<String, dynamic> widgetItem = widget.item;

    // Escolhe os widgets com base no valor de 'type'
    switch (widget.type) {
      case 'user':
        //String birth = widgetItem['birth']; // Exemplo de data de nascimento
        DateTime birth = DateTime.parse(widgetItem['birth']); // Converte para DateTime
        DateTime currentDate = DateTime.now();

        int age = currentDate.year - birth.year;

        // Ajusta a age se ainda não tiver feito aniversário no ano atual
        if (currentDate.month < birth.month || 
            (currentDate.month == birth.month && currentDate.day < birth.day)) {
          age--;
        }

        children = [
          Image.file(File(widgetItem['picture_path']),
            width: 200,   // Largura da imagem
            height: 150,
            fit: BoxFit.contain,
          ),
          Row(
            children: [
              const Text('Name:', style: TextStyle(fontWeight: FontWeight.bold)),
              Text(' ${widgetItem['name']}'),
            ],
          ),
          Row(
            children: [
              const Text('Age: ', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('$age anos de idade'),
            ],
          ),
          ElevatedButton(
              onPressed: () {
                Share.share('User ${widgetItem['name']} is $age years old.');
              },
              child: const Text('Share'))
        ];
        break;
      case 'food':
        children = [
          Image.file(File(widgetItem['picture_path']),
            width: 200,   // Largura da imagem
            height: 150,
            fit: BoxFit.contain,
          ),
          Row(
            children: [
              const Text('Food Name: ', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('${widgetItem['name']}')
            ],
          ),
          Row(
            children: [
              const Text('Category: ', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('${widgetItem['category']}')
            ],
          ),
          Row(
            children: [
              const Text('Type: ', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('${widgetItem['type']}')
            ],
          ),
          ElevatedButton(
              onPressed: () {
                Share.share('Food name: ${widgetItem['name']}; Category: ${widgetItem['category']}; Type: ${widgetItem['type']}');
              },
              child: const Text('Share'))
        ];
        break;
      case 'menu':
        children = [
          Row(
            children: [
              const Text('User name: ', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('${widgetItem['user_name']}'),
            ],
          ),
          Row(
            children: [
              const Text('Breakfast Option 1: ', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('${widgetItem['breakfast_option1']}'),
            ],
          ),
          Row(
            children: [
              const Text('Breakfast Option 2: ', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('${widgetItem['breakfast_option2']}'),
            ],
          ),
          Row(
            children: [
              const Text('Breakfast Option 3: ', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('${widgetItem['breakfast_option3']}'),
            ],
          ),
          Row(
            children: [
              const Text('Lunch Option 1: ', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('${widgetItem['lunch_option1']}'),
            ],
          ),
          Row(
            children: [
              const Text('Lunch Option 2: ', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('${widgetItem['lunch_option2']}'),
            ],
          ),
          Row(
            children: [
              const Text('Lunch Option 3: ', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('${widgetItem['lunch_option3']}'),
            ],
          ),
          Row(
            children: [
              const Text('Lunch Option 4: ', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('${widgetItem['lunch_option4']}'),
            ],
          ),
          Row(
            children: [
              const Text('Lunch Option 5: ', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('${widgetItem['lunch_option5']}'),
            ],
          ),
          Row(
            children: [
              const Text('Dinner option 1: ', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('${widgetItem['dinner_option1']}'),
            ],
          ),
          Row(
            children: [
              const Text('Dinner option 2: ', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('${widgetItem['dinner_option2']}'),
            ],
          ),
          Row(
            children: [
              const Text('Dinner option 3: ', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('${widgetItem['dinner_option3']}'),
            ],
          ),
          Row(
            children: [
              const Text('Dinner option 4: ', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('${widgetItem['dinner_option4']}'),
            ],
          ),
          ElevatedButton(
              onPressed: () {
                Share.share('Breakfast options: ${widgetItem['breakfast_option1']}, ${widgetItem['breakfast_option2']}, ${widgetItem['breakfast_option3']}\n'
                'Lunch options: ${widgetItem['lunch_option1']}, ${widgetItem['lunch_option2']}, ${widgetItem['lunch_option3']}, ${widgetItem['lunch_option4']}, ${widgetItem['lunch_option5']}\n'
                'Dinner options: ${widgetItem['dinner_option1']}, ${widgetItem['dinner_option2']}, ${widgetItem['dinner_option3']}, ${widgetItem['dinner_option4']}');
              },
              child: const Text('Share'))
        ];
        break;
      default:
        children = [const Text('Default Content')];
    }

    return Column(
      children: children,
    );
  }
}
