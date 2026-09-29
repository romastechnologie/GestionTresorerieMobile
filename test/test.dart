// // import 'package:flutter/material.dart';

// // class DashboardPage extends StatefulWidget {
// //   const DashboardPage({super.key});
 
// //   @override
// //   State<DashboardPage> createState() => _DashboardPageState();
// // }
 
// // class _DashboardPageState extends State<DashboardPage> {
// //   List<TransactionModel> transactions = [
// //     TransactionModel(title: 'Paypal Deposit', date: '16 Oct 2022', amount: 55.00, type: 'deposit'),
// //     TransactionModel(title: 'Grocery Store', date: '18 Oct 2022', amount: -92.53, type: 'expense'),
// //     TransactionModel(title: 'ATM Withdrawal', date: '19 Oct 2022', amount: -100.00, type: 'expense'),
// //   ];
 
// //   List<double> chartData = [25.0, 60.0, 45.0, 75.0, 55.0, 40.0, 30.0];
 
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: const Text("Cards"), centerTitle: true),
// //       body: SingleChildScrollView(
// //         child: Column(
// //           children: [
// //             ...transactions.map((t) => TransactionCard(transaction: t)).toList(),
// //             const SizedBox(height: 16),
// //             const Padding(
// //               padding: EdgeInsets.symmetric(horizontal: 16),
// //               child: Row(
// //                 children: [
// //                   Icon(Icons.bar_chart),
// //                   SizedBox(width: 8),
// //                   Text("Spending Activities", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
// //                 ],
// //               ),
// //             ),
// //             SpendingChart(data: chartData),
// //           ],
// //         ),
// //       ),
// //       bottomNavigationBar: BottomNavigationBar(
// //         selectedItemColor: Colors.teal,
// //         unselectedItemColor: Colors.grey,
// //         items: const [
// //           BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
// //           BottomNavigationBarItem(icon: Icon(Icons.credit_card), label: "Cards"),
// //           BottomNavigationBarItem(icon: Icon(Icons.pie_chart_outline), label: "Stats"),
// //           BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Account"),
// //         ],
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:fl_chart/fl_chart.dart';

// void main() {
//   runApp(const MyApp());
// }

// /// ---------- Models ----------
// class Transaction {
//   final String title;
//   final String date;
//   final double amount;
//   final String type;

//   Transaction({
//     required this.title,
//     required this.date,
//     required this.amount,
//     required this.type,
//   });
// }

// /// ---------- Controller ----------
// class CardsController extends GetxController {
//   var transactions = <Transaction>[
//     Transaction(title: 'Paypal Deposit', date: '18 Oct. 2022', amount: 5.00, type: 'Transfer'),
//     Transaction(title: 'Grocery Store', date: '16 Oct. 2022', amount: 92.53, type: 'Transfer'),
//     Transaction(title: 'ATM Withdrawal', date: '13 Oct. 2022', amount: 100.00, type: 'Transfer'),
//   ].obs;

//   var weeklySpending = [50.0, 30.0, 70.0, 45.0, 90.0, 60.0, 20.0].obs;
// }

// /// ---------- Widgets ----------
// class TransactionItem extends StatelessWidget {
//   final Transaction transaction;

//   const TransactionItem({super.key, required this.transaction});

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       title: Text(transaction.title),
//       subtitle: Text(transaction.date),
//       trailing: Text(
//         '\$${transaction.amount.toStringAsFixed(2)}',
//         style: TextStyle(
//           color: transaction.type == 'Transfer' ? Colors.red : Colors.green,
//         ),
//       ),
//     );
//   }
// }

// class SpendingChart extends StatelessWidget {
//   final List<double> data;

//   const SpendingChart({super.key, required this.data});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 200,
//       child: BarChart(
//         BarChartData(
//           borderData: FlBorderData(show: false),
//           titlesData: FlTitlesData(
//             bottomTitles: AxisTitles(
//               sideTitles: SideTitles(
//                 showTitles: true,
//                 interval: 1,
//                 getTitlesWidget: (value, meta) {
//                   const days = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
//                   if (value.toInt() >= 0 && value.toInt() < days.length) {
//                     return Text(days[value.toInt()], style: const TextStyle(fontSize: 12));
//                   } else {
//                     return const Text('');
//                   }
//                 },
//               ),
//             ),
//             leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//             rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//             topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//           ),
//           barGroups: data.asMap().entries.map((entry) {
//             int index = entry.key;
//             double value = entry.value;
//             return BarChartGroupData(
//               x: index,
//               barRods: [
//                 BarChartRodData(
//                   toY: value,
//                   color: Colors.teal,
//                   width: 14,
//                   borderRadius: BorderRadius.circular(4),
//                 ),
//               ],
//             );
//           }).toList(),
//         ),
//       ),
//     );
//   }
// }

// /// ---------- Page ----------
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: CardsPage(),
//     );
//   }
// }

