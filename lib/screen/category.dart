import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CategoriesScreen(),
    );
  }
}

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  // List of categories and icons
  List<String> categories = [
    'Show All',
    'Perfume',
    'Moisturizer',
    'Shampoo',
    'Gift Cards',
    'Toner',
    'Face oils',
    'Foundation',
    'Suncare',
    'Tools'
  ];
  List<IconData> icons = [
    Icons.all_inclusive,
    Icons.local_florist,
    Icons.spa,
    Icons.shower,
    Icons.card_giftcard,
    Icons.opacity,
    Icons.face,
    Icons.format_paint,
    Icons.wb_sunny,
    Icons.build
  ];
  List<bool> selected = List<bool>.filled(10, false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose your favourite category'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'You can choose more than one',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selected[index] = !selected[index];
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: selected[index]
                            ? Colors.green.shade200
                            : Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: selected[index]
                              ? Colors.green
                              : Colors.grey.shade300,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(icons[index],
                              color:
                                  selected[index] ? Colors.green : Colors.grey),
                          SizedBox(width: 8),
                          Text(
                            categories[index],
                            style: TextStyle(
                                color: selected[index]
                                    ? Colors.green
                                    : Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Handle the continue button press
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade400,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                minimumSize: Size(double.infinity, 48),
              ),
              child: Text('Continue'),
            ),
            TextButton(
              onPressed: () {
                // Handle the skip button press
              },
              child: Text('Skip for now'),
            ),
          ],
        ),
      ),
    );
  }
}
