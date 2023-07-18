
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
  tile(['sleep','sleepy','nap','rest', 'yawn'],'sleep', 'assets/into/sleep.png','I am feeling sleepy', 'എനിക്ക് ഉറക്കം വരുന്നു'),
  tile(['Hungry','food', 'hungary', 'hunger', 'starve'],'eat', 'assets/into/hungry.png', 'I am hungry','എനിക്ക് വിശക്കുന്നു'),
  tile(['Sick','not feeling well','ill','illness'],'Sick', 'assets/into/sick.png', 'I am sick','എനിക്ക് സുഖമില്ല'),
  tile(['play','running','go outside', 'fun', 'hobbies'],'play', 'assets/into/play.png', 'I want to go to play','എനിക്ക് കളിക്കാൻ പോകണം'),
  tile(['tv','television','watch', 'movie', 'film', 'object'],'television', 'assets/into/tv.png', 'I want to watch tv','എനിക്ക് ടിവി കാണണം'),
  tile(['toilet','washroom','restroom', 'wash'],'Toilet', 'assets/into/toilet.png', 'I want to go to toilet','എനിക്ക് ടോയ്‌ലറ്റിൽ പോകണം'),
  tile(['bath','shower','wash', 'washroom', 'toilet'],'bath', 'assets/into/bath.png', 'I want to take a bath','എനിക്ക് കുളിക്കണം'),
  tile([],'Water', 'assets/into/water.png', 'I am thirsty','എനിക്ക് ദാഹിക്കുന്നു'),
  //other tiles - food
  tile(['Hungry','food', 'hungary', 'hunger', 'starve', 'banana','appetite'],'Banana', 'assets/into/banana.png', 'I want banana','എനിക്ക് വാഴപ്പഴം വേണം'),
  tile(['Hungry','food', 'hungary', 'hunger', 'starve', 'apple','appetite'],'Apple', 'assets/into/apple.png', 'I want apple','എനിക്ക് ആപ്പിൾ വേണം'),
  tile(['Hungry','food', 'hungary', 'hunger', 'starve', 'mango','appetite'],'Mango', 'assets/into/mango.png', 'I want mango','എനിക്ക് മാങ്ങ വേണം'),
  tile(['Hungry','food', 'hungary', 'hunger', 'starve', 'grapes','appetite'],'Grapes', 'assets/into/grapes.png', 'I want grapes','എനിക്ക് മുന്തിരി വേണം'),
  tile(['Hungry','food', 'hungary', 'hunger', 'starve', 'burger','appetite'],'Burger', 'assets/into/burger.png', 'I want burger','എനിക്ക് ബർഗർ വേണം'),
  tile(['Hungry','food', 'hungary', 'hunger', 'starve', 'pizza','appetite'],'Pizza', 'assets/into/pizza.png', 'I want pizza','എനിക്ക് പിസ്സ വേണം'),
  tile(['Hungry','food', 'hungary', 'hunger', 'starve', 'dosa','appetite'],'Dosa', 'assets/into/dosa.png', 'I want dosa','എനിക്ക് ദോശ വേണം'),
  tile(['Hungry','food', 'hungary', 'hunger', 'starve', 'rice','appetite'],'Rice', 'assets/into/rice.png', 'I want rice','എനിക്ക് ചൂർ വേണം'),
  tile(['Hungry','food', 'hungary', 'hunger', 'starve', 'samosa','appetite'],'Samosa', 'assets/into/samosa.png', 'I want samosa','എനിക്ക് സമൂസ വേണം'),
  tile(['Hungry','food', 'hungary', 'hunger', 'starve', 'roti', 'chapathi','appetite'],'Roti', 'assets/into/roti.png', 'I want chapathi','എനിക്ക് ചപ്പാത്തി വേണം'),
  tile(['Hungry','food', 'hungary', 'hunger', 'starve', 'bread','appetite'],'Bread', 'assets/into/bread.png', 'I want bread','എനിക്ക് അപ്പം വേണം'),
  tile(['Hungry','food', 'hungary', 'hunger', 'starve', 'jam','appetite'],'Jam', 'assets/into/jam.png', 'I want jam','എനിക്ക് ജാം വേണം'),
  tile(['Hungry','food', 'hungary', 'hunger', 'starve', 'icecream', 'ice','appetite'],'Icecream', 'assets/into/icecream.png', 'I want icecream','എനിക്ക് ഐസ് ക്രീം വേണം'),
  tile(['Hungry','food', 'hungary', 'hunger', 'starve', 'biscuit','appetite'],'Biscuit', 'assets/into/biscuit.png', 'I want biscuit','എനിക്ക് ബിസ്‌കറ്റ് വേണം'),
  tile(['Hungry','food', 'hungary', 'hunger', 'starve', 'chocolate','appetite'],'Chocolate', 'assets/into/chocolate.png', 'I want chocolate','എനിക്ക് ചോക്ലേറ്റ് വേണം'),
  // -drinks
  tile(['thirsty','dehydrated', 'drink', 'juice', 'water', 'thirst'],'Juice', 'assets/into/water.png', 'I want water','എനിക്ക് വെള്ളം വേണം'),
  tile(['thirsty','dehydrated', 'drink', 'juice', 'water', 'milk', 'thirst'],'Milk', 'assets/into/milk.png', 'I want milk','എനിക്ക് പാൽ വേണം'),
  tile(['thirsty','dehydrated', 'drink', 'juice', 'water', 'coffee', 'thirst'],'Coffee', 'assets/into/coffee.png', 'I want coffee','എനിക്ക് കാപ്പി വേണം'),
  tile(['thirsty','dehydrated', 'drink', 'juice', 'water', 'thirst'],'Juice', 'assets/into/juice.png', 'I want juice','എനിക്ക് ജ്യൂസ് വേണം'),
  // -washroom
  tile(['toilet','washroom','restroom', 'wash', 'bath'],'Wash', 'assets/into/wash.png', 'I want to wash hands','എനിക്ക് കൈ കഴുകണം'),
  tile(['bath','brush','wash', 'washroom', 'toilet'],'Brush', 'assets/into/brush.png', 'I want to brush','എനിക്ക് ബ്രഷ് ചെയ്യണം'),
  tile(['toilet','washroom','soap', 'wash', 'bath'],'Soap', 'assets/into/soap.png', 'I want soap','എനിക്ക് സോപ്പ് വേണം'),
  // -school
  tile(['school','study','books', 'book', 'exam'],'School', 'assets/into/school.png', 'I want to go to school','എനിക്ക് സ്കൂളിൽ പോകണം'),
  tile(['school','study','books', 'book', 'exam'],'Study', 'assets/into/study.png', 'I want to study','എനിക്ക് പഠിക്കണം'),
  tile(['school','study','books', 'book', 'object', 'pen', 'write', 'draw'],'Pen', 'assets/into/pen.png', 'I want pen','എനിക്ക് പേന വേണം'),
  tile(['school','study','books', 'book', 'object', 'pencil', 'write', 'draw'],'Pencil', 'assets/into/pencil.png', 'I want pencil','എനിക്ക് പെൻസിൽ വേണം'),
  tile(['school','study','books', 'book', 'object', 'write', 'draw'],'Books', 'assets/into/book.png', 'I want my book','എനിക്ക് എന്റെ പുസ്തകം വേണം'),
  tile(['school','study','books', 'book', 'object', 'bag'],'Bag', 'assets/into/bag.png', 'I want my bag','എനിക്ക് എന്റെ ബാഗ് വേണം'),
  // -object
  tile(['fan','air','cool', 'object', 'wind'],'Fan', 'assets/into/fan.png', 'Fan','ഫാൻ'),
  tile(['fridge','chill','cool', 'object', 'ice'],'Fridge', 'assets/into/fridge.png', 'Fridge','ഫ്രിഡ്ജ്'),
  tile(['door','gate', 'object', 'close'],'Door', 'assets/into/door.png', 'Door','വാതിൽ'),
  tile(['car','drive','drift', 'object', 'wroom'],'Car', 'assets/into/car.png', 'Car','കാർ'),
  tile(['spoon','eat', 'object' ],'Spoon', 'assets/into/spoon.png', 'Spoon','കരണ്ടി'),
  tile(['fork','eat', 'object' ],'Fork', 'assets/into/fork.png', 'fork','നാൽക്കവല'),
  // - animals
  tile(['animal','dog', 'bow'],'Dog', 'assets/into/dog.png', 'dog','പട്ടി'),
  tile(['animal','cat', 'meow'],'Cat', 'assets/into/cat.png', 'cat','പൂച്ച'),
  tile(['animal','rabbit', 'hop'],'Rabbit', 'assets/into/rabbit.png', 'rabbit','മുയൽ'),
  tile(['animal','cow', 'moo'],'Cow', 'assets/into/cow.png', 'cow','പശു'),
  // - alphabet
  tile(['alphabet'],'A', 'assets/into/A.png', 'A',''),
  tile(['alphabet'],'B', 'assets/into/B.png', 'B',''),
  tile(['alphabet'],'C', 'assets/into/C.png', 'C',''),
  tile(['alphabet'],'D', 'assets/into/D.png', 'D',''),
  tile(['alphabet'],'E', 'assets/into/E.png', 'E',''),
  // -numbers
  tile(['numbers', 'digits', 'zero'],'0', 'assets/into/0.png', '0',''),
  tile(['numbers', 'digits', 'one'],'1', 'assets/into/1.png', '1',''),
  tile(['numbers', 'digits', 'two'],'2', 'assets/into/2.png', '2',''),
  tile(['numbers', 'digits', 'three'],'3', 'assets/into/3.png', '3',''),
  tile(['numbers', 'digits', 'four'],'4', 'assets/into/4.png', '4',''),
  tile(['numbers', 'digits', 'five'],'5', 'assets/into/5.png', '5',''),
  tile(['numbers', 'digits', 'six'],'6', 'assets/into/6.png', '6',''),
  tile(['numbers', 'digits', 'seven'],'7', 'assets/into/7.png', '7',''),
  tile(['numbers', 'digits', 'eight'],'8', 'assets/into/8.png', '8',''),
  tile(['numbers', 'digits', 'nine'],'9', 'assets/into/9.png', '9',''),
  // -body parts
  tile(['body', 'pain'],'pain', 'assets/into/pain.png', 'pain','വേദന'),
  tile(['body', 'hand'],'hand', 'assets/into/hand.png', 'hand','കൈ'),
  tile(['body', 'leg', 'foot'],'leg', 'assets/into/leg.png', 'leg','കാല്'),
  tile(['body', 'finger'],'finger', 'assets/into/finger.png', 'finger','വിരല്'),
  tile(['body', 'eyes'],'eyes', 'assets/into/eyes.png', 'eyes','കണ്ണുകൾ'),
  tile(['body', 'ear'],'ear', 'assets/into/ear.png', 'ear','ചെവി'),
  tile(['body', 'nose'],'nose', 'assets/into/nose.png', 'nose','മൂക്ക്'),
  tile(['body', 'face'],'face', 'assets/into/face.png', 'face','മുഖം'),
  tile(['body', 'head'],'head', 'assets/into/head.png', 'head','തല'),
  // - hobbies
  tile(['hobbies', 'football', 'play', 'out'],'football', 'assets/into/football.png', 'football','ഫുട്ബോൾ'),
  tile(['hobbies', 'cricket', 'play', 'out'],'cricket', 'assets/into/cricket.png', 'cricket','ക്രിക്കറ്റ്'),
  tile(['hobbies', 'badminton', 'play', 'out'],'badminton', 'assets/into/badminton.png', 'badminton','ബാഡ്മിന്റൺ'),
  tile(['hobbies', 'guitar', 'play', 'music', 'song'],'guitar', 'assets/into/guitar.png', 'guitar','ഗിറ്റാർ'),
  tile(['hobbies', 'piano', 'keyboard', 'play', 'music', 'song'],'piano', 'assets/into/piano.png', 'piano','പിയാനോ'),
  tile(['hobbies', 'draw', 'paint'],'draw', 'assets/into/draw.png', 'draw','വരയ്ക്കുക'),
  tile(['hobbies', 'dance', 'music', 'dancing'],'dance', 'assets/into/dance.png', 'dance','നൃത്തം'),
  // - prbs
  tile(['me', 'us', 'prbs'],'I', 'assets/into/i.png', 'i','ഞാൻ'),
  tile(['me', 'us', 'fine', 'okay', 'prbs'],'fine', 'assets/into/fine.png', 'I am fine','എനിക്ക് സുഖമാണ്'),
  tile(['me', 'us', 'want', 'yes', 'prbs'],'want', 'assets/into/iwant.png', 'want','വേണം'),
  tile(['me', 'us', 'want', 'no', 'do not', 'prbs'],'not', 'assets/into/notwant.png', 'dont want','വേണ്ട'),
  // - greet
  tile(['hello', 'greet','hi','greetings'],'Hello', 'assets/into/hello.png', 'Hello','നമസ്കാരം'),
  tile(['morning','good morning', 'greet','greetings'],'Good Morning', 'assets/into/morning.png', 'Good Morning','സുപ്രഭാതം'),
  tile(['good night','night','greet','greetings'],'Good Night', 'assets/into/night.png', 'Good Night','ശുഭ രാത്രി'),
  tile(['bye','greet','greetings','tata'],'Bye', 'assets/into/bye.png', 'Bye','ടാറ്റ'),
];
