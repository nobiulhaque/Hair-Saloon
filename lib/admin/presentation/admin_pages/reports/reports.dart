
import 'package:flutter/material.dart';
import 'package:hair_saloon/admin/presentation/admin_pages/reports/controller/reportProvider.dart';
import 'package:hair_saloon/core/widgets/employee_repoert_card.dart';
import 'package:provider/provider.dart'; 
class Reports extends StatefulWidget {
  const Reports({super.key});

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  // State variables are now in the ReportProvider, so we remove:
  // final List<String> _timeFrames = ['Today', 'Weekly', 'Monthly'];
  // String? _selectedTimeFrame = 'Today';
  // late Future<List<EmployeeReport>> _reportsFuture;
  // @override initState()
  // filterReports()

  // We only keep the local method definitions or constants if needed.
  final List<String> _timeFrames = ['Today', 'Weekly', 'Monthly'];

  @override
  Widget build(BuildContext context) {
    // Access the provider once at the top of the build method
    final provider = Provider.of<ReportProvider>(context);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // HEADER BAR with Dropdown
                _buildHeaderBar(context, provider),
                const SizedBox(height: 8),
                Text(
                  "Report Data for ${provider.selectedTimeFrame}",
                  style: const TextStyle(fontSize: 16, color: Colors.black54),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: _buildReportList(provider),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to build the list based on provider state
  Widget _buildReportList(ReportProvider provider) {
    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator(color: Colors.green));
    }

    if (provider.errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Error: ${provider.errorMessage}'),
            const SizedBox(height: 10),
            // Button to retry fetching data
            ElevatedButton(
              onPressed: provider.fetchReports,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    final filteredList = provider.filteredReports;

    if (filteredList.isEmpty) {
      return Center(child: Text('No ${provider.selectedTimeFrame.toLowerCase()} reports found.'));
    }

    return ListView.builder(
      itemCount: filteredList.length,
      itemBuilder: (context, index) {
        final report = filteredList[index];
        return EmployeeReportCard(report: report);
      },
    );
  }

  // Header Bar is now updated to use the provider's state and action
  Widget _buildHeaderBar(BuildContext context, ReportProvider provider) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(15),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Reports",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          DropdownButton<String>(
            // Read selected value from provider
            value: provider.selectedTimeFrame, 
            icon: const Icon(Icons.arrow_drop_down_rounded, color: Colors.green),
            iconSize: 28,
            elevation: 2,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            underline: Container(),
            onChanged: (String? newValue) {
              // Call the provider's action to update state
              provider.setSelectedTimeFrame(newValue); 
              // The UI updates automatically because the provider calls notifyListeners()
            },
            items: _timeFrames.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}