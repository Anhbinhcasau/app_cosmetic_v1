// import 'package:app_cosmetic/screen/admin/categories/category_view_model.dart';
// import 'package:app_cosmetic/screen/admin/products/admin_product.dart';
// import 'package:app_cosmetic/screen/user/Product/product_user.dart';
// import 'package:app_cosmetic/widgets/navbar_user.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class CategoriesScreen extends StatefulWidget {
//   @override
//   _CategoriesScreenState createState() => _CategoriesScreenState();
// }

// class _CategoriesScreenState extends State<CategoriesScreen> {
//   // List of categories and icons
  

//   @override
//   Widget build(BuildContext context) {
//       final cateListViewModel = Provider.of<CategoryListViewModel>(context);
//     cateListViewModel.getCategoriesList();

//     return Scaffold(
//       appBar: AppBar(),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Text(
//               'You can choose more than one',
//               style: TextStyle(color: Colors.grey),
//             ),
//             const SizedBox(height: 16),
//             Expanded(
//               child: GridView.builder(
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   childAspectRatio: 3,
//                   crossAxisSpacing: 16,
//                   mainAxisSpacing: 16,
//                 ),
//                 itemCount: categories.length,
//                 itemBuilder: (context, index) {
//                   return GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         selected[index] = !selected[index];
//                       });
//                     },
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: selected[index]
//                             ? Colors.green.shade200
//                             : Colors.white,
//                         borderRadius: BorderRadius.circular(24),
//                         border: Border.all(
//                           color: selected[index]
//                               ? Colors.green
//                               : Colors.grey.shade300,
//                         ),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(icons[index],
//                               color:
//                                   selected[index] ? Colors.green : Colors.grey),
//                           SizedBox(width: 8),
//                           Text(
//                             categories[index],
//                             style: TextStyle(
//                                 color: selected[index]
//                                     ? Colors.green
//                                     : Colors.grey),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => ProductList_User()),
//                 );
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.green.shade400,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(24),
//                 ),
//                 minimumSize: Size(double.infinity, 48),
//               ),
//               //ProductList
//               child: Text('Continue'),
//             ),
//             TextButton(
//               onPressed: () {
//                 // Handle the skip button press
//               },
//               child: Text('Skip for now'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
