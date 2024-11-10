import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

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
          Text('${widgetItem['birth']}'),
          ElevatedButton(
              onPressed: () {
                Share.share('${widgetItem['name']}');
              },
              child: const Text('teste'))
        ];
        break;
      case 'food':
        children = [
          Text('${widgetItem['name']}'),
          Text('${widgetItem['birth']}'),
          ElevatedButton(
              onPressed: () {
                Share.share('${widgetItem['name']}');
              },
              child: const Text('teste'))
        ];
        break;
      case 'menu':
        children = [
          Text('${widgetItem['name']}'),
          Text('${widgetItem['birth']}'),
          ElevatedButton(
              onPressed: () {
                Share.share('${widgetItem['name']}');
              },
              child: const Text('teste'))
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
