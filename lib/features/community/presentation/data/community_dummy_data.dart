import 'package:derma_ai/features/community/presentation/data/models/post_model.dart';
import 'package:derma_ai/features/community/presentation/data/models/comment_model.dart';
import 'package:derma_ai/features/community/presentation/data/models/doctor_profile_model.dart';

class CommunityDummyData {
  static List<DoctorProfileModel> getDoctors() {
    return [
      DoctorProfileModel(
        id: '1',
        name: 'د. أحمد محمد',
        specialization: 'طبيب جلدية',
        avatar: 'https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?w=150',
        isVerified: true,
        yearsOfExperience: 15,
        rating: 4.9,
        followers: 12500,
      ),
      DoctorProfileModel(
        id: '2',
        name: 'د. فاطمة علي',
        specialization: 'استشارية الأمراض الجلدية',
        avatar: 'https://images.unsplash.com/photo-1594824475317-d5b2c0d1b5e8?w=150',
        isVerified: true,
        yearsOfExperience: 12,
        rating: 4.8,
        followers: 9800,
      ),
      DoctorProfileModel(
        id: '3',
        name: 'د. محمد حسن',
        specialization: 'طبيب تجميل وجلدية',
        avatar: 'https://images.unsplash.com/photo-1582750433449-648ed127bb54?w=150',
        isVerified: true,
        yearsOfExperience: 10,
        rating: 4.7,
        followers: 8200,
      ),
      DoctorProfileModel(
        id: '4',
        name: 'د. سارة أحمد',
        specialization: 'طبيبة جلدية وتناسلية',
        avatar: 'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?w=150',
        isVerified: true,
        yearsOfExperience: 8,
        rating: 4.9,
        followers: 15600,
      ),
    ];
  }

  static List<PostModel> getPosts() {
    final doctors = getDoctors();
    return [
      PostModel(
        id: '1',
        doctor: doctors[0],
        content: '''🌟 نصائح مهمة للعناية بالبشرة في فصل الشتاء

مع دخول فصل الشتاء، تحتاج بشرتنا لعناية خاصة لحمايتها من الجفاف والتشقق:

✅ استخدم مرطب غني بالزيوت الطبيعية
✅ تجنب الاستحمام بالماء الساخن جداً
✅ اشرب كمية كافية من الماء يومياً
✅ استخدم واقي الشمس حتى في الأيام الغائمة

#العناية_بالبشرة #نصائح_طبية #الشتاء''',
        imageUrl: 'https://images.unsplash.com/photo-1556228720-195a672e8a03?w=400',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        likes: 245,
        comments: getCommentsForPost('1'),
        shares: 18,
        isLiked: false,
        tags: ['العناية_بالبشرة', 'نصائح_طبية', 'الشتاء'],
      ),
      PostModel(
        id: '2',
        doctor: doctors[1],
        content: '''🚨 تحذير مهم: علامات يجب عدم تجاهلها

إذا لاحظت أي من هذه العلامات على بشرتك، يجب استشارة طبيب فوراً:

🔴 تغير في لون أو شكل الشامات
🔴 جروح لا تلتئم خلال أسبوعين
🔴 حكة مستمرة مع طفح جلدي
🔴 تورم غير مبرر في الجلد

الكشف المبكر ينقذ الأرواح! 💙

#الوقاية #الكشف_المبكر #صحة_الجلد''',
        imageUrl: 'https://images.unsplash.com/photo-1576091160399-112ba8d25d1f?w=400',
        timestamp: DateTime.now().subtract(const Duration(hours: 5)),
        likes: 189,
        comments: getCommentsForPost('2'),
        shares: 32,
        isLiked: true,
        tags: ['الوقاية', 'الكشف_المبكر', 'صحة_الجلد'],
      ),
      PostModel(
        id: '3',
        doctor: doctors[2],
        content: '''✨ روتين العناية اليومي للبشرة الدهنية

للحصول على بشرة صحية ونضرة، اتبع هذا الروتين:

🌅 الصباح:
• غسول لطيف للوجه
• تونر خالي من الكحول
• سيروم فيتامين C
• مرطب خفيف
• واقي شمس SPF 30+

🌙 المساء:
• إزالة المكياج
• غسول عميق
• تونر
• كريم ليلي مرطب

#البشرة_الدهنية #روتين_العناية #نصائح_جمال''',
        imageUrl: 'https://images.unsplash.com/photo-1570172619644-dfd03ed5d881?w=400',
        timestamp: DateTime.now().subtract(const Duration(hours: 8)),
        likes: 312,
        comments: getCommentsForPost('3'),
        shares: 45,
        isLiked: false,
        tags: ['البشرة_الدهنية', 'روتين_العناية', 'نصائح_جمال'],
      ),
      PostModel(
        id: '4',
        doctor: doctors[3],
        content: '''🤰 العناية بالبشرة أثناء الحمل

تحتاج البشرة لعناية خاصة خلال فترة الحمل:

💡 نصائح مهمة:
• تجنبي المنتجات التي تحتوي على الريتينول
• استخدمي واقي شمس طبيعي
• اشربي الماء بكثرة
• تجنبي التقشير القوي

⚠️ استشيري طبيبك قبل استخدام أي منتج جديد

#الحمل #العناية_بالبشرة #صحة_الأم''',
        imageUrl: 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=400',
        timestamp: DateTime.now().subtract(const Duration(hours: 12)),
        likes: 156,
        comments: getCommentsForPost('4'),
        shares: 23,
        isLiked: true,
        tags: ['الحمل', 'العناية_بالبشرة', 'صحة_الأم'],
      ),
      PostModel(
        id: '5',
        doctor: doctors[0],
        content: '''🍎 الغذاء وصحة البشرة

ما تأكله ينعكس على بشرتك! إليك أفضل الأطعمة:

🥑 الأفوكادو - غني بالأوميجا 3
🐟 السمك - يحتوي على البروتين والزيوت المفيدة
🥕 الجزر - مصدر ممتاز لفيتامين A
🍓 التوت - مضادات الأكسدة الطبيعية
🥬 الخضروات الورقية - فيتامينات ومعادن

تذكر: البشرة الصحية تبدأ من الداخل! 💪

#التغذية #صحة_البشرة #فيتامينات''',
        imageUrl: 'https://images.unsplash.com/photo-1490645935967-10de6ba17061?w=400',
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
        likes: 278,
        comments: getCommentsForPost('5'),
        shares: 41,
        isLiked: false,
        tags: ['التغذية', 'صحة_البشرة', 'فيتامينات'],
      ),
    ];
  }

