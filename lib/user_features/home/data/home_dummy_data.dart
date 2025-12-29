import '../../doctor_booking/presentation/widgets/doctor_card.dart';
import '../../ai_diagnosis/presentation/widgets/diagnosis_card.dart';

class HomeDummyData {
  static List<DoctorModel> getTopDoctors() {
    return [
      DoctorModel(
        id: '1',
        name: 'د. أحمد محمد السيد',
        specialty: 'أخصائي أمراض جلدية',
        imageUrl: 'https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?w=400&h=400&fit=crop&crop=face',
        rating: 4.9,
        reviewCount: 156,
        hospital: 'مستشفى دار الفؤاد',
        experience: '15 سنة',
        consultationFee: 350,
        isAvailable: true,
      ),
      DoctorModel(
        id: '2',
        name: 'د. سارة عبدالله حسن',
        specialty: 'استشاري جلدية وتجميل',
        imageUrl: 'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?w=400&h=400&fit=crop&crop=face',
        rating: 4.8,
        reviewCount: 203,
        hospital: 'مستشفى السلام الدولي',
        experience: '12 سنة',
        consultationFee: 400,
        isAvailable: true,
      ),
      DoctorModel(
        id: '3',
        name: 'د. محمود علي إبراهيم',
        specialty: 'أخصائي علاج بالليزر',
        imageUrl: 'https://images.unsplash.com/photo-1582750433449-648ed127bb54?w=400&h=400&fit=crop&crop=face',
        rating: 4.7,
        reviewCount: 128,
        hospital: 'مستشفى الأندلسية',
        experience: '10 سنوات',
        consultationFee: 300,
        isAvailable: false,
      ),
    ];
  }

  static List<DiagnosisModel> getRecentDiagnoses() {
    return [
      DiagnosisModel(
        id: '1',
        diseaseName: 'Atopic Dermatitis',
        description:
            'Atopic dermatitis is a chronic inflammatory skin condition characterized by dry, itchy skin and rashes. It is commonly associated with allergies and asthma.',
        imageUrl:
            'https://www.mayoclinic.org/-/media/kcms/gbs/patient-consumer/images/2013/11/15/17/35/ds00986_-ds00987_-ds00674_-ds00821_-ds00842_-ds00843_-ds00844_-ds01047_-ds01060_-ds01122_-ds01145_-my01331_im03450_r7_skinirritthu_jpg.jpg',
        confidence: 0.92,
        diagnosisDate: DateTime.now().subtract(const Duration(days: 2)),
        symptoms: ['Dry skin', 'Itching', 'Redness', 'Rash', 'Scaly patches'],
        treatments: [
          'Moisturizers',
          'Topical corticosteroids',
          'Antihistamines',
          'Avoid triggers',
          'Keep skin hydrated',
        ],
        severity: 'medium',
      ),
      DiagnosisModel(
        id: '2',
        diseaseName: 'Psoriasis',
        description:
            'Psoriasis is a chronic autoimmune condition that causes rapid skin cell growth, resulting in thick, red patches with silvery scales. It can affect various parts of the body.',
        imageUrl:
            'https://www.mayoclinic.org/-/media/kcms/gbs/patient-consumer/images/2013/11/15/17/39/ds00193_-ds00815_-ds01306_-my01137_im03430_psoriasisthu_jpg.jpg',
        confidence: 0.85,
        diagnosisDate: DateTime.now().subtract(const Duration(days: 10)),
        symptoms: [
          'Red patches',
          'Silvery scales',
          'Dry, cracked skin',
          'Itching',
          'Burning sensation',
        ],
        treatments: [
          'Topical treatments',
          'Light therapy',
          'Oral medications',
          'Biologics',
          'Lifestyle changes',
        ],
        severity: 'high',
      ),
    ];
  }
}
