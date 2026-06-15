import 'package:flutter/material.dart';
import '../core/app_theme.dart';
import '../core/mock_data.dart';
import 'companyScreen.dart';

class HomeScreen extends StatefulWidget {
  final MockUser user;
  final String selectedRole;

  const HomeScreen({super.key, required this.user, required this.selectedRole});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 2;

  final List<_NavItem> _navItems = [
    _NavItem(icon: Icons.list_alt_outlined, label: 'Báo cáo'),
    _NavItem(icon: Icons.punch_clock_outlined, label: 'Chấm công'),
    _NavItem(icon: Icons.grid_view_outlined, label: 'Trang chủ', isHome: true),
    _NavItem(icon: Icons.notifications_outlined, label: 'Thông báo'),
    _NavItem(icon: Icons.person_outline, label: 'Tài khoản'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F5),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(child: _buildBody()),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.white,
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: AppColors.primaryLight,
            child: Text(
              widget.user.fullName[0],
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Xin chào, ${widget.user.fullName}',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          GestureDetector(
            onTap: _logout,
            child: const Icon(
              Icons.logout_outlined,
              color: AppColors.textSecondary,
              size: 22,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(children: [_buildMenuGrid()]),
    );
  }

  Widget _buildMenuGrid() {
    final items = [
      _MenuItem(
        icon: Icons.receipt_long_outlined,
        label: 'Ghé thăm',
        color: AppColors.primary,
        bgColor: const Color(0xFFFFEBEE),
      ),
      _MenuItem(
        icon: Icons.access_time_outlined,
        label: 'Chấm công',
        color: const Color(0xFF1565C0),
        bgColor: const Color(0xFFE3F2FD),
      ),
      _MenuItem(
        icon: Icons.center_focus_weak,
        label: 'Điểm danh',
        color: const Color(0xFF2E7D32),
        bgColor: const Color(0xFFE8F5E9),
      ),
      _MenuItem(
        icon: Icons.shopping_bag,
        label: 'Sản phẩm',
        color: const Color(0xFF00897B),
        bgColor: const Color(0xFFE0F2F1),
      ),
      _MenuItem(
        icon: Icons.image_outlined,
        label: 'Hình ảnh',
        color: const Color(0xFFF57C00),
        bgColor: const Color(0xFFFFF3E0),
      ),
      _MenuItem(
        icon: Icons.badge_outlined,
        label: 'Tin báo',
        color: AppColors.primary,
        bgColor: const Color(0xFFFFEBEE),
      ),
      _MenuItem(
        icon: Icons.calendar_today,
        label: 'Yêu cầu đổi lịch',
        color: const Color(0xFF6A1B9A),
        bgColor: const Color(0xFFF3E5F5),
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.0,
      ),
      itemCount: items.length,
      itemBuilder: (_, i) => _buildMenuCard(items[i]),
    );
  }

  Widget _buildMenuCard(_MenuItem item) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Mở ${item.label}'),
            duration: const Duration(seconds: 1),
            backgroundColor: AppColors.primary,
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: item.bgColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(item.icon, color: item.color, size: 26),
            ),
            const SizedBox(height: 8),
            Text(
              item.label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          height: 60,
          child: Row(
            children: List.generate(_navItems.length, (i) {
              final item = _navItems[i];
              final isSelected = i == _currentIndex;
              return Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _currentIndex = i),
                  child: Container(
                    color: Colors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (item.isHome)
                          Container(
                            width: 48,
                            height: 48,
                            margin: const EdgeInsets.only(bottom: 2),
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              item.icon,
                              color: Colors.white,
                              size: 24,
                            ),
                          )
                        else ...[
                          Icon(
                            item.icon,
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.textSecondary,
                            size: 22,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            item.label,
                            style: TextStyle(
                              fontSize: 10,
                              color: isSelected
                                  ? AppColors.primary
                                  : AppColors.textSecondary,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  void _logout() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Đăng xuất'),
        content: const Text('Bạn có chắc muốn đăng xuất?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const CompanyScreen()),
                (_) => false,
              );
            },
            child: const Text(
              'Đăng xuất',
              style: TextStyle(color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  final bool isHome;

  const _NavItem({
    required this.icon,
    required this.label,
    this.isHome = false,
  });
}

class _MenuItem {
  final IconData icon;
  final String label;
  final Color color;
  final Color bgColor;

  const _MenuItem({
    required this.icon,
    required this.label,
    required this.color,
    required this.bgColor,
  });
}