  static List<CommentModel> getCommentsForPost(String postId) {
    switch (postId) {
      case '1':
        return [
          CommentModel(
            id: '1_1',
            userName: 'أحمد محمود',
            userAvatar: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=50',
            content: 'نصائح رائعة دكتور! بشرتي تحسنت كثيراً بعد اتباع هذه النصائح 🙏',
            timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
            likes: 12,
            isLiked: true,
            replies: [
              CommentModel(
                id: '1_1_1',
                userName: 'د. أحمد محمد',
                userAvatar: 'https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?w=50',
                content: 'أشكرك على المتابعة! من المهم الاستمرار على الروتين للحصول على أفضل النتائج 👨‍⚕️',
                timestamp: DateTime.now().subtract(const Duration(minutes: 25)),
                likes: 8,
                isLiked: false,
                parentId: '1_1',
                isDoctor: true,
                doctorSpecialization: 'طبيب جلدية',
              ),
            ],
          ),
          CommentModel(
            id: '1_2',
            userName: 'فاطمة أحمد',
            userAvatar: 'https://images.unsplash.com/photo-1494790108755-2616b612b786?w=50',
            content: 'هل يمكن استخدام زيت الأرجان كمرطب طبيعي؟',
            timestamp: DateTime.now().subtract(const Duration(minutes: 45)),
            likes: 5,
            isLiked: false,
            replies: [
              CommentModel(
                id: '1_2_1',
                userName: 'د. أحمد محمد',
                userAvatar: 'https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?w=50',
                content: 'نعم، زيت الأرجان ممتاز للبشرة الجافة. استخدميه في المساء بعد تنظيف الوجه 🌿',
                timestamp: DateTime.now().subtract(const Duration(minutes: 40)),
                likes: 15,
                isLiked: true,
                parentId: '1_2',
                isDoctor: true,
                doctorSpecialization: 'طبيب جلدية',
              ),
              CommentModel(
                id: '1_2_2',
                userName: 'فاطمة أحمد',
                userAvatar: 'https://images.unsplash.com/photo-1494790108755-2616b612b786?w=50',
                content: 'شكراً دكتور! سأجربه الليلة 😊',
                timestamp: DateTime.now().subtract(const Duration(minutes: 35)),
                likes: 3,
                isLiked: false,
                parentId: '1_2',
              ),
            ],
          ),
          CommentModel(
            id: '1_3',
            userName: 'محمد علي',
            userAvatar: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=50',
            content: 'شكراً على المعلومات المفيدة 👍',
            timestamp: DateTime.now().subtract(const Duration(hours: 1)),
            likes: 8,
            isLiked: false,
          ),
        ];
      case '2':
        return [
          CommentModel(
            id: '2_1',
            userName: 'سارة محمد',
            userAvatar: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=50',
            content: 'معلومات مهمة جداً! يجب على الجميع قراءة هذا',
            timestamp: DateTime.now().subtract(const Duration(minutes: 20)),
            likes: 15,
            isLiked: true,
            replies: [
              CommentModel(
                id: '2_1_1',
                userName: 'د. فاطمة علي',
                userAvatar: 'https://images.unsplash.com/photo-1594824475317-d5b2c0d1b5e8?w=50',
                content: 'شكراً لك! الوعي بهذه العلامات ينقذ الأرواح فعلاً 🩺',
                timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
                likes: 22,
                isLiked: true,
                parentId: '2_1',
                isDoctor: true,
                doctorSpecialization: 'استشارية الأمراض الجلدية',
              ),
            ],
          ),
          CommentModel(
            id: '2_2',
            userName: 'خالد حسن',
            userAvatar: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=50',
            content: 'لاحظت تغير في شامة عندي، هل يجب أن أقلق؟',
            timestamp: DateTime.now().subtract(const Duration(minutes: 35)),
            likes: 3,
            isLiked: false,
            replies: [
              CommentModel(
                id: '2_2_1',
                userName: 'د. فاطمة علي',
                userAvatar: 'https://images.unsplash.com/photo-1594824475317-d5b2c0d1b5e8?w=50',
                content: '⚠️ يجب عليك مراجعة طبيب جلدية فوراً! أي تغيير في الشامات يحتاج فحص طبي',
                timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
                likes: 18,
                isLiked: true,
                parentId: '2_2',
                isDoctor: true,
                doctorSpecialization: 'استشارية الأمراض الجلدية',
              ),
              CommentModel(
                id: '2_2_2',
                userName: 'خالد حسن',
                userAvatar: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=50',
                content: 'شكراً دكتورة، سأحجز موعد غداً إن شاء الله',
                timestamp: DateTime.now().subtract(const Duration(minutes: 25)),
                likes: 5,
                isLiked: false,
                parentId: '2_2',
              ),
            ],
          ),
        ];
      case '3':
        return [
          CommentModel(
            id: '3_1',
            userName: 'نور الدين',
            userAvatar: 'https://images.unsplash.com/photo-1507591064344-4c6ce005b128?w=50',
            content: 'روتين ممتاز! بدأت أطبقه من أسبوع والنتائج واضحة',
            timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
            likes: 9,
            isLiked: true,
            replies: [
              CommentModel(
                id: '3_1_1',
                userName: 'د. محمد حسن',
                userAvatar: 'https://images.unsplash.com/photo-1582750433449-648ed127bb54?w=50',
                content: 'ممتاز! الاستمرارية هي المفتاح. ستلاحظ تحسن أكبر خلال شهر 💪',
                timestamp: DateTime.now().subtract(const Duration(minutes: 10)),
                likes: 12,
                isLiked: false,
                parentId: '3_1',
                isDoctor: true,
                doctorSpecialization: 'طبيب تجميل وجلدية',
              ),
            ],
          ),
          CommentModel(
            id: '3_2',
            userName: 'ليلى أحمد',
            userAvatar: 'https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?w=50',
            content: 'ما هو أفضل نوع تونر للبشرة الدهنية؟',
            timestamp: DateTime.now().subtract(const Duration(minutes: 40)),
            likes: 6,
            isLiked: false,
            replies: [
              CommentModel(
                id: '3_2_1',
                userName: 'د. محمد حسن',
                userAvatar: 'https://images.unsplash.com/photo-1582750433449-648ed127bb54?w=50',
                content: 'أنصح بتونر يحتوي على حمض الساليسيليك أو النياسيناميد للبشرة الدهنية 🧴',
                timestamp: DateTime.now().subtract(const Duration(minutes: 35)),
                likes: 14,
                isLiked: true,
                parentId: '3_2',
                isDoctor: true,
                doctorSpecialization: 'طبيب تجميل وجلدية',
              ),
            ],
          ),
        ];
      case '4':
        return [
          CommentModel(
            id: '4_1',
            userName: 'مريم سالم',
            userAvatar: 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=50',
            content: 'معلومات قيمة جداً للحوامل، شكراً دكتورة 💕',
            timestamp: DateTime.now().subtract(const Duration(minutes: 25)),
            likes: 11,
            isLiked: true,
            replies: [
              CommentModel(
                id: '4_1_1',
                userName: 'د. سارة أحمد',
                userAvatar: 'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?w=50',
                content: 'العفو حبيبتي! صحتك وصحة طفلك أهم شيء. لا تترددي في السؤال 🤱',
                timestamp: DateTime.now().subtract(const Duration(minutes: 20)),
                likes: 16,
                isLiked: true,
                parentId: '4_1',
                isDoctor: true,
                doctorSpecialization: 'طبيبة جلدية وتناسلية',
              ),
            ],
          ),
        ];
      case '5':
        return [
          CommentModel(
            id: '5_1',
            userName: 'عبدالله محمد',
            userAvatar: 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=50',
            content: 'فعلاً الغذاء الصحي يظهر على البشرة! 💪',
            timestamp: DateTime.now().subtract(const Duration(minutes: 10)),
            likes: 7,
            isLiked: false,
            replies: [
              CommentModel(
                id: '5_1_1',
                userName: 'د. أحمد محمد',
                userAvatar: 'https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?w=50',
                content: 'تماماً! البشرة مرآة الصحة الداخلية. استمر على النظام الصحي 🥗',
                timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
                likes: 9,
                isLiked: false,
                parentId: '5_1',
                isDoctor: true,
                doctorSpecialization: 'طبيب جلدية',
              ),
            ],
          ),
          CommentModel(
            id: '5_2',
            userName: 'هدى علي',
            userAvatar: 'https://images.unsplash.com/photo-1489424731084-a5d8b219a5bb?w=50',
            content: 'هل يمكن إضافة المكسرات للقائمة؟',
            timestamp: DateTime.now().subtract(const Duration(minutes: 50)),
            likes: 4,
            isLiked: false,
            replies: [
              CommentModel(
                id: '5_2_1',
                userName: 'د. أحمد محمد',
                userAvatar: 'https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?w=50',
                content: 'بالطبع! اللوز والجوز غنيان بفيتامين E المفيد للبشرة 🥜',
                timestamp: DateTime.now().subtract(const Duration(minutes: 45)),
                likes: 11,
                isLiked: true,
                parentId: '5_2',
                isDoctor: true,
                doctorSpecialization: 'طبيب جلدية',
              ),
              CommentModel(
                id: '5_2_2',
                userName: 'هدى علي',
                userAvatar: 'https://images.unsplash.com/photo-1489424731084-a5d8b219a5bb?w=50',
                content: 'شكراً دكتور! سأضيفها لنظامي الغذائي 😊',
                timestamp: DateTime.now().subtract(const Duration(minutes: 40)),
                likes: 2,
                isLiked: false,
                parentId: '5_2',
              ),
            ],
          ),
        ];
      default:
        return [];
    }
  }

  static List<String> getTrendingHashtags() {
    return [
      'العناية_بالبشرة',
      'نصائح_طبية',
      'صحة_الجلد',
      'الوقاية',
      'روتين_العناية',
      'البشرة_الدهنية',
      'البشرة_الجافة',
      'مكافحة_الشيخوخة',
      'واقي_الشمس',
      'التغذية_الصحية',
    ];
  }
}
