import 'models/lesson_models.dart';

class MockLessonsRepository {
  static final List<Lesson> lessons = [
    const Lesson(
      lessonId: 'lesson_koneksi_koreksi',
      title: 'Koneksi Sebelum Koreksi & Bahasa Hati Tantrum',
      subtitle: 'Menuntun emosi ananda sebelum menuntut logika atau ketertiban adab.',
      domain: 'Praktik Keluarga',
      estimatedMinutes: 4,
      cards: [
        TextInsightCard(
          id: 'kk_1',
          stepHeadline: 'Hukum Otak Limbik & Bahasa Hati',
          contentMarkdown:
              'Saat balita mengalami tantrum atau menangis berguling, pusat emosional (*otak limbik*) sedang membajak nalar rasionalnya.\n\nMemberikan ceramah atau membentak anak di puncak amarah justru memperpanjang amigdala panik. **Koneksi batin** melahirkan kepatuhan fitrah, sedangkan bentakan hanya menciptakan kepatuhan semu karena takut.',
          keyTakeaway:
              'Sentuh hati sebelum menuntut logika. Hadirkan ketenangan fisik sebelum memberi arahan adab.',
        ),
        SwipePollCard(
          id: 'kk_2',
          stepHeadline: 'Uji Intuisi: Menasihati Saat Tantrum',
          statement:
              'Apakah mendebat logika anak balita saat ia sedang menjerit di lantai merupakan tindakan yang efektif?',
          agreeFeedback:
              'Kurang tepat! Saat tantrum memuncak, telinga batin anak tertutup. Peluk dan tenangkan terlebih dahulu hingga nafasnya stabil.',
          disagreeFeedback:
              'Tepat sekali! Menasihati saat anak kalap adalah pemborosan energi. Validasi emosi dulu, baru dialogkan saat ia tenang.',
        ),
        MultipleChoiceCard(
          id: 'kk_3',
          stepHeadline: 'Studi Kasus: Piring Terlempar',
          question: 'Ketika balita 3 tahun melempar piring saat makan, respon awal apa yang paling sesuai adab nabawiyah?',
          options: [
            'Membalas dengan bentakan keras agar ia jera seketika',
            'Duduk sejajar mata, tahan tangan dengan lembut, dan katakan: "Piring tempat makan, bukan dilempar"',
            'Mengurung anak di dalam kamar sendirian',
            'Mengancam dengan siksa neraka agar anak takut',
          ],
          correctIndex: 1,
          explanation:
              'Menahan tangan dengan lembut mencegah bahaya fisik tanpa melukai martabat anak. Bahasa tenang dan pandangan mata sejajar menyalurkan rasa aman batin.',
        ),
        FillInBlankCard(
          id: 'kk_4',
          stepHeadline: 'Sintesis Kaidah Manhaj',
          sentenceBefore: 'Dalam pengasuhan balita sebelum usia 7 tahun, larangan keras syar\'i adalah memberikan',
          blankExpected: 'Sanksi Fisik',
          sentenceAfter: ', karena fase ini berlandaskan kasih sayang, keteladanan, dan bermain riang.',
          wordBank: [
            'Pujian Tulus',
            'Sanksi Fisik',
            'Pelukan Hangat',
            'Hadiah Buah',
          ],
          explanation:
              'Syariat melarang sanksi fisik pada anak thufulah (di bawah 7 tahun). Teladan fisik orang tua (Bahasa Tangan) adalah kurikulum terbaik.',
        ),
        TextInsightCard(
          id: 'kk_5',
          stepHeadline: 'Teladan Sirah & Do\'a Refleksi',
          contentMarkdown:
              'Rasulullah ﷺ tidak pernah membentak anak kecil. Ketika cucu beliau Hasan dan Husain menaiki punggungnya saat sujud, beliau memperpanjang sujudnya dengan penuh cinta hingga anak merasa puas bermain.\n\n*Do\'a Penenteram Jiwa Keluarga:*\nرَبَّنَا هَبْ لَنَا مِنْ أَزْوَاجِنَا وَذُرِّيَّاتِنَا قُرَّةَ أَعْيُنٍ وَاجْعَلْنَا لِلْمُتَّقِينَ إِمَامًا',
          keyTakeaway:
              'Kelembutan Nabi ﷺ kepada anak adalah barometer kematangan iman seorang pendidik.',
        ),
      ],
    ),
    const Lesson(
      lessonId: 'lesson_disiplin_shalat',
      title: 'Disiplin Shalat Tamyiz: Batas Usia 7 vs 10 Tahun',
      subtitle: 'Memahami rambu syar\'i antara pembiasaan gembira dan sanksi mendidik.',
      domain: 'Fase Tumbuh Kembang',
      estimatedMinutes: 5,
      cards: [
        TextInsightCard(
          id: 'ds_1',
          stepHeadline: 'Dua Fase Hadits Shalat',
          contentMarkdown:
              'Rasulullah ﷺ bersabda:\n*"Perintahkan anak-anakmu shalat ketika berusia 7 tahun, dan pukullah mereka (bila membangkang) pada usia 10 tahun, serta pisahkan tempat tidurnya."* (HR. Abu Dawud No. 495)\n\nRentang usia **7 hingga 10 tahun (3 tahun penuh = ~5.400 kali waktu shalat)** adalah masa pembiasaan gembira tanpa sanksi fisik apapun.',
          keyTakeaway:
              'Jangan terburu-buru menghukum anak 7–9 tahun. Beri 5.400 kesempatan teladan gembira sebelum usia 10 tahun.',
        ),
        SwipePollCard(
          id: 'ds_2',
          stepHeadline: 'Uji Batas Toleransi Syar\'i',
          statement:
              'Bolehkah memberikan hukuman fisik ringan pada anak usia 8 tahun yang terlambat bangun shalat Subuh?',
          agreeFeedback:
              'Kurang tepat! Anak usia 8 tahun masih berada dalam fase pembiasaan tamyiz. Hadits menetapkan sanksi fisik hanya setelah genap usia 10 tahun.',
          disagreeFeedback:
              'Tepat sekali! Usia 7–9 tahun diisi dengan keteladanan wudhu bersama, sentuhan lembut, dan pujian atas proses shalat.',
        ),
        MultipleChoiceCard(
          id: 'ds_3',
          stepHeadline: 'Kaidah Sanksi Mendidik Usia 10+',
          question: 'Jika anak genap berusia 10 tahun membangkang shalat, apa batas syar\'i sanksi fisik yang diizinkan?',
          options: [
            'Boleh memukul wajah dengan keras agar jeranya terasa mendalam',
            'Pukulan mendidik tidak boleh melukai, tidak meninggalkan bekas, dan mutlak haram memukul wajah',
            'Sanksi diserahkan sepenuhnya tanpa batasan syariat',
            'Cukup dicela di depan umum bersama teman-temannya',
          ],
          correctIndex: 1,
          explanation:
              'Haram memukul wajah atau anggota tubuh berbahaya. Pukulan mendidik dalam Islam bersifat simbolis ketegasan (*ghairu mubarrih*), bukan luapan amarah balas dendam.',
        ),
        FillInBlankCard(
          id: 'ds_4',
          stepHeadline: 'Karakteristik Tamyiz',
          sentenceBefore: 'Fase usia 7–10 tahun dinamakan tamyiz karena anak mulai mampu membedakan',
          blankExpected: 'Baik dan Buruk',
          sentenceAfter: ', sehingga nalar logikanya mulai siap menerima tanggung jawab tertib adab.',
          wordBank: [
            'Kaya dan Miskin',
            'Baik dan Buruk',
            'Kawan dan Lawan',
            'Sakit dan Sehat',
          ],
          explanation:
              'Tamyiz adalah tonggak kematangan akal awal sebelum anak menanggung beban taklif penuh saat baligh nanti.',
        ),
        TextInsightCard(
          id: 'ds_5',
          stepHeadline: 'Do\'a Peneguh Shalat Nabi Ibrahim',
          contentMarkdown:
              'Nabi Ibrahim AS tidak hanya berdoa agar dirinya shalat, melainkan memohon keberlangsungan generasi penjaga shalat:\n\nرَبِّ اجْعَلْنِي مُقِيمَ الصَّلَاةِ وَمِن ذُرِّيَّتِي ۚ رَبَّنَا وَتَقَبَّلْ دُعَاءِ\n*"Ya Tuhanku, jadikanlah aku dan anak cucuku orang-orang yang tetap mendirikan shalat, ya Tuhan kami, perkenankanlah do\'aku."* (QS. Ibrahim: 40)',
          keyTakeaway:
              'Shalat anak adalah buah dari keshalihan dan do\'a istiqamah kedua orang tuanya.',
        ),
      ],
    ),
    const Lesson(
      lessonId: 'lesson_tafsir_bakat_tb40',
      title: 'Tafsir Bakat TB-40: Menemukan Syakilah & Keunikan Fitrah',
      subtitle: 'Memahami 40 pilar bakat ciptaan Allah untuk orientasi peran kontribusi.',
      domain: 'Fitrah & Bakat',
      estimatedMinutes: 5,
      cards: [
        TextInsightCard(
          id: 'tb_1',
          stepHeadline: 'Ayat Syakilah & Keberagaman Fitrah',
          contentMarkdown:
              'Allah Subhanahu wa Ta\'ala berfirman:\nقُلْ كُلٌّ يَعْمَلُ عَلَىٰ شَاكِلَتِهِ\n*"Katakanlah: Setiap orang berbuat menurut keadaannya (pembawaan fitrah dan potensinya) masing-masing."* (QS. Al-Isra: 84)\n\nBakat bukanlah sekadar keahlian teknis modern, melainkan **susunan fitrah ciptaan Allah** yang menjadi bekal unik bagi tiap hamba untuk mengabdi di muka bumi.',
          keyTakeaway:
              'Tidak ada anak yang "kosong bakat". Setiap anak memiliki syakilah unik yang Allah rancang untuk peran peradaban tertentu.',
        ),
        SwipePollCard(
          id: 'tb_2',
          stepHeadline: 'Uji Paradigma: Ekstrovert vs Introvert',
          statement:
              'Apakah anak yang pendiam dan pemikir mendalam (As-Sirr / Tafakkur) harus dipaksa berubah menjadi ekstrovert yang selalu tampil di panggung?',
          agreeFeedback:
              'Kurang tepat! Karakter pemikir mendalam memiliki kemuliaan tersendiri (seperti Abu Dzar dan Salman Al-Farisi). Memaksa anak melompati fitrahnya memicu luka batin.',
          disagreeFeedback:
              'Tepat sekali! Menghargai fitrah introvert membantu anak menemukan keahlian analisa, kejujuran, dan perenungan dalil yang tajam.',
        ),
        MultipleChoiceCard(
          id: 'tb_3',
          stepHeadline: 'Rukun 3A Pemetaan Bakat',
          question: 'Apa saja 3 rukun utama dalam pemetaan bakat TB-40 Nabawiyah?',
          options: [
            'Nilai Raport Tinggi, Juara Kelas, dan Ijazah Bergengsi',
            'Suka (Raghibah), Bisa (Qudrah), dan Bermanfaat (Naf\'ah)',
            'Gaji Tinggi, Karier Cepat, dan Popularitas Media Sosial',
            'Kepatuhan Buta, Hafalan Cepat, dan Ketakutan pada Guru',
          ],
          correctIndex: 1,
          explanation:
              'Rukun 3A: Raghibah (anak mencintai aktivitasnya), Qudrah (anak menguasainya dengan mudah), dan Naf\'ah (aktivitas itu memberi maslahat nyata bagi sesama).',
        ),
        FillInBlankCard(
          id: 'tb_4',
          stepHeadline: 'Orientasi Bakat',
          sentenceBefore: 'Tujuan pemetaan bakat TB-40 bukanlah membandingkan peringkat antar anak, melainkan menemukan peran',
          blankExpected: 'Kontribusi',
          sentenceAfter: ' terbaik yang Allah titipkan pada masing-masing pribadi insan.',
          wordBank: [
            'Kompetisi',
            'Kontribusi',
            'Gengsi',
            'Popularitas',
          ],
          explanation:
              'Fitrah-first: setiap anak dihargai atas keunikan ciptaan Allah tanpa budaya peringkat angka mati.',
        ),
        TextInsightCard(
          id: 'tb_5',
          stepHeadline: 'Refleksi Akhlak Bakat',
          contentMarkdown:
              'Bakat yang tidak diikat oleh adab dan iman akan melahirkan kesombongan (*Ujub*).\n\nSebaliknya, bakat yang disyukuri dan diasah dalam ketaatan akan menjadi jalan amal jariyah yang menerangi dunia dan akhirat.\n\n*Apresiasi proses ananda hari ini dan catat 1 aktivitas yang membuatnya berbinar gembira!*',
          keyTakeaway:
              'Bakat adalah amanah kontribusi. Adab adalah pagar keselamatan bagi bakat.',
        ),
      ],
    ),
  ];
}
