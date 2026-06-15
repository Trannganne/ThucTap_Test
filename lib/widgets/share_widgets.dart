import 'package:flutter/material.dart';
import '../core/app_theme.dart';

class AuthLayout extends StatelessWidget {
  final Widget formContent;
  final bool showBack;
  final VoidCallback? onBack;

  const AuthLayout({
    super.key,
    required this.formContent,
    this.showBack = false,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE53935),
      body: Column(
        children: [
          // Giữ nguyên phần Header cũ
          _buildHeader(context),

          // Tấm nền trắng phẳng được xử lý cuộn chống tràn bàn phím
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                // Bo 2 góc trên mềm mại tiếp giáp với phần màu đỏ
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              // Dùng SingleChildScrollView ở đây để khi bật bàn phím không bị lỗi gạch sọc vàng/đen
              child: SingleChildScrollView(
                // Thêm Padding để đẩy toàn bộ nội dung formContent vào trong gọn gàng
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 32,
                ),
                child: formContent,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFEF5350), Color(0xFFE53935)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        bottom:
            false, // Không tính phần đệm phía dưới của tai thỏ để tối ưu diện tích
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: -10,
              child: _bubble(110, Colors.white.withOpacity(0.12)),
            ),
            Positioned(
              top: 20,
              right: 50,
              child: _bubble(70, Colors.white.withOpacity(0.10)),
            ),
            Positioned(
              top: 30,
              right: 20,
              child: Icon(
                Icons.shopping_cart_outlined,
                color: Colors.white.withOpacity(0.6),
                size: 28,
              ),
            ),
            Positioned(
              top: 55,
              right: 65,
              child: Icon(
                Icons.person_outline,
                color: Colors.white.withOpacity(0.55),
                size: 22,
              ),
            ),
            Positioned(
              top: 10,
              right: 95,
              child: Icon(
                Icons.bar_chart_outlined,
                color: Colors.white.withOpacity(0.45),
                size: 20,
              ),
            ),
            Positioned(
              top: 55,
              right: 22,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'PG',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            if (showBack)
              Positioned(
                top: 4,
                left: 4,
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 20,
                  ),
                  onPressed: onBack ?? () => Navigator.of(context).pop(),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _bubble(double size, Color color) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(color: color, shape: BoxShape.circle),
  );
}

class FooterInfo extends StatelessWidget {
  const FooterInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, top: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.email_outlined,
                size: 13,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: 4),
              Text(
                'support@viettel.com.vn',
                style: TextStyle(fontSize: 11, color: AppColors.textSecondary),
              ),
              const SizedBox(width: 14),
              Icon(
                Icons.phone_outlined,
                size: 13,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: 4),
              Text(
                '1900 8090',
                style: TextStyle(fontSize: 11, color: AppColors.textSecondary),
              ),
            ],
          ),
          // Khoảng cách giữa hàng liên hệ và dòng bản quyền
          const SizedBox(height: 125),

          // 2. Dòng chữ bản quyền Cholimex mới thêm vào
          Text(
            '© Cholimex 2026. All rights reserved.',
            style: TextStyle(
              fontSize: 11,
              color: AppColors.textSecondary.withOpacity(
                0.7,
              ), // Làm mờ nhẹ đi một chút cho tinh tế giống các app chuyên nghiệp
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
