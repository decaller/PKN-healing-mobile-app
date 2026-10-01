class JTBDQuestion {
  final String id;
  final String stepTitle;
  final String question;
  final String subtitle;
  final List<JTBDAnswerOption> options;

  const JTBDQuestion({
    required this.id,
    required this.stepTitle,
    required this.question,
    required this.subtitle,
    required this.options,
  });
}

class JTBDAnswerOption {
  final String id;
  final String title;
  final String description;
  final String iconEmoji;

  const JTBDAnswerOption({
    required this.id,
    required this.title,
    required this.description,
    required this.iconEmoji,
  });
}

class JTBDRepository {
  static const List<JTBDQuestion> questions = [
    JTBDQuestion(
      id: 'current_role',
      stepTitle: 'Step 1 of 5 • Background',
      question: 'What is your current professional role?',
      subtitle: 'This tailors your case studies and frameworks.',
      options: [
        JTBDAnswerOption(
          id: 'founder_c_suite',
          title: 'Founder / C-Suite Executive',
          description: 'Leading strategic vision, fundraising & scale.',
          iconEmoji: '🏛️',
        ),
        JTBDAnswerOption(
          id: 'product_tech',
          title: 'Product & Tech Leader',
          description: 'Driving roadmap, metrics & high-output teams.',
          iconEmoji: '⚡',
        ),
        JTBDAnswerOption(
          id: 'growth_marketing',
          title: 'Marketing & Revenue Leader',
          description: 'Scaling acquisition, CAC/LTV & retention.',
          iconEmoji: '📈',
        ),
        JTBDAnswerOption(
          id: 'operator_specialist',
          title: 'Business Operator / Consultant',
          description: 'Optimizing workflows, operations & governance.',
          iconEmoji: '🎯',
        ),
      ],
    ),
    JTBDQuestion(
      id: 'bottleneck',
      stepTitle: 'Step 2 of 5 • Core Challenge',
      question: 'What is your #1 executive bottleneck today?',
      subtitle: 'We will curate mental models that directly solve this.',
      options: [
        JTBDAnswerOption(
          id: 'strategy_clarity',
          title: 'Strategic Prioritization',
          description: 'Too many opportunities; need crisp ruthless focus.',
          iconEmoji: '🧭',
        ),
        JTBDAnswerOption(
          id: 'execution_velocity',
          title: 'Execution & Team Velocity',
          description: 'Bridging the gap between vision and delivered results.',
          iconEmoji: '⚙️',
        ),
        JTBDAnswerOption(
          id: 'unit_economics',
          title: 'Unit Economics & Margins',
          description: 'Strengthening cash runway, pricing power & margins.',
          iconEmoji: '📊',
        ),
        JTBDAnswerOption(
          id: 'talent_alignment',
          title: 'Leadership & Delegation',
          description: 'Getting out of day-to-day firefighting.',
          iconEmoji: '🤝',
        ),
      ],
    ),
    JTBDQuestion(
      id: 'primary_domain',
      stepTitle: 'Step 3 of 5 • Domain Priority',
      question: 'Which domain should dominate your daily feed?',
      subtitle: 'You can change this anytime from your profile.',
      options: [
        JTBDAnswerOption(
          id: 'strategy',
          title: 'Corporate Strategy & Moats',
          description: 'Porter, Christensen, 7 Powers & flywheel design.',
          iconEmoji: '♟️',
        ),
        JTBDAnswerOption(
          id: 'product',
          title: 'Product-Led Growth',
          description: 'Discovery, activation loops, retention metrics.',
          iconEmoji: '💡',
        ),
        JTBDAnswerOption(
          id: 'finance',
          title: 'Finance & Venture Economics',
          description: 'Burn multiple, Rule of 40, capital allocation.',
          iconEmoji: '🏦',
        ),
        JTBDAnswerOption(
          id: 'marketing',
          title: 'Growth Marketing & Brand',
          description: 'Positioning, virality mechanics, category design.',
          iconEmoji: '🚀',
        ),
      ],
    ),
    JTBDQuestion(
      id: 'daily_commitment',
      stepTitle: 'Step 4 of 5 • Learning Cadence',
      question: 'How much time can you invest daily?',
      subtitle: 'Microlearning is optimized for dense 3-5 minute windows.',
      options: [
        JTBDAnswerOption(
          id: '3_mins',
          title: '3 Minutes (The Morning Brief)',
          description: '1 high-signal idea card during coffee or commute.',
          iconEmoji: '☕',
        ),
        JTBDAnswerOption(
          id: '5_mins',
          title: '5 Minutes (1 Interactive Deck)',
          description: '1 complete Primer-style interactive business lesson.',
          iconEmoji: '⏱️',
        ),
        JTBDAnswerOption(
          id: '10_mins',
          title: '10 Minutes (Deep Dive)',
          description: 'Idea card + Primer interactive test + case breakdown.',
          iconEmoji: '🧠',
        ),
      ],
    ),
    JTBDQuestion(
      id: 'primary_goal',
      stepTitle: 'Step 5 of 5 • Desired Outcome',
      question: 'What success looks like 30 days from now?',
      subtitle: 'How you will measure the ROI of this practice.',
      options: [
        JTBDAnswerOption(
          id: 'better_decisions',
          title: 'Sharper Executive Decision Making',
          description: 'Applying proven mental models when stakes are high.',
          iconEmoji: '🏆',
        ),
        JTBDAnswerOption(
          id: 'cross_functional',
          title: 'Fluency Across All Departments',
          description: 'Talking finance with CFOs and tech with engineers.',
          iconEmoji: '🌐',
        ),
        JTBDAnswerOption(
          id: 'team_upskill',
          title: 'Mentoring & Guiding My Team',
          description: 'Sharing actionable cards directly into Slack/meetings.',
          iconEmoji: '📣',
        ),
      ],
    ),
  ];
}
