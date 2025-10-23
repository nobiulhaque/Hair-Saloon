import 'package:flutter/material.dart';
import 'package:hair_saloon/admin/presentation/admin_pages/employee/utils/employee_text_field.dart';

class AddEmployees extends StatelessWidget {
  const AddEmployees({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryGreen = Colors.green.shade700;

    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        backgroundColor: primaryGreen,
        title: const Text(
          'Add Employee',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Name
                const AddEmployeeTextField(
                  label: 'Employee Name',
                  hint: 'Enter employee name',
                  icon: Icons.person,
                ),
                const SizedBox(height: 20),

                //phone number
                const AddEmployeeTextField(
                  label: 'Phone Number',
                  hint: 'Enter phone number',
                  icon: Icons.phone,
                  inputType: TextInputType.phone,
                ),
                const SizedBox(height: 20),

                //Email Address
                const AddEmployeeTextField(
                  label: 'Email Address',
                  hint: 'Enter email address',
                  icon: Icons.email,
                  inputType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 40),


                //add + cancel button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //Cancle Button
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          // logic for cancel
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: primaryGreen, width: 1.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 16,
                            color: primaryGreen,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),

                    //Add button
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          // logic for add employee.
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryGreen,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        child: const Text(
                          'Add',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
