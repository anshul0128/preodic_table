import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'api.dart';
import 'model.dart';



class PeriodicTablePage extends StatefulWidget {
  @override
  _PeriodicTablePageState createState() => _PeriodicTablePageState();
}

class _PeriodicTablePageState extends State<PeriodicTablePage> {
  late Future<List<ChemicalElement>> futureElements;

  @override
  void initState() {
    super.initState();
    futureElements = ChemicalElementService.fetchElements();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Periodic Table'),
      ),
      body: FutureBuilder<List<ChemicalElement>>(
        future: futureElements,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SpinKitFadingCircle(
                color: Colors.blue,
                size: 50.0,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            return PeriodicTable(elements: snapshot.data!);
          } else {
            return Center(
              child: Text('No data found'),
            );
          }
        },
      ),
    );
  }
}

class PeriodicTable extends StatelessWidget {
  final List<ChemicalElement> elements;

  PeriodicTable({required this.elements});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: (constraints.maxWidth > constraints.maxHeight) ? 10 : 4,
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
            ),
            itemCount: elements.length,
            itemBuilder: (context, index) {
              return ElementTile(element: elements[index]);
            },
          );
        },
      ),
    );
  }
}

class ElementTile extends StatelessWidget {
  final ChemicalElement element;

  ElementTile({required this.element});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue[100],
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(element.name ?? 'Unknown'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Symbol: ${element.symbol ?? 'N/A'}'),
                    Text('Atomic Number: ${element.number?.toString() ?? 'N/A'}'),
                    Text('Category: ${element.category ?? 'N/A'}'),
                    Text('Group: ${element.group ?? 'N/A'}'),
                    Text('Period: ${element.period ?? 'N/A'}'),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Close'),
                ),
              ],
            ),
          );
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                element.symbol ?? 'N/A',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                element.number?.toString() ?? 'N/A',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
