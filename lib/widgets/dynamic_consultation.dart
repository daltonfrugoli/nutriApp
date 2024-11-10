import 'package:flutter/material.dart';

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
        children = [
          Text('${widgetItem['name']}'),
          Text('${widgetItem['birth']}')
        ];
        break;
      case 'food':
        children = [
          Text('${widgetItem['name']}'),
          Text('${widgetItem['birth']}')
        ];
        break;
      case 'menu':
        children = [
          Text('${widgetItem['name']}'),
          Text('${widgetItem['birth']}')
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
