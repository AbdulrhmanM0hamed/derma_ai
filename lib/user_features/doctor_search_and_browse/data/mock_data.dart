class MockDoctorData {
  static List<Map<String, dynamic>> getDoctors() {
    return [
      {
        "id": 1,
        "nameArabic": "د. أحمد محمد الشريف",
        "nameEnglish": "Dr. Ahmed Mohammed Al-Sharif",
        "specialtyArabic": "أمراض جلدية وتناسلية",
        "profileImage":
            "https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?w=400&h=400&fit=crop&crop=face",
        "rating": 4.8,
        "reviewCount": 127,
        "distance": 2.3,
        "nextAvailable": "اليوم 3:30 م",
        "consultationFee": "250 ريال",
        "isFavorite": false,
      },
      {
        "id": 2,
        "nameArabic": "د. فاطمة علي الزهراني",
        "nameEnglish": "Dr. Fatima Ali Al-Zahrani",
        "specialtyArabic": "جراحة تجميلية وترميمية",
        "profileImage":
            "https://images.unsplash.com/photo-1559839734-2b71ea197ec2?w=400&h=400&fit=crop&crop=face",
        "rating": 4.9,
        "reviewCount": 203,
        "distance": 1.8,
        "nextAvailable": "غداً 10:00 ص",
        "consultationFee": "400 ريال",
        "isFavorite": true,
      },
      {
        "id": 3,
        "nameArabic": "د. محمد عبدالله القحطاني",
        "nameEnglish": "Dr. Mohammed Abdullah Al-Qahtani",
        "specialtyArabic": "أمراض الشعر والصلع",
        "profileImage":
            "https://images.unsplash.com/photo-1582750433449-648ed127bb54?w=400&h=400&fit=crop&crop=face",
        "rating": 4.7,
        "reviewCount": 89,
        "distance": 4.1,
        "nextAvailable": "الأحد 2:00 م",
        "consultationFee": "300 ريال",
        "isFavorite": false,
      },
      {
        "id": 4,
        "nameArabic": "د. سارة خالد المطيري",
        "nameEnglish": "Dr. Sarah Khalid Al-Mutairi",
        "specialtyArabic": "الأمراض الجلدية للأطفال",
        "profileImage":
            "https://images.unsplash.com/photo-1594824475317-1ad8b1b9c9e1?w=400&h=400&fit=crop&crop=face",
        "rating": 4.6,
        "reviewCount": 156,
        "distance": 3.7,
        "nextAvailable": "الثلاثاء 11:30 ص",
        "consultationFee": "200 ريال",
        "isFavorite": false,
      },
      {
        "id": 5,
        "nameArabic": "د. عبدالرحمن سعد العتيبي",
        "nameEnglish": "Dr. Abdulrahman Saad Al-Otaibi",
        "specialtyArabic": "علاج بالليزر والتقشير",
        "profileImage":
            "https://images.unsplash.com/photo-1607990281513-2c110a25bd8c?w=400&h=400&fit=crop&crop=face",
        "rating": 4.5,
        "reviewCount": 94,
        "distance": 5.2,
        "nextAvailable": "الخميس 4:00 م",
        "consultationFee": "350 ريال",
        "isFavorite": false,
      },
    ];
  }
}