// class CardsPage extends StatelessWidget {
//   final controller = Get.put(CardsController());

//   CardsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Cards")),
//       bottomNavigationBar:  BottomNavigationBar(
//         items: [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//           BottomNavigationBarItem(icon: Icon(Icons.credit_card), label: 'Cards'),
//           BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Stats'),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
//         ],
//         currentIndex: 1,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Obx(() => SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text("Recent Transactions", style: Theme.of(context).textTheme.titleLarge),
//               ...controller.transactions.map((t) => TransactionItem(transaction: t)).toList(),
//               const SizedBox(height: 20),
//               Text("Spending Activities", style: Theme.of(context).textTheme.titleLarge),
//               SpendingChart(data: controller.weeklySpending),
//             ],
//           ),
//         )),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
 
// class PayPage extends StatelessWidget {
//   final List<Map<String, String>> quickActions = [
//     {'icon': '🟠', 'label': 'Top Up'},
//     {'icon': '🟣', 'label': 'Send'},
//     {'icon': '🔴', 'label': 'Request'},
//   ];
 
//   final List<Map<String, String>> services = [
//     {'icon': '🌐', 'label': 'Internet'},
//     {'icon': '💰', 'label': 'Gold'},
//     {'icon': '💡', 'label': 'Electricity'},
//     {'icon': '📦', 'label': 'Others'},
//   ];
 
//   final List<String> promos = [
//     'Doorprice Handphone',
//     'Discount Internet',
//   ];
 
//   final List<String> articles = [
//     'Lorem ipsum dolor sit amet',
//     'Consectetur adipiscing elit'
//   ];
 
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildSaldoHeader(),
//               SizedBox(height: 20),
//               _buildQuickActions(),
//               SizedBox(height: 20),
//               _buildServices(),
//               SizedBox(height: 20),
//               _buildPromoSection(),
//               SizedBox(height: 20),
//               _buildArticlesSection(),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         currentIndex: 2,
//         selectedItemColor: Colors.blue,
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//           BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Cashflow'),
//           BottomNavigationBarItem(icon: Icon(Icons.add_circle, size: 40), label: ''),
//           BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Message'),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
//         ],
//       ),
//     );
//   }
 
//   Widget _buildSaldoHeader() {
//     return Container(
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(colors: [Colors.blue, Colors.blueAccent]),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: const [
//               Text('Saldo Balance', style: TextStyle(color: Colors.white, fontSize: 16)),
//               SizedBox(height: 4),
//               Text('\$1,200.00', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
//             ],
//           ),
//           CircleAvatar(
//             backgroundColor: Colors.white,
//             child: Icon(Icons.person, color: Colors.blue),
//           )
//         ],
//       ),
//     );
//   }
 
//   Widget _buildQuickActions() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: quickActions.map((action) => Column(
//         children: [
//           CircleAvatar(radius: 24, backgroundColor: Colors.orange.shade100, child: Text(action['icon']!)),
//           SizedBox(height: 8),
//           Text(action['label']!, style: TextStyle(fontSize: 12))
//         ],
//       )).toList(),
//     );
//   }
 
//   Widget _buildServices() {
//     return GridView.count(
//       crossAxisCount: 4,
//       shrinkWrap: true,
//       physics: NeverScrollableScrollPhysics(),
//       children: services.map((service) => Column(
//         children: [
//           CircleAvatar(radius: 20, backgroundColor: Colors.blue.shade50, child: Text(service['icon']!)),
//           SizedBox(height: 4),
//           Text(service['label']!, style: TextStyle(fontSize: 10))
//         ],
//       )).toList(),
//     );
//   }
 
//   Widget _buildPromoSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('Promo For You', style: TextStyle(fontWeight: FontWeight.bold)),
//         SizedBox(height: 8),
//         SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: Row(
//             children: promos.map((promo) => Container(
//               margin: EdgeInsets.only(right: 12),
//               padding: EdgeInsets.all(16),
//               width: 200,
//               decoration: BoxDecoration(
//                 color: Colors.blue,
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Text(promo, style: TextStyle(color: Colors.white)),
//             )).toList(),
//           ),
//         )
//       ],
//     );
//   }
 
//   Widget _buildArticlesSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('Financial Articles', style: TextStyle(fontWeight: FontWeight.bold)),
//         SizedBox(height: 8),
//         GridView.count(
//           crossAxisCount: 2,
//           shrinkWrap: true,
//           physics: NeverScrollableScrollPhysics(),
//           childAspectRatio: 1.5,
//           children: articles.map((article) => Card(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(Icons.image, size: 40, color: Colors.grey),
//                 SizedBox(height: 8),
//                 Text(article, textAlign: TextAlign.center, style: TextStyle(fontSize: 12))
//               ],
//             ),
//           )).toList(),
//         )
//       ],
//     );
//   }
// }