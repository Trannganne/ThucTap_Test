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
      height:
          220, // Tăng nhẹ chiều cao để cụm icon đám mây hiển thị thoáng và đẹp hơn
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFF3705A),
            Color(0xFFE53935),
          ], // Đổi màu cam nhẹ ở đỉnh giống ảnh gốc
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Positioned(
              top: 60,
              left: 24,
              child: Image.asset(
                'assets/images/logo.jpg',
                height: 45,
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
              top: 10,
              right: -20,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // 1. Lớp nền "Đám mây" mờ to nhất phía sau
                  Container(
                    width: 180,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  // Lớp nền mờ nhỏ hơn lồng bên trong để tạo hiệu ứng chuyển khối
                  Container(
                    width: 150,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),

                  // 2. Các đường vạch đứt kết nối hình vuông (Sử dụng Container viền chỉ)
                  Container(
                    width: 75,
                    height: 75,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),

                  // 3. ICON PHÍA TRÊN: Hình người (Màu trắng phẳng)
                  Positioned(
                    top: 15,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.25),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                  ),

                  // 4. ICON BÊN TRÁI: Xe hàng
                  Positioned(
                    left: 15,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.25),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),

                  // 5. ICON BÊN PHẢI: Đường đan chéo định tuyến (Đã đổi đúng loại icon)
                  Positioned(
                    right: 25,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.25),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.alt_route,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),

                  // 6. ICON PHÍA DƯỚI: Chữ PG hình tròn
                  Positioned(
                    bottom: 15,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.25),
                        shape: BoxShape.circle,
                      ),
                      child: const Text(
                        'PG',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // NÚT BACK (NẾU CÓ)
            if (showBack)
              Positioned(
                top: 12,
                left: 8,
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
