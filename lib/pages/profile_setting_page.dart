import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../models/user_profile.dart';
import '../services/profile_service.dart';

class ProfileSettingPage extends StatefulWidget {
  const ProfileSettingPage({super.key});

  @override
  State<ProfileSettingPage> createState() => _ProfileSettingPageState();
}

class _ProfileSettingPageState extends State<ProfileSettingPage> {
  final _profileService = ProfileService();
  final _picker = ImagePicker();

  late TextEditingController _nameController;
  late TextEditingController _ageController;

  String gender = "";
  List<String> situations = [];
  List<String> styles = [];
  String? imagePath;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _ageController = TextEditingController();
    _loadProfile();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  Future<void> _loadProfile() async {
    final profile = await _profileService.loadProfile();
    if (!mounted || profile == null) return;

    setState(() {
      _nameController.text = profile.name;
      _ageController.text = profile.age == 0 ? "" : profile.age.toString();
      gender = profile.gender;
      situations = List<String>.from(profile.situations);
      styles = List<String>.from(profile.styles);
      imagePath = profile.imagePath;
    });
  }

  Future<void> _pickImage() async {
    final XFile? file = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (file == null) return;

    setState(() {
      imagePath = file.path;
    });
  }

  Future<void> _onSave() async {
    final name = _nameController.text.trim();
    final ageText = _ageController.text.trim();

    if (name.isEmpty || ageText.isEmpty || gender.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("이름, 나이, 성별을 입력해주세요.")));
      return;
    }

    final int? ageInt = int.tryParse(ageText);
    if (ageInt == null || ageInt <= 0) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("나이를 올바르게 입력해주세요.")));
      return;
    }

    final profile = UserProfile(
      name: name,
      age: ageInt,
      gender: gender,
      situations: situations,
      styles: styles,
      imagePath: imagePath,
    );

    await _profileService.saveProfile(profile);

    if (!mounted) return;
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F5F2),

      body: SafeArea(
        child: Column(
          children: [
            // ---------- 상단 헤더 ----------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 20,
                      color: Color(0xFF3A3A3A),
                    ),
                    onPressed: () => context.pop(),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(width: 6),
                  const Text(
                    "프로필 설정",
                    style: TextStyle(
                      fontFamily: "Pretendard",
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1F1F1F),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 18),

                    // ---------- 프로필 사진 + 카메라 버튼 ----------
                    _profileAvatar(),

                    const SizedBox(height: 10),
                    const Text(
                      "탭해서 프로필 사진을 설정해 주세요.",
                      style: TextStyle(
                        fontFamily: "Pretendard",
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF8A8A8A),
                      ),
                    ),

                    const SizedBox(height: 28),

                    // ---------- 기본 정보 카드 ----------
                    _sectionTitle("기본 정보"),
                    const SizedBox(height: 10),
                    _infoCard(
                      children: [
                        _textFieldRow(
                          label: "이름",
                          hint: "예: 민서",
                          controller: _nameController,
                          keyboardType: TextInputType.text,
                        ),
                        const SizedBox(height: 16),
                        _textFieldRow(
                          label: "나이",
                          hint: "예: 27",
                          controller: _ageController,
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 22),
                        _genderSelector(),
                      ],
                    ),

                    const SizedBox(height: 28),

                    // ---------- 상황 선택 ----------
                    _sectionTitle("연습하고 싶은 상황"),
                    const SizedBox(height: 10),
                    _infoCard(
                      padding: const EdgeInsets.fromLTRB(14, 14, 14, 10),
                      children: [
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            _chip(situations, "소개팅"),
                            _chip(situations, "썸"),
                            _chip(situations, "연인"),
                            _chip(situations, "재회"),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // ---------- 대화 스타일 ----------
                    _sectionTitle("대화 스타일"),
                    const SizedBox(height: 10),
                    _infoCard(
                      padding: const EdgeInsets.fromLTRB(14, 14, 14, 10),
                      children: [
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            _chip(styles, "부드러운 톤"),
                            _chip(styles, "장난기 있는 톤"),
                            _chip(styles, "신중한 톤"),
                            _chip(styles, "직설적인 톤"),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 120),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // ---------- 하단 저장 버튼 ----------
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 0, 22, 26),
          child: GestureDetector(
            onTap: _onSave,
            child: Container(
              height: 56,
              decoration: BoxDecoration(
                color: const Color(0xFFFF5A7A),
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFF9BB0).withOpacity(0.4),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: const Center(
                child: Text(
                  "저장하기",
                  style: TextStyle(
                    fontFamily: "Pretendard",
                    fontWeight: FontWeight.w700,
                    fontSize: 17,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ================== 위젯들 ==================

  // 프로필 아바타 + 카메라 버튼
  Widget _profileAvatar() {
    return GestureDetector(
      onTap: _pickImage,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 124,
            height: 124,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFF3EDED),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.10),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ClipOval(
              child: imagePath == null
                  ? const Icon(Icons.person, size: 64, color: Color(0xFFCBCBCB))
                  : Image.file(File(imagePath!), fit: BoxFit.cover),
            ),
          ),
          Positioned(
            right: -2,
            bottom: 0,
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.18),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Container(
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFFAEC2), Color(0xFFFF819B)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Icon(
                  Icons.camera_alt_rounded,
                  size: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(
          fontFamily: "Pretendard",
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: Color(0xFF3A3A3A),
        ),
      ),
    );
  }

  // 공통 카드 컨테이너
  Widget _infoCard({
    required List<Widget> children,
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(
      vertical: 16,
      horizontal: 16,
    ),
  }) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE5DED7)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  // 라벨 + TextField 한 줄
  Widget _textFieldRow({
    required String label,
    required String hint,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: "Pretendard",
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF6A6A6A),
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          cursorColor: const Color(0xFF1F1F1F),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              fontFamily: "Pretendard",
              fontSize: 14,
              color: Color(0xFFB2B2B2),
            ),
            filled: true,
            fillColor: const Color(0xFFF9F7F5),
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE3DDD7)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFF1F1F1F),
                width: 1.4,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // 성별 선택
  Widget _genderSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "성별",
          style: TextStyle(
            fontFamily: "Pretendard",
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF6A6A6A),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            _genderButton("남성", "M"),
            const SizedBox(width: 10),
            _genderButton("여성", "F"),
          ],
        ),
      ],
    );
  }

  Widget _genderButton(String label, String value) {
    final selected = gender == value;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => gender = value),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 130),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: selected
                ? const LinearGradient(
                    colors: [Color(0xFFFFD6E0), Color(0xFFFFA9BD)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : const LinearGradient(
                    colors: [Color(0xFFF4F4F4), Color(0xFFEDEDED)],
                  ),
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: const Color(0xFFFF9BB0).withOpacity(0.5),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : [],
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontFamily: "Pretendard",
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: selected ? Colors.white : const Color(0xFF3A3A3A),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // 칩
  Widget _chip(List<String> list, String label) {
    final active = list.contains(label);

    return GestureDetector(
      onTap: () {
        setState(() {
          active ? list.remove(label) : list.add(label);
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(999),
          color: active ? const Color(0xFFFFF3F2) : const Color(0xFFF6F6F6),
          border: Border.all(
            color: active ? const Color(0xFFFF9DA5) : const Color(0xFFE0E0E0),
          ),
          boxShadow: active
              ? [
                  BoxShadow(
                    color: const Color(0xFFFF8D9C).withOpacity(0.25),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontFamily: "Pretendard",
            fontWeight: FontWeight.w700,
            fontSize: 13,
            color: Color(0xFF333333),
          ),
        ),
      ),
    );
  }
}
