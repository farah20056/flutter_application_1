import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:ui';
import 'pages/home.page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LuxuryLoginScreen(),
    );
  }
}

class LuxuryLoginScreen extends StatefulWidget {
  const LuxuryLoginScreen({super.key});

  @override
  State<LuxuryLoginScreen> createState() => _LuxuryLoginScreenState();
}

class _LuxuryLoginScreenState extends State<LuxuryLoginScreen>
    with TickerProviderStateMixin {
  late AnimationController _bgController;
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    // تحكم في سرعة حركة البطاقات في الخلفية
    _bgController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    )..repeat();
  }

  @override
  void dispose() {
    _bgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(
        255,
        235,
        234,
        229,
      ), // خلفية سوداء عميقة
      body: Stack(
        children: [
          // 1. الخلفية المتحركة (البطاقات الذهبية العائمة)
          AnimatedBuilder(
            animation: _bgController,
            builder: (context, child) {
              return CustomPaint(
                painter: FloatingCardsPainter(_bgController.value),
                child: Container(),
              );
            },
          ),

          // 2. طبقة تغبيش خفيفة للعمق
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
            child: Container(color: Colors.black.withOpacity(0.1)),
          ),

          // 3. المحتوى الأساسي
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  const SizedBox(height: 40),

                  // تصميم البطاقة الماسية (Diamond Status) المطلوب
                  _buildDiamondCard(),

                  const SizedBox(height: 40),
                  const Text(
                    "Fid&Scan",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 1.5,
                      shadows: [
                        Shadow(
                          color: Color.fromARGB(255, 145, 117, 34),
                          offset: Offset(2, 2),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ),
                  const Text(
                    "Votre Fidélité mérite l'exellence",
                    style: TextStyle(
                      color: Color.fromARGB(255, 158, 139, 76),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 50),

                  // خانات الإدخال بظلال ذهبية متوهجة
                  _buildLuxuryInput(
                    hint: "Email ou Numéro de Téléphone",
                    icon: Icons.alternate_email_rounded,
                  ),
                  const SizedBox(height: 20),
                  _buildLuxuryInput(
                    hint: "Mot de passe",
                    icon: Icons.fingerprint_rounded,
                    isPass: true,
                  ),

                  const SizedBox(height: 40),

                  // زر تسجيل الدخول
                  _buildLoginButton(),

                  const SizedBox(height: 50),

                  // قسم التواصل الاجتماعي
                  _buildSocialSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // تصميم البطاقة الذهبية الفخم (Diamond Card)
  Widget _buildDiamondCard() {
    return Container(
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFE6BE8A), Color(0xFFB8860B), Color(0xFFD4AF37)],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFD4AF37).withOpacity(0.4),
            blurRadius: 25,
            spreadRadius: 2,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          // أيقونة الألماس الكبيرة في الخلفية
          Positioned(
            right: -20,
            top: -10,
            child: Icon(
              Icons.diamond,
              size: 160,
              color: Colors.white.withOpacity(0.1),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "DIAMOND STATUS",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    Icon(
                      Icons.contactless_outlined,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ],
                ),
                const Text(
                  "**** **** **** 2026",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.5,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "FID&SCAN MEMBER",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 12,
                      ),
                    ),
                    const Icon(
                      Icons.qr_code_2_rounded,
                      color: Colors.white,
                      size: 35,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // تصميم خانات الإدخال البيضاء المتوهجة
  Widget _buildLuxuryInput({
    required String hint,
    required IconData icon,
    bool isPass = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFD4AF37).withOpacity(0.3),
            blurRadius: 15,
            spreadRadius: 1,
          ),
        ],
      ),
      child: TextField(
        obscureText: isPass ? !_isPasswordVisible : false,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon, color: const Color(0xFFD4AF37)),
          suffixIcon: isPass
              ? IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: Colors.black26,
                  ),
                  onPressed: () =>
                      setState(() => _isPasswordVisible = !_isPasswordVisible),
                )
              : null,
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 20,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return Container(
      width: double.infinity,
      height: 65,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        gradient: const LinearGradient(
          colors: [Color(0xFFD4AF37), Color(0xFFB8860B)],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFD4AF37).withOpacity(0.4),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: const Text(
          "SE CONNECTER",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialSection() {
    return Column(
      children: [
        const Text(
          "Ou se connecter avec",
          style: TextStyle(color: Colors.white54, fontSize: 12),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _socialIcon(
              'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_"G"_logo.svg/1200px-Google_"G"_logo.svg.png',
            ),
            const SizedBox(width: 30),
            _socialIcon(
              null,
              icon: Icons.facebook,
              color: const Color(0xFF1877F2),
            ),
          ],
        ),
      ],
    );
  }

  Widget _socialIcon(String? url, {IconData? icon, Color? color}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
      ),
      child: url != null
          ? Image.network(url, width: 28)
          : Icon(icon, color: color, size: 32),
    );
  }
}

// الرسام الخاص بالبطاقات الذهبية المتحركة في الخلفية السوداء
class FloatingCardsPainter extends CustomPainter {
  final double animationValue;
  FloatingCardsPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        colors: [
          const Color(0xFFD4AF37).withOpacity(0.15),
          const Color(0xFFB8860B).withOpacity(0.02),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final math.Random random = math.Random(10); // بذور ثابتة للعناصر

    for (int i = 0; i < 12; i++) {
      double x =
          (random.nextDouble() * size.width + (animationValue * 50)) %
          size.width;
      double y =
          (random.nextDouble() * size.height + (animationValue * size.height)) %
          size.height;

      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(animationValue * math.pi * 0.2); // دوران خفيف جداً

      // رسم شكل البطاقة الصغيرة
      RRect card = RRect.fromLTRBR(0, 0, 80, 50, const Radius.circular(8));
      canvas.drawRRect(card, paint);

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
