import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isLoading = false;
  String? error;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleSignIn() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      setState(() => error = "Please enter both email and password.");
      return;
    }

    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      await ref
          .read(authNotifierProvider.notifier)
          .signInWithEmailAndPassword(
            _emailController.text.trim(),
            _passwordController.text,
          );

      // Wait a bit for doc update and check role
      final isAdmin = await ref
          .refresh(userDocProvider.future)
          .then((doc) => doc?['role'] == 'admin');

      if (!isAdmin) {
        await ref.read(authNotifierProvider.notifier).signOut();
        setState(
          () => error =
              "Oops! You don't have permission to access the Admin CMS.",
        );
      }
    } catch (e) {
      debugPrint("Login error: $e");
      setState(() => error = "Invalid email or password. Please try again.");
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Logo or App Icon
                Container(
                  width: 64,
                  height: 64,
                  decoration: const BoxDecoration(
                    color: Colors.blueGrey,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.admin_panel_settings_rounded,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Hoc Tieng Phan Admin CMS',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Enter your credentials to access the portal.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 32),

                // Email Field
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email Address',
                    prefixIcon: const Icon(Icons.email_outlined, size: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),

                // Password Field
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock_outline, size: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 24),

                if (error != null)
                  Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.red.shade100),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.error_outline,
                          color: Colors.red.shade700,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            error!,
                            style: TextStyle(
                              color: Colors.red.shade800,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _handleSignIn,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blueGrey.shade800,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: isLoading
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            'Login to Dashboard',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                  ),
                ),

                const SizedBox(height: 24),
                const Text(
                  'Protected by Firebase Security Rules',
                  style: TextStyle(fontSize: 12, color: Colors.black38),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
