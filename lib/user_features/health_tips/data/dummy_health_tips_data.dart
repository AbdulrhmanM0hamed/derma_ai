class Article {
  final String title;
  final String source;
  final String imageUrl;

  const Article({
    required this.title,
    required this.source,
    required this.imageUrl,
  });
}

class DiseaseInfo {
  final String name;
  final String description;
  final String imageUrl;

  const DiseaseInfo({
    required this.name,
    required this.description,
    required this.imageUrl,
  });
}

final List<Article> dummyArticles = [
  const Article(
    title: 'أهمية واقي الشمس اليومي لصحة بشرتك',
    source: 'منظمة الصحة العالمية',
    imageUrl: 'assets/images/sunscreen.png', // Placeholder
  ),
  const Article(
    title: 'كيفية التعامل مع حب الشباب بفعالية',
    source: 'الأكاديمية الأمريكية للأمراض الجلدية',
    imageUrl: 'assets/images/acne.png', // Placeholder
  ),
  const Article(
    title: 'الترطيب: مفتاح البشرة النضرة والشابة',
    source: 'موقع WebMD الطبي',
    imageUrl: 'assets/images/moisturizer.png', // Placeholder
  ),
];

final List<DiseaseInfo> dummyDiseases = [
  const DiseaseInfo(
    name: 'الإكزيما (التهاب الجلد التأتبي)',
    description: 'حالة تسبب جفاف الجلد، الحكة والالتهاب. تتطلب ترطيبًا مستمرًا وعلاجات موضعية.',
    imageUrl: 'assets/images/eczema.png', // Placeholder
  ),
  const DiseaseInfo(
    name: 'الصدفية',
    description: 'مرض مناعي ذاتي يسبب تراكم سريع لخلايا الجلد، مما يؤدي إلى ظهور بقع سميكة ومتقشرة.',
    imageUrl: 'assets/images/psoriasis.png', // Placeholder
  ),
];
