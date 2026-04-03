import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const bgColor = Color(0xFFF5F6FA);
    const primaryColor = Color(0xFF1565D8);
    const textColor = Color(0xFF1C2230);
    const subTextColor = Color(0xFF6B7280);
    const borderColor = Color(0xFFD9DDE5);

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 10),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios_new, color: textColor),
                  ),
                  const Expanded(
                    child: Text(
                      'Профиль',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        color: textColor,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.edit_outlined, color: textColor),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: borderColor),
                      ),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 42,
                            backgroundColor: primaryColor.withOpacity(0.12),
                            child: const Icon(
                              Icons.person_outline,
                              size: 42,
                              color: primaryColor,
                            ),
                          ),
                          const SizedBox(height: 14),
                          const Text(
                            'Лоло',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              color: textColor,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'cerkgosa@gmail.com',
                            style: TextStyle(
                              fontSize: 15,
                              color: subTextColor,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: primaryColor.withOpacity(0.10),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Text(
                              'Я ищу работу',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 18),

                    _ProfileCard(
                      title: 'Основная информация',
                      child: Column(
                        children: const [
                          _ProfileRow(
                            icon: Icons.person_outline,
                            title: 'Имя',
                            value: 'Лоло',
                          ),
                          SizedBox(height: 16),
                          _ProfileRow(
                            icon: Icons.location_on_outlined,
                            title: 'Регион',
                            value: 'Кабардино-Балкарская Республика',
                          ),
                          SizedBox(height: 16),
                          _ProfileRow(
                            icon: Icons.email_outlined,
                            title: 'E-mail',
                            value: 'cerkgosa@gmail.com',
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 18),

                    _ProfileCard(
                      title: 'Мои навыки',
                      child: Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: const [
                          _SkillChip(label: 'Flutter'),
                          _SkillChip(label: 'Dart'),
                          _SkillChip(label: 'Firebase'),
                          _SkillChip(label: 'REST API'),
                        ],
                      ),
                    ),

                    const SizedBox(height: 18),

                    _ProfileCard(
                      title: 'О себе',
                      child: const Text(
                        'Начинающий mobile-разработчик. Ищу возможности для роста и участия в интересных проектах.',
                        style: TextStyle(
                          fontSize: 15,
                          height: 1.5,
                          color: textColor,
                        ),
                      ),
                    ),

                    const SizedBox(height: 28),

                    SizedBox(
                      width: double.infinity,
                      height: 58,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text(
                          'Редактировать профиль',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    SizedBox(
                      width: double.infinity,
                      height: 58,
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: borderColor),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          backgroundColor: Colors.white,
                        ),
                        child: const Text(
                          'Выйти из аккаунта',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: textColor,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _ProfileCard({
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    const borderColor = Color(0xFFD9DDE5);
    const textColor = Color(0xFF1C2230);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: textColor,
            ),
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

class _ProfileRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _ProfileRow({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    const textColor = Color(0xFF1C2230);
    const subTextColor = Color(0xFF6B7280);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: subTextColor, size: 22),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 13,
                  color: subTextColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SkillChip extends StatelessWidget {
  final String label;

  const _SkillChip({required this.label});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF1565D8);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: primaryColor,
        ),
      ),
    );
  }
}