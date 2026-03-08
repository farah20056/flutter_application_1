import 'package:flutter/material.dart';

class LoginRegisterScreen extends StatefulWidget {
  const LoginRegisterScreen({super.key});

  @override
  State<LoginRegisterScreen> createState() => _LoginRegisterScreenState();
}

class _LoginRegisterScreenState extends State<LoginRegisterScreen> {
  // تعريف المتحكمات للنصوص لربطها بـ Firebase لاحقاً
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // لون الخلفية البيج (Cream) كما في الصورة
      backgroundColor: const Color(0xFFF2EFE9),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          // إضافة لمسة تدرج خفيفة جداً لتعطي مظهر الورق الفاخر
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFDFCFB), Color(0xFFE2D1C3)],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // اللوغو الذهبي
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFD4AF37),
                      width: 1.5,
                    ),
                  ),
                  child: const Icon(
                    Icons.card_membership_outlined,
                    size: 70,
                    color: Color(0xFFD4AF37),
                  ),
                ),
                const SizedBox(height: 20),

                // اسم التطبيق
                const Text(
                  "FideliPro",
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF8B7355),
                    letterSpacing: 1.2,
                  ),
                ),
                const Text(
                  "Gestion des Cartes de Fidélité",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFFA68D6E),
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 60),

                // حقل اسم المستخدم / الإيميل
                _buildCustomTextField(
                  controller: _emailController,
                  hint: "Nom d'utilisateur",
                  icon: Icons.person_outline,
                ),
                const SizedBox(height: 20),

                // حقل كلمة السر
                _buildCustomTextField(
                  controller: _passwordController,
                  hint: "Mot de passe",
                  icon: Icons.lock_outline,
                  isPassword: true,
                ),

                const SizedBox(height: 40),

                // زر تسجيل الدخول (التصميم الذهبي المتدرج)
                GestureDetector(
                  onTap: () {
                    // هنا سيتم وضع كود Firebase signIn لاحقاً
                    print("Attempting to login...");
                  },
                  child: Container(
                    width: double.infinity,
                    height: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFFC5A059),
                          Color(0xFFD4AF37),
                          Color(0xFFB8860B),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFD4AF37).withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        "Se Connecter",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // روابط أسفل الزر
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Mot passe oublié ?",
                        style: TextStyle(color: Color(0xFF8B7355)),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Créer un compte",
                        style: TextStyle(
                          color: Color(0xFF8B7355),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // دالة بناء الحقول بتصميم متناسق
  Widget _buildCustomTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool isPassword = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFFD4AF37).withOpacity(0.5)),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        style: const TextStyle(color: Color(0xFF8B7355)),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Color(0xFFA68D6E)),
          prefixIcon: Icon(icon, color: const Color(0xFFD4AF37)),
          suffixIcon: isPassword
              ? const Icon(
                  Icons.lock_rounded,
                  size: 20,
                  color: Color(0xFFD4AF37),
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }
}
