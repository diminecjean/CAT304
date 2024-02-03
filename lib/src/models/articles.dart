class ArticlesModel {
  final int id;
  final String title, caption, image, url;

  ArticlesModel({
    required this.id,
    required this.title,
    required this.caption,
    required this.image,
    required this.url,
  });
}

const List articles = [
  {
    "id": 0,
    "title": "The Art of Autism Exhibition",
    "caption":
        "Experience creativity and talent of individuals on autism spectrum.",
    "image": "assets/images/autisticEvent1.jpeg",
    "url": "https://the-art-of-autism.com/",
  },
  {
    "id": 1,
    "title": "Parenting a Child on the Autism Spectrum",
    "caption": "Tips for parenting a child on the autism spectrum challenges.",
    "image": "assets/images/autisticEvent2.png",
    "url":
        "https://www.helpguide.org/articles/autism-learning-disabilities/parenting-a-child-with-autism.htm",
  },
  {
    "id": 2,
    "title": "Understanding Sensory Processing Disorder",
    "caption":
        "Exploring challenges and strategies for individuals with sensory processing disorder.",
    "image": "assets/images/autisticEvent3.jpg",
    "url":
        "https://www.understood.org/en/learning-thinking-differences/child-learning-disabilities/sensory-processing-issues/understanding-sensory-processing-issues",
  },
];
