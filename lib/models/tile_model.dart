
String path= "C__Users_abhiv_speech_assets_images_";
class tile {
  List<String> tag = [];
  String name;
  String image;
  String description;
  String maludescription;
  tile(this.tag,this.name, this.image, this.description,this.maludescription);
}

List<tile> demo = [
  tile(['sleep','sleepy','nap','rest'],'sleep', 'assets/PNG/${path}sleep_male_,_to.png','I am feeling sleepy', 'എനിക്ക് ഉറക്കം വരുന്നു'),
  tile(['Hungry','food'],'eat', 'assets/PNG/${path}eat_,_to.png', 'I am hungry','എനിക്ക് വിശക്കുന്നു'),
  tile(['Sick','not feeling well','ill','illness'],'Sick', 'assets/PNG/${path}stomach_ache.png', 'I am sick','എനിക്ക് സുഖമില്ല'),
  tile(['play','running','go outside'],'play', 'assets/PNG/${path}play_area.png', 'I want to go to play','എനിക്ക് കളിക്കാൻ പോകണം'),
  tile(['tv','television','watch'],'television', 'assets/PNG/${path}comedy_tv.png', 'I want to watch tv','എനിക്ക് ടിവി കാണണം'),
  tile(['toilet','washroom','restroom'],'Toilet', 'assets/PNG/${path}mens_toilet.png', 'I want to go to toilet','എനിക്ക് ടോയ്‌ലറ്റിൽ പോകണം'),
  tile(['bath','shower','wash'],'bath', 'assets/PNG/${path}bathe_,_to.png', 'I want to take a bath','എനിക്ക് കുളിക്കണം'),
  tile(['thirsty','dehydrated'],'Water', 'assets/PNG/${path}water.png', 'I am thirsty','എനിക്ക് ദാഹിക്കുന്നു'),
  tile(['Hungry','food'],'Banana', 'assets/PNG/${path}banana_bunch.png', 'I want a banana','എനിക്ക് ഒരു വാഴപ്പഴം വേണം'),
];
