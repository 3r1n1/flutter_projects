import 'package:flutter/material.dart';

class ArticlesPage extends StatelessWidget {
  const ArticlesPage({super.key});

  final List<Map<String, String>> articles = const [
    {
      "title": "Zhvillimi i Fëmijëve 0-3 vjeç",
      "subtitle": "Njohja, gjuha dhe komunikimi, motorika dhe zhvillimi socio-emocional",
      "content": """Zhvillimi Kognitiv (njohës)
0-12 muaj
• Reagon ndaj zërave dhe fytyrave të njohura.
• Ndjek objektet me sy.
• Fillon të kuptojë shkak-pasojë.
1-2 vjec
• Zgjidh probleme të thjeshta.
2-3 vjec
• Bën lojë funksionale dhe simbolike.""",
      "image": "assets/images/children.jpg"
    },
    {
      "title": "Zhvillimi Motorik",
      "subtitle": "Motorika fine dhe motorika globale",
      "content": """Motorika Fine:
0-12 muaj
• Kap lodra dhe i kalon nga një dorë te tjetra.
1-2 vjec
• Ndërton kullë me 2–4 kube.
2-3 vjec
• Ndërton kullë me 6–8 kube.

Motorika Globale:
0-12 muaj
• Rrotullohet, ulet, zvarritet.
1-2 vjec
• Ecën i vetëm.
2-3 vjec
• Ngjit shkallët me ndihmë.""",
      "image": "assets/images/children2.jpg"
    },
    {
      "title": "Zhvillimi Socio-Emocional",
      "subtitle": "Ndërveprimi dhe emocionet e fëmijëve",
      "content": """0-12 muaj
• Buzëqesh dhe imiton shprehjet.
1-2 vjec
• Luante afër fëmijëve tjerë.
2-3 vjec
• Fillon lojën bashkëpunuese.""",
      "image": "assets/images/children3.jpg"
    },
    {
      "title": "Gjuha dhe Komunikimi",
      "subtitle": "Fjalori dhe formimi i fjalive",
      "content": """0-12 muaj
• Ben gugatje dhe prodhon tinguj si “ba-ba”, “ma-ma”.
1-2 vjec
• Përdor 20–50 fjalë.
2-3 vjec
• Fjalori rritet në 200+ fjalë.
• Formon fjali me 3–4 fjalë.""",
      "image": "assets/images/children4.jpg"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Artikuj & Lajme"),
        backgroundColor: const Color.fromRGBO(101, 241, 194, 1),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: articles.length,
        itemBuilder: (context, index) {
          final article = articles[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: InkWell(
              onTap: () {
                // Open detail page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ArticleDetailPage(article: article),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Article image
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    child: Image.asset(
                      article["image"]!,
                      width: double.infinity,
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          article["title"]!,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          article["subtitle"]!,
                          style: const TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// Detail page to show full content
class ArticleDetailPage extends StatelessWidget {
  final Map<String, String> article;

  const ArticleDetailPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article["title"]!),
        backgroundColor: const Color(0xFF15C3A9),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              article["image"]!,
              width: double.infinity,
              height: 220,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                article["content"]!,
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
