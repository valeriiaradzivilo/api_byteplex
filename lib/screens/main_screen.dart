import 'package:api_byteplex/data/message_class.dart';
import 'package:api_byteplex/repository/remote_repository.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

enum EditingTypes { name, email, message }

class _MainScreenState extends State<MainScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isButtonIgnored = true;
  bool _isLoading = false;
  RemoteRepository repo = RemoteRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact us'),
        centerTitle: true,
        leading: const Icon(Icons.arrow_back),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Form(
                key: _formKey,
                onChanged: () {
                  if (_formKey.currentState != null) {
                    _isButtonIgnored = !_formKey.currentState!.validate();
                  }
                  setState(() {});
                },
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _customTextEditingField(_nameController, EditingTypes.name),
                      _customTextEditingField(_emailController, EditingTypes.email),
                      _customTextEditingField(_messageController, EditingTypes.message),
                      IgnorePointer(
                        ignoring: _isButtonIgnored,
                        child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  _isLoading = true;
                                });
                                final bool result = await repo.postToRepo(MessageClass(
                                    name: _nameController.text,
                                    email: _emailController.text,
                                    message: _messageController.text));
                                if (result) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Sent this message successfully')),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Error')),
                                  );
                                }
                                setState(() {
                                  _isLoading = false;
                                });
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.purple, padding: const EdgeInsets.all(20)),
                            child: Text(
                              _isLoading ? 'Please wait ...' : 'Send',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
                            )),
                      )
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _customTextEditingField(TextEditingController controller, EditingTypes type) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.orange.withOpacity(0.1)),
                    color: Colors.orange.withOpacity(0.1)),
                child: Icon(
                  Icons.lock,
                  color: Colors.orange[300]!,
                )),
          ),
          const SizedBox(
            width: 50,
          ),
          Flexible(
            flex: 2,
            child: IntrinsicHeight(
              child: TextFormField(
                controller: controller,
                expands: true,
                maxLines: null,
                decoration: InputDecoration(
                    label: Text(
                  type.name,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                )),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  } else if (type == EditingTypes.email && (!value.contains('@') || !value.contains('.'))) {
                    return 'Invalid email';
                  }
                  return null;
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
