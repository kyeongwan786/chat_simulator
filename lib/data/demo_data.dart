// lib/data/demo_data.dart

import 'package:flutter/material.dart';
import '../models/character.dart';
import '../models/enums.dart';
import '../models/scenario.dart';
import '../models/difficulty.dart';

class DemoData {
  static const maleCharacters = [
    Character(
      id: 'doyoon',
      name: '도윤',
      tagline: '말은 서툴지만 진심은 확실한 남자.',
      tags: ['배려형', '조용한', '현실적'],
      gender: Gender.male,
      primaryColor: Color(0xFFFFD85B),
      isNew: true,
    ),
    Character(
      id: 'minjae',
      name: '민재',
      tagline: '겉으론 장난꾸러기, 속은 누구보다 진지한 친구.',
      tags: ['장난기 많은', '솔직한'],
      gender: Gender.male,
      primaryColor: Color(0xFFB4F0E8),
    ),
  ];

  static const femaleCharacters = [
    Character(
      id: 'haerin',
      name: '해린',
      tagline: '감정 표현이 서툴지만 마음은 깊은 사람.',
      tags: ['내성적', '섬세한'],
      gender: Gender.female,
      primaryColor: Color(0xFFFFB1A9),
      isNew: true,
    ),
    Character(
      id: 'sua',
      name: '수아',
      tagline: '가볍게 보이지만, 관계에선 누구보다 진지한 타입.',
      tags: ['밝은', '직설적'],
      gender: Gender.female,
      primaryColor: Color(0xFFB7A7FF),
    ),
  ];

  static const categories = [
    '전체',
    '첫 만남',
    '소개팅',
    '썸 단계',
    '연애 중',
    '갈등/싸움',
    '이별/후회',
  ];

  static List<Scenario> get scenarios {
    final c1 = maleCharacters.first;
    final c2 = femaleCharacters.first;

    return [
      Scenario(
        id: 'slow_reply',
        title: '오늘은, 답장이 늦는 상대',
        subtitle: '연락 텀 때문에 속이 불편한 상황에서의 대화 연습.',
        typeHint: ScenarioTypeHint.slowReply,
        difficulty: Difficulty.normal,
        durationMinutes: 8,
        isFree: true,
        coinCost: 0,
        categories: ['썸 단계', '연애 중'],
        recommendedCharacters: [c1, c2],
      ),
      Scenario(
        id: 'first_meet_shy',
        title: '첫 만남에서 말이 잘 안 나올 때',
        subtitle: '어색한 공기 속에서 부드럽게 분위기를 푸는 법.',
        typeHint: ScenarioTypeHint.firstMeet,
        difficulty: Difficulty.easy,
        durationMinutes: 6,
        isFree: true,
        coinCost: 0,
        categories: ['첫 만남', '소개팅'],
        recommendedCharacters: [c1],
      ),
      Scenario(
        id: 'conflict_after_text',
        title: '사소한 톡에서 시작된 갈등',
        subtitle: '의도치 않은 말투 때문에 상처받은 상황을 수습하기.',
        typeHint: ScenarioTypeHint.conflict,
        difficulty: Difficulty.hard,
        durationMinutes: 10,
        isFree: false,
        coinCost: 3,
        categories: ['연애 중', '갈등/싸움'],
        recommendedCharacters: [c2],
      ),
      Scenario(
        id: 'after_breakup',
        title: '이별 후, 한 번 더 연락하고 싶을 때',
        subtitle: '정말 보내줘야 할지, 한 번만 더 말을 걸어볼지.',
        typeHint: ScenarioTypeHint.generic,
        difficulty: Difficulty.normal,
        durationMinutes: 7,
        isFree: false,
        coinCost: 2,
        categories: ['이별/후회'],
        recommendedCharacters: [c1],
      ),
    ];
  }
}
