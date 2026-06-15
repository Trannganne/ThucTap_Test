import 'package:flutter/material.dart';
import '../core/app_theme.dart';
import '../core/mock_data.dart';
import '../widgets/share_widgets.dart';
import 'homeScreen.dart';

class RoleScreen extends StatefulWidget {
  final MockUser user;

  const RoleScreen({super.key, required this.user});

  @override
  State<RoleScreen> createState() => _RoleScreenState();
}

class _RoleScreenState extends State<RoleScreen> {
  String? _selectedRole;

  void _confirm() {
    if (_selectedRole == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng chọn chức vụ'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) =>
            HomeScreen(user: widget.user, selectedRole: _selectedRole!),
      ),
      (_) => false,
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
                  'Chức vụ',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Chọn chức vụ phù hợp',
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
                color: Colors.black,
              ),
              children: [
                TextSpan(text: 'Chức vụ'),
                TextSpan(
                  text: ' *',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.border),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedRole,
                hint: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    'Chọn chức vụ theo đơn vị',
                    style: TextStyle(color: AppColors.textHint, fontSize: 14),
                  ),
                ),
                isExpanded: true,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                borderRadius: BorderRadius.circular(8),
                items: widget.user.roles
                    .map(
                      (role) =>
                          DropdownMenuItem(value: role, child: Text(role)),
                    )
                    .toList(),
                onChanged: (val) => setState(() => _selectedRole = val),
              ),
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
            onPressed: _confirm,
            child: const Text('Đồng ý', style: TextStyle(color: Colors.white)),
          ),
          const SizedBox(height: 16),
          const FooterInfo(),
        ],
      ),
    );
  }
}
