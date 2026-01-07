import 'dart:async';
import 'package:flutter/material.dart';
import 'package:urclip_app/RecipePage.dart';

class Confirmpaymentpage extends StatefulWidget {
  final VoidCallback onPaymentSuccess;
  final String title;
  final String amount;

  const Confirmpaymentpage({
    super.key,
    required this.onPaymentSuccess,
    required this.title,
    required this.amount,
  });

  @override
  State<Confirmpaymentpage> createState() => ConfirmpaymentpageState();
}

class ConfirmpaymentpageState extends State<Confirmpaymentpage> {
  int _start = 600;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
          _handlePaymentSuccess();
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  void _handlePaymentSuccess() {
    widget.onPaymentSuccess();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => ReceiptPage(amount: widget.amount),
      ),
      (route) => false,
    );
  }

  String get timerText {
    int minutes = _start ~/ 60;
    int seconds = _start % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildCircleButton(
                    icon: Icons.close,
                    onTap: () => Navigator.pop(context),
                  ),
                  _buildCircleButton(
                    icon: Icons.share_outlined,
                    onTap: () {},
                  ),
                ],
              ),
              const Spacer(),
              Column(
                children: [
                  const Text(
                    "QRIS Payment",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 250,
                          width: 250,
                          color: Colors.white,
                          child: Center(
                            child: Image.asset(
                              'images/qris.png',
                              width: 600,
                              height: 600,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Scan QR code to pay",
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Text(
                "Time remaining: $timerText",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: _handlePaymentSuccess,
                child: const Text("Simulate Scan Success (Dev Only)"),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCircleButton(
      {required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Icon(icon, size: 20, color: Colors.black87),
      ),
    );
  }
}
