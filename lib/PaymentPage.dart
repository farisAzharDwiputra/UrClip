import 'package:flutter/material.dart';
import 'package:urclip_app/ConfirmPaymentPage.dart';
import 'package:urclip_app/ConfirmPhonePage.dart';
import 'package:urclip_app/models/video_model.dart';
import 'package:urclip_app/home.dart';

class PaymentScreen extends StatefulWidget {
  final String videoId;
  final String title;
  final String videoUrl;
  final String? thumbnailUrl;
  final VoidCallback onPaymentSuccess;
  final VideoModel video;

  const PaymentScreen({
    super.key,
    required this.videoId,
    required this.title,
    required this.videoUrl,
    this.thumbnailUrl,
    required this.onPaymentSuccess,
    required this.video,
  });
  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String _selectedPayment = 'QRIS';

  final TextEditingController _referralController =
      TextEditingController(text: "123456e123123");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Row(
                  children: [
                    Icon(Icons.arrow_back_ios, size: 18, color: Colors.black87),
                    Text(
                      "Back",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Suggested for you",
                      style: TextStyle(
                        color: Color(0xFF6B5E96),
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _buildRadioItem("QRIS", "assets/qris.png"),
                    _buildRadioItem("DANA", "assets/dana.png"),
                    _buildRadioItem("OVO", "assets/ovo.png"),
                    _buildRadioItem("GOPAY", "assets/gopay.png"),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                "More payment option",
                style: TextStyle(
                  color: Color(0xFF6B5E96),
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 12),
              _buildOptionCard(
                title: "Crypto",
                icon: Icons.currency_bitcoin,
                iconColor: Colors.orange,
              ),
              const SizedBox(height: 12),
              _buildOptionCard(
                title: "Credit/ Debit Card",
                icon: Icons.credit_card,
                iconColor: Colors.indigo,
              ),
              const SizedBox(height: 24),
              const Text(
                "Enter Referral Code",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Color(0xFF2D3E50),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _referralController,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF2D3E50)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        const BorderSide(color: Color(0xFF2D3E50), width: 2),
                  ),
                  suffixIcon:
                      const Icon(Icons.check_circle, color: Colors.green),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    if (_selectedPayment == 'GOPAY' ||
                        _selectedPayment == 'OVO' ||
                        _selectedPayment == 'DANA') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Confirmphonepage(
                            title: widget.title,
                            amount: "IDR 25.000",
                            onPaymentSuccess: widget.onPaymentSuccess,
                            paymentMethod: _selectedPayment,
                          ),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Confirmpaymentpage(
                            title: widget.title,
                            amount: "IDR 25.000",
                            onPaymentSuccess: widget.onPaymentSuccess,
                          ),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF555B3E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Continue",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward, color: Colors.white),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Image.asset('images/logourclip.png', height: 60),
          ],
        ),
        const SizedBox(height: 8),
        // Judul Halaman
      ],
    );
  }

  Widget _buildRadioItem(String value, String assetPath) {
    bool isSelected = _selectedPayment == value;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPayment = value;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        color: Colors.transparent,
        child: Row(
          children: [
            Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? const Color(0xFF6B5E96) : Colors.grey,
                  width: 1.5,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        height: 10,
                        width: 10,
                        decoration: const BoxDecoration(
                          color: Color(0xFF6B5E96),
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                color: isSelected ? const Color(0xFF6B5E96) : Colors.grey[600],
                fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
              ),
            ),
            const Spacer(),
            SizedBox(
              height: 24,
              child: _getPlaceholderLogo(value),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionCard(
      {required String title,
      required IconData icon,
      required Color iconColor}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: 16),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF6B5E96),
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _getPlaceholderLogo(String type) {
    const double logoHeight = 25.0;

    switch (type) {
      case 'QRIS':
        return const Text("QRIS",
            style: TextStyle(
                fontWeight: FontWeight.w900, fontStyle: FontStyle.italic));
      case 'DANA':
        return Image.asset(
          'images/dana.png',
          height: logoHeight,
          fit: BoxFit.contain,
        );
      case 'OVO':
        return Image.asset(
          'images/ovo.png',
          height: logoHeight,
          fit: BoxFit.contain,
        );
      case 'GOPAY':
        return Image.asset(
          'images/gopay.png',
          height: logoHeight,
          fit: BoxFit.contain,
        );
      default:
        return const SizedBox();
    }
  }
}
