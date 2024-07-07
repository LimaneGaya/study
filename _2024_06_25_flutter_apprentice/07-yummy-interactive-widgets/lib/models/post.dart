class Post {
  String id;
  String profileImageUrl;
  String comment;
  String timestamp;

  Post(
    this.id,
    this.profileImageUrl,
    this.comment,
    this.timestamp,
  );
}

List<Post> posts = [
  Post(
    '1',
    'assets/profile_pics/person_cesare.webp',
    'Made this delicious pizza this morning',
    '10',
  ),
  Post(
    '2',
    'assets/profile_pics/person_stef.webp',
    'Made delicious creamy, shrimp black pepper pasta.',
    '80',
  ),
  Post(
    '3',
    'assets/profile_pics/person_crispy.webp',
    'Made a delicious salad today!',
    '20',
  ),
  Post(
    '4',
    'assets/profile_pics/person_joe.webp',
    'Cooked a widget this morning.',
    '30',
  ),
  Post(
    '5',
    'assets/profile_pics/person_katz.webp',
    '''Going to power through my day with this nutty smoothie to finish up Flutter apprentice for our readers!''',
    '40',
  ),
  Post(
    '6',
    'assets/profile_pics/person_kevin.webp',
    '''Cooking up some steak 🥩 today, state should be rare, medium or medium well?''',
    '50',
  ),
  Post(
    '7',
    'assets/profile_pics/person_sandra.webp',
    '''Kicking off the morning with mike's green smoothie recipe. Time to edit these chapters!''',
    '50',
  ),
  Post(
    '8',
    'assets/profile_pics/person_manda.webp',
    'Not sure where I should travel to eat today.',
    '60',
  ),
  Post(
    '9',
    'assets/profile_pics/person_ray.webp',
    'Hot off the press, cooking up more books this year!',
    '70',
  ),
  Post(
    '10',
    'assets/profile_pics/person_tiffani.webp',
    'Hmmm.... Salmon, little broccoli, mash potatoes',
    '90',
  ),
];
