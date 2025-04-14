import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infoware_assignment/blocs/form/form_bloc.dart';
import 'package:infoware_assignment/blocs/form/form_event.dart';
import 'package:infoware_assignment/blocs/form/form_state.dart';
import 'package:infoware_assignment/screens/form_detail.dart';

class FormScreen extends StatelessWidget {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final countryController = TextEditingController();
  final stateController = TextEditingController();
  final cityController = TextEditingController();

  final List<String> genderOptions = ['Male', 'Female'];

  @override
  Widget build(BuildContext context) {
    String selectedGender = '';

    return Scaffold(
      backgroundColor: Color(0xFFE6F4F3),

      body: BlocProvider(
        create: (context) => FormBloc(),
        child: BlocConsumer<FormBloc, FormBlocState>(
          listener: (context, state) {
            print("Current state: ${state.runtimeType}"); 
            
            if (state is FormSuccess) {
              print("Navigating to details page"); 
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FormDetailsPage(
                    name: state.name,
                    email: state.email,
                    phone: state.phone,
                    gender: state.gender,
                    country: state.country,
                    state: state.state,
                    city: state.city,
                  ),
                ),
              );
            } else if (state is FormFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage)),
              );
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (state is FormSubmitting)
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      SizedBox(height: 10,),
                    _buildTextField(
                      nameController, 
                      'Name',
                   
                    ),
                    _buildTextField(
                      emailController, 
                      'Email',
                      keyboardType: TextInputType.emailAddress,
                    ),
                    _buildTextField(
                      phoneController, 
                      'Phone',
                      keyboardType: TextInputType.phone,
                    ),
                    
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: StatefulBuilder(
                        builder: (context, setState) {
                          return DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                             borderSide: BorderSide(color: Color(0xFF3BA09D)),
                              
                            ),
                            enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF3BA09D)),
        ), ),
 
                            hint: Text('Select Gender'),
                            value: selectedGender.isEmpty ? null : selectedGender,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedGender = newValue!;
                              });
                            },
                            items: genderOptions.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          );
                        }
                      ),
                    ),
                    SizedBox(height: 10,),
                    _buildTextField(
                      cityController, 
                      'City',
                    
                    ),
                    _buildTextField(
                      stateController, 
                      'State',
                    ),
                    _buildTextField(
                      countryController, 
                      'Country',
                    
                    ),
                    SizedBox(height: 20),
                    Container(
  width: double.infinity,
  child: ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFF3BA09D),
      foregroundColor: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        
      ),
    ),
    onPressed: () {
      print("Submit button pressed");
      context.read<FormBloc>().add(
        SubmitFormEvent(
          name: nameController.text,
          email: emailController.text,
          phone: phoneController.text,
          gender: selectedGender,
          country: countryController.text,
          state: stateController.text,
          city: cityController.text,
        ),
      );
    },
    child: Text(
      'Submit',
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
  ),
)
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller, 
    String label, 
    {TextInputType keyboardType = TextInputType.text, 
    String helperText = ''}
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          helperText: helperText,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF3BA09D)), 
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF3BA09D)), 
          ),
          fillColor: Color(0xFFE6F4F3),
          filled: true,
        ),
        keyboardType: keyboardType,
      ),
    );
  }
}