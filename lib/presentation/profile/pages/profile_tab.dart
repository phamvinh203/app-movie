import 'package:app_movie/common/helper/navigation/app_navigation.dart';
import 'package:app_movie/core/configs/theme/app_colors.dart';
import 'package:app_movie/domain/auth/usecases/signout.dart';
import 'package:app_movie/presentation/auth/pages/signin.dart';
import 'package:flutter/material.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header với avatar và thông tin user
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 32,
                  horizontal: 24,
                ),
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                ),
                child: Column(
                  children: [
                    // Avatar
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.primary, width: 3),
                      ),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: AppColors.primary.withOpacity(0.2),
                        child: const Icon(
                          Icons.person,
                          size: 50,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Tên người dùng
                    const Text(
                      'Tên người dùng',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Email
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'user@example.com',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Menu items
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section: Nội dung
                    const Padding(
                      padding: EdgeInsets.only(left: 8, bottom: 12),
                      child: Text(
                        'NỘI DUNG',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                    _buildMenuItem(
                      icon: Icons.favorite,
                      title: 'Danh sách yêu thích',
                      onTap: () {},
                    ),
                    const SizedBox(height: 8),
                    _buildMenuItem(
                      icon: Icons.download,
                      title: 'Đã tải xuống',
                      onTap: () {},
                    ),
                    const SizedBox(height: 8),
                    _buildMenuItem(
                      icon: Icons.history,
                      title: 'Lịch sử xem',
                      onTap: () {},
                    ),

                    const SizedBox(height: 24),

                    // Section: Cài đặt
                    const Padding(
                      padding: EdgeInsets.only(left: 8, bottom: 12),
                      child: Text(
                        'CÀI ĐẶT',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                    _buildMenuItem(
                      icon: Icons.notifications,
                      title: 'Thông báo',
                      onTap: () {},
                    ),
                    const SizedBox(height: 8),
                    _buildMenuItem(
                      icon: Icons.help,
                      title: 'Trợ giúp & Hỗ trợ',
                      onTap: () {},
                    ),
                    const SizedBox(height: 8),
                    _buildMenuItem(
                      icon: Icons.privacy_tip,
                      title: 'Chính sách & Quyền riêng tư',
                      onTap: () {},
                    ),

                    const SizedBox(height: 24),

                    
                    _buildMenuItem(
                      icon: Icons.logout,
                      title: 'Đăng xuất',
                      onTap: () async {
                        // Hiển thị dialog xác nhận
                        final confirm = await showDialog<bool>(
                          context: context,
                          builder: (context) => AlertDialog(
                            backgroundColor: AppColors.cardBackground,
                            title: const Text(
                              'Xác nhận đăng xuất',
                              style: TextStyle(color: AppColors.textPrimary),
                            ),
                            content: const Text(
                              'Bạn có chắc chắn muốn đăng xuất?',
                              style: TextStyle(color: AppColors.textSecondary),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: const Text('Hủy'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: const Text(
                                  'Đăng xuất',
                                  style: TextStyle(color: AppColors.error),
                                ),
                              ),
                            ],
                          ),
                        );

                        if (confirm == true && context.mounted) {
                          // Thực hiện đăng xuất
                          await SignOutUseCase().call();
                          if (context.mounted) {
                            AppNavigator.pushAndRemove(
                              context,
                              const SigninPage(),
                            );
                          }
                        }
                      },
                      isDestructive: true,
                    ),

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isDestructive
                        ? AppColors.error.withOpacity(0.1)
                        : AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: isDestructive ? AppColors.error : AppColors.primary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: isDestructive
                          ? AppColors.error
                          : AppColors.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
