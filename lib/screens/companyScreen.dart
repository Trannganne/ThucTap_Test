import 'package:flutter/material.dart';
import 'package:thuctap_test/widgets/share_widgets.dart';
import '../core/app_theme.dart';
import '../core/mock_data.dart';
import '../widgets/share_widgets.dart';
import 'loginScreen.dart';

class CompanyScreen extends StatefulWidget {
  const CompanyScreen({super.key});

  @override
  State<CompanyScreen> createState() => _CompanyScreenState();
}

class _CompanyScreenState extends State<CompanyScreen> {
  final _controller = TextEditingController();
  String? _error;

  void _continue() {
    final code = _controller.text.trim();
    if (code.isEmpty) {
      setState(() => _error = 'Vui lòng nhập mã doanh nghiệp');
      return;
    }
    if (!MockData.isValidCompanyCode(code)) {
      setState(() => _error = 'Mã doanh nghiệp không hợp lệ (thử: VTT001)');
      return;
    }
    setState(() => _error = null);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => LoginScreen(companyCode: code)),
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
              children: const [
                const Text(
                  'Đăng nhập',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Chào mừng bạn trở lại!',
                  style: TextStyle(
                    fontSize: 13,
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
                color: Colors.black, // Màu chữ "Mã công ty"
              ),
              children: [
                TextSpan(text: 'Mã công ty'),
                TextSpan(
                  text: ' *',
                  style: TextStyle(
                    color: Colors.red, // Định dạng riêng dấu * thành màu đỏ
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),
          TextFormField(
            controller: _controller,

            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Nhập mã định danh công ty',
              hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
              prefixIcon: Icon(Icons.business_outlined, size: 20),
            ),
            onFieldSubmitted: (_) => _continue(),
          ),
          if (_error != null) ...[
            const SizedBox(height: 6),
            Text(
              _error!,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ],

          const SizedBox(height: 24),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(40),
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: _continue,
            child: const Text(
              'Tiếp tục',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
