import 'package:flutter/material.dart';
import 'package:urclip_app/models/video_model.dart';
import 'package:urclip_app/local_storage.dart';

class PaymentSimulationPage extends StatelessWidget {
  final VideoModel video;

  const PaymentSimulationPage({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payment')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              video.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text('Location: ${video.court}'),
            const SizedBox(height: 6),
            const Text('Duration: 1m 24s'),
            const SizedBox(height: 6),
            const Text(
              'Price: Rp 25.000',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),

            // Dummy payment methods
            const Text('Select Payment Method',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),

            _paymentOption('GoPay'),
            _paymentOption('OVO'),
            _paymentOption('Dana'),
            _paymentOption('Credit Card'),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  await LocalStorage.purchaseVideo(video);
                  Navigator.pop(context, true); // return success
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Pay & Confirm'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _paymentOption(String name) {
    return ListTile(
      leading: const Icon(Icons.payment),
      title: Text(name),
      trailing: const Icon(Icons.check_circle_outline),
    );
  }
}
