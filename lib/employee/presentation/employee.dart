import 'package:flutter/material.dart';

class EmployeePanel extends StatelessWidget {
  const EmployeePanel ({super.key});

  // Define the primary color as a MaterialColor swatch
  final MaterialColor primaryGreen = Colors.green; 

  // Static/Placeholder data mimicking API response for Employee and Finance
  final Map<String, dynamic> staticUser = const {
    "name": "Alex Johnson",
    "email": "alex.j@saloon.com",
    "role": "Master Barber",
    "phone_number": "+1 (555) 987-6543",
    "shift_time": "09:00 AM - 05:00 PM",
    "commission_rate": "15%",
    "current_balance": 1545.50,
    "shared_balance": 500.00,
  };
  
  // Static Placeholder for Shared History (Future API endpoint)
  final List<Map<String, dynamic>> sharedHistory = const [
    {"employee": "Jane Doe", "amount": 100.00, "date": "2024-10-25"},
    {"employee": "Mike Ross", "amount": 50.00, "date": "2024-10-23"},
    {"employee": "Donna Paulsen", "amount": 75.00, "date": "2024-10-20"},
  ];

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // --- 1. Profile Header Section ---
            _buildProfileHeader(),
            
            // --- 2. Financial Overview Section ---
            const Text(
              'Financial Overview',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            const SizedBox(height: 10),
            _buildFinancialCard(context), 
            
            const SizedBox(height: 25),

            // --- 3. Contact & Work Details Section ---
            const Text(
              'Details & Schedule',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            const SizedBox(height: 8),
            _buildDetailTile(Icons.email_outlined, 'Email', staticUser['email']!),
            _buildDetailTile(Icons.phone_outlined, 'Phone', staticUser['phone_number']!),
            _buildDetailTile(Icons.access_time, 'Shift Time', staticUser['shift_time']!),
            _buildDetailTile(Icons.attach_money, 'Commission Rate', staticUser['commission_rate']!),
            _buildSpecialtyTile(
              'Specialties', 
              const ['Beard Trim', 'Hot Shave', 'Fade Cut'] 
            ),

            const SizedBox(height: 40),

            // --- 4. Action Button (Logout) ---
            _buildLogoutButton(context),
          ],
        ),
      ),
    );
  }

  // --- Widget Builders ---

  Widget _buildDetailTile(IconData icon, String title, String value) {
    return ListTile(
      leading: Icon(icon, color: primaryGreen, size: 28),
      title: Text(title, style: TextStyle(fontSize: 14, color: Colors.grey.shade600)),
      subtitle: Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
    );
  }

  Widget _buildSpecialtyTile(String title, List<String> specialties) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: const Icon(Icons.star_border, color: Colors.green, size: 28),
          title: Text(title, style: TextStyle(fontSize: 14, color: Colors.grey.shade600)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 0),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, bottom: 8),
          child: Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: specialties.map((s) => Chip(
              label: Text(s),
              backgroundColor: primaryGreen.shade50,
              labelStyle: TextStyle(color: primaryGreen.shade700),
            )).toList(),
          ),
        ),
      ],
    );
  }
  
  Widget _buildProfileHeader() {
    return Center(
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: primaryGreen.shade100,
            child: Text(
              staticUser['name']![0],
              style: TextStyle(fontSize: 40, color: primaryGreen.shade800),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            staticUser['name']!,
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          Text(
            staticUser['role']!,
            style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
          ),
          const Divider(height: 30),
        ],
      ),
    );
  }

  Widget _buildFinancialCard(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: primaryGreen.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Current Balance (Standard Row)
            _buildBalanceRow(
              'Current Balance', 
              staticUser['current_balance'], 
              primaryGreen.shade800, 
              null,
              onTap: null,
            ),
            
            const Divider(height: 20),

            // Shared Balance / Tips (Tappable Row with Share Button)
            _buildBalanceRow(
              'Shared Balance', 
              staticUser['shared_balance'], 
              Colors.orange.shade700,
              // The action button for sharing
              TextButton.icon(
                icon: Icon(Icons.share, size: 20, color: primaryGreen),
                label: Text(
                  'SHARE',
                  style: TextStyle(
                    color: primaryGreen,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () => _showShareBalanceDialog(context),
              ),
              // Tappable function for the row itself
              onTap: () => _showSharedHistoryDialog(context),
            ),
            
            const SizedBox(height: 20),

            // Withdraw Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                icon: const Icon(Icons.account_balance_wallet_outlined, size: 20),
                label: const Text('Request Withdrawal'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: primaryGreen.shade800,
                  side: BorderSide(color: primaryGreen.shade400),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Withdrawal request ready for API endpoint /transaction/withdraw/'),
                      backgroundColor: primaryGreen,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper for Balance Rows, now includes onTap and is a GestureDetector
  Widget _buildBalanceRow(
    String title, 
    double amount, 
    Color color, 
    Widget? trailingWidget,
    {VoidCallback? onTap} // New optional callback
  ) {
    return GestureDetector(
      onTap: onTap, // Apply tap to the whole row
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
                ),
                Text(
                  '\$${amount.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: color),
                ),
              ],
            ),
            if (trailingWidget != null) trailingWidget,
            // Add a small arrow if the row is tappable and has no trailing widget
            if (onTap != null && trailingWidget == null) Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }
  
  // Dialog 1: Share Balance
  void _showShareBalanceDialog(BuildContext context) {
    final TextEditingController employeeNameController = TextEditingController();
    final TextEditingController amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Share Shared Balance', style: TextStyle(color: primaryGreen.shade700)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Text Field 1: Search Employee Name
              TextField(
                controller: employeeNameController,
                decoration: InputDecoration(
                  labelText: 'Employee Name (Search)',
                  labelStyle: TextStyle(
                    color: Colors.black45,
                  ),
                  hintText: 'e.g., Jane Doe',
                  hintStyle: TextStyle(
                    color: Colors.black45,
                  ),
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 15),
              // Text Field 2: Amount
              TextField(
                controller: amountController,
                decoration: InputDecoration(
                  labelText: 'Amount to Send',
                  labelStyle: TextStyle(
                    color: Colors.black45,
                  ),
                  hintText: '\$50.00',
                  hintStyle: TextStyle(
                    color: Colors.black45,
                  ),
                  prefixIcon: const Icon(Icons.attach_money),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: <Widget>[
            // Cancel Button
            TextButton(
              child: Text('Cancel', style: TextStyle(color: Colors.grey.shade600)),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            // Send Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: primaryGreen.shade700, foregroundColor: Colors.white),
              child: const Text('Send'),
              onPressed: () {
                final name = employeeNameController.text;
                final amount = amountController.text;

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Static Send: \$$amount to $name. Ready for API call.'),
                    backgroundColor: primaryGreen,
                  ),
                );
                Navigator.of(dialogContext).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  // New Dialog 2: Shared History
  void _showSharedHistoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Shared Balance History', style: TextStyle(color: primaryGreen.shade700)),
          content: SizedBox(
            width: double.maxFinite,
            // 💡 FUTURE-PROOFING: The List needs to be fetched dynamically
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: sharedHistory.length,
              itemBuilder: (context, index) {
                final history = sharedHistory[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: primaryGreen.shade100,
                    child: Icon(Icons.call_made, color: primaryGreen),
                  ),
                  title: Text(history['employee']!),
                  subtitle: Text('Date: ${history['date']}'),
                  trailing: Text(
                    '-\$${history['amount'].toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Colors.red.shade700,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close', style: TextStyle(color: primaryGreen.shade700)),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: const Icon(Icons.logout),
        label: const Text('Logout', style: TextStyle(fontSize: 18)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red.shade600,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Static Logout triggered. Ready for API call.')),
          );
        },
      ),
    );
  }
}