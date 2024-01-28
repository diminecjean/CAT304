class ArticlesModel {
  final int id;
  final String title, caption, image;

  ArticlesModel({
    required this.id,
    required this.title,
    required this.caption,
    required this.image,
  });
}

const List articles = [
  {
    "id": 0,
    "title": "The Art of Autism Exhibition",
    "caption":
        "Experience creativity and talent of individuals on autism spectrum.",
    "image": "assets/images/autisticEvent1.jpeg"
  },
  {
    "id": 1,
    "title": "Parenting a Child on the Autism Spectrum",
    "caption": "Tips for parenting a child on the autism spectrum challenges.",
    "image": "assets/images/autisticEvent2.png",
  },
  {
    "id": 2,
    "title": "Understanding Sensory Processing Disorder",
    "caption":
        "Exploring the challenges and strategies for individuals with sensory processing disorder.",
    "image": "assets/images/autisticEvent3.jpg",
  },
];
