import '../../doctor_booking/presentation/widgets/doctor_card.dart';
import '../../ai_diagnosis/presentation/widgets/diagnosis_card.dart';

class HomeDummyData {
  static List<DoctorModel> getTopDoctors() {
    return [
      DoctorModel(
        id: '1',
        name: 'Dr. Sarah Johnson',
        specialty: 'Dermatologist',
        imageUrl: 'https://randomuser.me/api/portraits/women/44.jpg',
        rating: 4.9,
        reviewCount: 124,
        hospital: 'Mayo Clinic',
        experience: '10 years',
        consultationFee: 120,
        isAvailable: true,
      ),
      DoctorModel(
        id: '2',
        name: 'Dr. Michael Chen',
        specialty: 'Dermatologist',
        imageUrl: 'https://randomuser.me/api/portraits/men/46.jpg',
        rating: 4.8,
        reviewCount: 98,
        hospital: 'Cleveland Clinic',
        experience: '8 years',
        consultationFee: 100,
        isAvailable: true,
      ),
      DoctorModel(
        id: '3',
        name: 'Dr. Emily Rodriguez',
        specialty: 'Dermatologist',
        imageUrl: 'https://randomuser.me/api/portraits/women/65.jpg',
        rating: 4.7,
        reviewCount: 87,
        hospital: 'Johns Hopkins Hospital',
        experience: '12 years',
        consultationFee: 150,
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
