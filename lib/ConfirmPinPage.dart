import 'dart:async';

import 'package:flutter/material.dart';
import 'package:urclip_app/RecipePage.dart';

class Confirmpinpage extends StatefulWidget {
  final VoidCallback onPaymentSuccess;
  final String title;
  final String amount;
  final String phoneNumber;
  final String paymentMethod; // Menerima 'GOPAY', 'OVO', dll

  const Confirmpinpage({
    super.key,
    required this.onPaymentSuccess,
    required this.title,
    required this.amount,
    required this.phoneNumber,
    required this.paymentMethod,
  });

  @override
  State<Confirmpinpage> createState() => _ConfirmpinpageState();
}

class _ConfirmpinpageState extends State<Confirmpinpage> {
  int _start = 60;
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
    _timer = Timer.periodic(oneSec, (Timer timer) {
      if (_start == 0) {
        setState(() => timer.cancel());
        _handleSuccess();
      } else {
        setState(() => _start--);
      }
    });
  }

  void _handleSuccess() {
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

  Widget _getLogoWidget() {
    String imagePath;

    switch (widget.paymentMethod) {
      case 'GOPAY':
        imagePath = 'images/gopay.png';
        break;
      case 'OVO':
        imagePath = 'images/ovo.png';
        break;
      case 'DANA':
        imagePath = 'images/dana.png';
        break;
      default:
        return const Icon(Icons.account_balance_wallet, size: 40);
    }

    return Image.asset(
      imagePath,
      height: 40,
      errorBuilder: (context, error, stackTrace) {
        return Text(widget.paymentMethod,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold));
      },
    );
  }

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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 40),

              // TAMPILKAN LOGO DINAMIS DI SINI
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _getLogoWidget(),
                ],
              ),

              const SizedBox(height: 30),
              const Text("Masukan 5 digit pin kamu",
                  style: TextStyle(fontSize: 16)),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black54),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  );
                }),
              ),

              const SizedBox(height: 30),
              Text(
                "Time remaining: $timerText",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),

              const Spacer(),

              TextButton(
                onPressed: _handleSuccess,
                child: const Text("Simulate Correct PIN",
                    style: TextStyle(color: Colors.grey)),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
