import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:waddecar_cleaning_log/classes/LogItem.dart';
import 'package:waddecar_cleaning_log/services/firebase.dart';

class newLogForm extends StatefulWidget {
  newLogForm({super.key, required this.onSubmit});

  final VoidCallback onSubmit;

  @override
  _newLogFormState createState() => _newLogFormState();
}

class _newLogFormState extends State<newLogForm> {
  final _formKey = GlobalKey<FormState>();
  String? _title;
  String? _description;
  String? _location;
  int? _priority;
  DateTime? _dueBy;
  DateTime _availableFrom = DateTime.now();
  String _jobType = "Maintenance";

  final List<String> _jobTypes = ["Maintenance", "Cleaning"];
  final List<String> _locations = ["Offices", "The Barn", "Parlick Base", "Fairsnape", "Duncans Diner", "Chestnuts"];
  final List<int> _priorities = [1, 2, 3, 4, 5];

  bool get _isFormValid {
    return _title?.isNotEmpty == true &&
        _location != null &&
        _priority != null &&
        _dueBy != null;
  }

  void _pickDueDate() async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _dueBy ?? now,
      firstDate: now,
      lastDate: DateTime(now.year + 5),
    );

    if (pickedDate != null) {
      setState(() {
        _dueBy = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          12
        );
      });
    }
  }

  void _pickAvailableFromDate() async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _availableFrom,
      firstDate: now,
      lastDate: DateTime(now.year + 5),
    );

    if (pickedDate != null) {
      setState(() {
        _availableFrom = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          12
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    
    List<Widget> jobTypeSelectionButtons = [];
    for (String jobType in _jobTypes) {
      if (jobType == _jobType) {
        jobTypeSelectionButtons.add(
          FilledButton(
            child: Text(jobType),
            onPressed: () {
              setState(() {
                _jobType = jobType;
              });
            },
          )
        );
      } else {
        jobTypeSelectionButtons.add(
          OutlinedButton(
            child: Text(jobType),
            onPressed: () {
              setState(() {
                _jobType = jobType;
              });
            },
          )
        );
      }
    }


    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        onChanged: () => setState(() {}), // Re-check form validity
        child: ListView(
          children: [

            // Job Type Selection
            Row(
              spacing: 16,
              mainAxisAlignment: MainAxisAlignment.center,
              children: jobTypeSelectionButtons,
            ),

            // Item Title
            TextFormField(
              decoration: InputDecoration(labelText: 'Title'),
              onChanged: (value) => _title = value,
              validator: (value) =>
                  value == null || value.isEmpty ? 'Required' : null,
            ),

            // Item Description
            TextFormField(
              decoration: InputDecoration(labelText: 'Description'),
              onChanged: (value) => _description = value,
              maxLengthEnforcement: MaxLengthEnforcement.none,
              maxLines: null,
            ),

            // Item Location Dropdown
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Location'),
              items: _locations
                  .map((loc) => DropdownMenuItem(
                        child: Text(loc),
                        value: loc,
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() => _location = value);
              },
              validator: (value) =>
                  value == null ? 'Please choose a location' : null,
            ),

            // Item Priority Dropdown
            DropdownButtonFormField<int>(
              decoration: InputDecoration(labelText: 'Priority'),
              items: _priorities
                  .map((prio) => DropdownMenuItem(
                        child: Text(prio.toString()),
                        value: prio,
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() => _priority = value);
              },
              validator: (value) =>
                  value == null ? 'Please choose a priority' : null,
            ),

            // Available From Date Picker
            SizedBox(height: 16),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text('Available From: ${_availableFrom!.toLocal().toString().substring(0, 10)}'),
              trailing: Icon(Icons.calendar_today),
              onTap: _pickAvailableFromDate,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 4),
              child: Text("Pick a date this job will be available from. By default, the job will be available immediately.", style: Theme.of(context).textTheme.labelSmall),
            ),

            // Due Date Picker
            SizedBox(height: 16),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                _dueBy == null
                    ? 'Pick a due date'
                    : 'Due By: ${_dueBy!.toLocal().toString().substring(0, 10)}',
              ),
              trailing: Icon(Icons.calendar_today),
              onTap: _pickDueDate,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 4),
              child: Text("Pick a date this job needs to be completed by.", style: Theme.of(context).textTheme.labelSmall),
            ),
            if (_dueBy == null)
              Padding(
                padding: const EdgeInsets.only(left: 8, top: 4),
                child: Text('Due date is required',
                    style: TextStyle(color: Colors.red[700], fontSize: 12)),
              ),

            // Submit Button
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: _isFormValid
                  ? () {
                      if (_formKey.currentState!.validate()) {
                        
                        saveLogItem(LogItem(priority: _priority!, title: _title!, description: _description ?? "", location: _location!, jobType: _jobType, dueBy: _dueBy, completed: 0));

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Form submitted!')),
                        );

                        widget.onSubmit();
                      }
                    }
                  : null,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
