import 'package:flutter/material.dart';
import '../core/app_theme.dart';
import '../widgets/share_widgets.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _controller = TextEditingController();
  String? _error;

  void _submit() {
    final username = _controller.text.trim();
    if (username.isEmpty) {
      setState(() => _error = 'Vui lòng nhập tên đăng nhập');
      return;
    }
    setState(() => _error = null);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const PasswordSentScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      formContent: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                const Text(
                  'Quên mật khẩu',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Hệ thống sẽ gửi mật khẩu mới tới email đã đăng ký của người dùng',
                  style: TextStyle(
                    fontSize: 10,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          RichText(
            text: const TextSpan(
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Màu chữ "Tên đăng nhập"
              ),
              children: [
                TextSpan(
                  text: ' *',
                  style: TextStyle(
                    color: Colors.red, // Định dạng riêng dấu * thành màu đỏ
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: 'Tên đăng nhập'),
              ],
            ),
          ),

          const SizedBox(height: 8),
          TextFormField(
            controller: _controller,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Nhập tên đăng nhập',
              hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
              prefixIcon: Icon(Icons.person_outline, size: 20),
            ),
          ),
          if (_error != null) ...[
            const SizedBox(height: 6),
            Text(
              _error!,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ],
          const SizedBox(height: 32),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(40),
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: _submit,
            child: const Text(
              'Quên mật khẩu',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(height: 16),
          const FooterInfo(),
        ],
      ),
    );
  }
}

class PasswordSentScreen extends StatelessWidget {
  const PasswordSentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      formContent: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 16),
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.success.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_circle,
              color: AppColors.success,
              size: 40,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Đã gửi mật khẩu',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              text: 'Mật khẩu mới đã gửi về email ',
              style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
              children: [
                TextSpan(text: 'Mật khẩu mới đã gửi về email '),
                TextSpan(
                  text: 'nguyễn****anh@viettel.com.vn',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                TextSpan(
                  text: 'của bạn.',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(40),
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            child: const Text(
              'Quay lại đăng nhập',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Bạn chưa nhận được mật khẩu? ',
                style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Text(
                  'Gửi lại mật khẩu',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const FooterInfo(),
        ],
      ),
    );
  }
}
