// import 'package:flutter/material.dart';

// class ProductCard extends StatelessWidget {
//   final String productName;
//   final int qty;
//   final String notes;
//   //// Pointer to Update Function
//   final Function onUpdate;
//   //// Pointer to Delete Function
//   final Function onDelete;

//   ProductCard(this.productName, this.qty, this.notes,
//       {this.onUpdate, this.onDelete});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//       padding: const EdgeInsets.all(5),
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(8),
//           border: Border.all(color: Colors.blue.shade900)),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(
//                 width: MediaQuery.of(context).size.width * 0.5,
//                 child: Text(
//                   productName,
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontWeight: FontWeight.w600,
//                       fontSize: 16),
//                 ),
//               ),
//               Text(
//                 "$qty",
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.w600,
//                     fontSize: 16),
//               ),
//               Text(
//                 notes,
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.w600,
//                     fontSize: 16),
//               )
//             ],
//           ),
//           Row(
//             children: [
//               SizedBox(
//                 height: 40,
//                 width: 60,
//                 child: RaisedButton(
//                     shape: CircleBorder(),
//                     color: Colors.green[900],
//                     child: Center(
//                         child: Icon(
//                       Icons.arrow_upward,
//                       color: Colors.white,
//                     )),
//                     onPressed: () {
//                       // if (onUpdate != null) onUpdate!();
//                       onUpdate();
//                     }),
//               ),
//               SizedBox(
//                 height: 40,
//                 width: 60,
//                 child: RaisedButton(
//                     shape: CircleBorder(),
//                     color: Colors.red[900],
//                     child: Center(
//                         child: Icon(
//                       Icons.delete,
//                       color: Colors.white,
//                     )),
//                     onPressed: () {
//                       // if (onDelete != null) onDelete!();
//                       onDelete();
//                     }),
//               )
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
