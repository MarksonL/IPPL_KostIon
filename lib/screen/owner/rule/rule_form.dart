import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:kostlon/services/rule_services.dart';
import 'package:kostlon/utils/color_theme.dart';
import 'package:loader_overlay/loader_overlay.dart';

class OwnerRuleFormPage extends StatefulWidget {
  const OwnerRuleFormPage({super.key});

  @override
  State<OwnerRuleFormPage> createState() => _OwnerRuleFormPageState();
}

class _OwnerRuleFormPageState extends State<OwnerRuleFormPage> {
  final RulesServices rulesServices = RulesServices();
  final TextEditingController _peraturan = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Form Peraturan')),
      body: LoaderOverlay(
        useDefaultLoading: false,
        overlayColor: Colors.black12,
        overlayWidget: const Center(
          child: SpinKitCircle(
            color: Colors.black,
            size: 50.0,
          ),
        ),
        child: Container(
          height: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextInput(label: "Peraturan", val: _peraturan),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50), // NEW
                  ),
                  onPressed: () async {
                    context.loaderOverlay.show();
                    try {
                      rulesServices.addData({
                        "rule": _peraturan.text,
                        "created": Timestamp.now()
                      });
                      context.loaderOverlay.hide();
                      Navigator.pop(context);
                    } catch (e) {
                      context.loaderOverlay.hide();
                    }
                  },
                  child: Text('Simpan')),
            ],
          ),
        ),
      ),
    );
  }
}

class TextInput extends StatelessWidget {
  const TextInput({
    super.key,
    required this.label,
    required TextEditingController val,
  }) : _val = val;

  final String label;
  final TextEditingController _val;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _val,
      decoration: InputDecoration(
        labelText: "${label}",
        hintText: "Input ${label}",
        filled: true,
        fillColor: Colors.white,
        labelStyle: const TextStyle(color: AppColor.secondary),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: AppColor.light),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColor.primary),
        ),
      ),
    );
  }
}
