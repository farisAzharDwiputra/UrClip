import 'package:flutter/material.dart';
import 'package:urclip_app/ConfirmPinPage.dart';

class Confirmphonepage extends StatefulWidget {
  final VoidCallback onPaymentSuccess;
  final String title;
  final String amount;
  final String paymentMethod; // Parameter baru: 'GOPAY', 'OVO', atau 'DANA'

  const Confirmphonepage({
    super.key,
    required this.onPaymentSuccess,
    required this.title,
    required this.amount,
    required this.paymentMethod,
  });

  @override
  State<Confirmphonepage> createState() => _ConfirmphonepageState();
}

class _ConfirmphonepageState extends State<Confirmphonepage> {
  final TextEditingController _phoneController =
      TextEditingController(text: "0812834141221123");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.shade300)),
            child: const Icon(Icons.close, size: 18, color: Colors.black),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Masukan nomor telepon ${widget.paymentMethod} anda", // Text dinamis
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2)),
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF555B3E),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Confirmpinpage(
                        onPaymentSuccess: widget.onPaymentSuccess,
                        title: widget.title,
                        amount: widget.amount,
                        phoneNumber: _phoneController.text,
                        paymentMethod: widget.paymentMethod,
                      ),
                    ),
                  );
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Continue",
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward, color: Colors.white, size: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
