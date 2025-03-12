import 'package:flutter/material.dart';
import 'package:hope_hub/core/style/app_text_styles.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Text(
                'Спасибо за твою инициативу!',
                textAlign: TextAlign.center,
                style: AppTextStyles.authText,
              ),
              const SizedBox(height: 16),
              const Text(
                'Мы внимательно рассмотрим твоё предложение и свяжемся с тобой в ближайшее время',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 40),
              ClipRect(child: Image.asset('assets/icons/success.png',height: 120)),
              const SizedBox(height: 40),
              const Text(
                'Продолжай вносить свой вклад в развитие нашей школы!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'На главную',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class ThumbUpPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint outlinePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final Paint fillPaint = Paint()
      ..color = const Color(0xFFFFFBF0)
      ..style = PaintingStyle.fill;

    final Paint greenPaint = Paint()
      ..color = const Color(0xFF8B9B6C)
      ..style = PaintingStyle.fill;

    final Paint dotPaint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.fill;

    // Draw thumb base (hand part)
    final Path handPath = Path()
      ..moveTo(size.width * 0.3, size.height * 0.4)
      ..lineTo(size.width * 0.3, size.height * 0.8)
      ..lineTo(size.width * 0.5, size.height * 0.8)
      ..lineTo(size.width * 0.5, size.height * 0.4)
      ..close();

    // Draw thumb up part
    final Path thumbPath = Path()
      ..moveTo(size.width * 0.5, size.height * 0.4)
      ..lineTo(size.width * 0.7, size.height * 0.4)
      ..lineTo(size.width * 0.7, size.height * 0.2)
      ..lineTo(size.width * 0.5, size.height * 0.2)
      ..close();

    // Fill paths
    canvas.drawPath(handPath, greenPaint);
    canvas.drawPath(thumbPath, greenPaint);

    // Draw outlines
    canvas.drawPath(handPath, outlinePaint);
    canvas.drawPath(thumbPath, outlinePaint);

    // Draw dot
    canvas.drawCircle(
      Offset(size.width * 0.4, size.height * 0.6),
      size.width * 0.03,
      dotPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}