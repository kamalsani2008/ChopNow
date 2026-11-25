// CHOPNOW - food delivery app.
// Single-file Flutter + Dart, Material 3, no external packages. DartPad ready.
import 'package:flutter/material.dart';

void main() => runApp(const ChopNowApp());

// ───────────────────────── Design tokens ─────────────────────────

const Color kPrimary = Color(0xFFFF6B35);
const Color kTint = Color(0x1FFF6B35);
const Color kInk = Color(0xFF1E1E24);
const Color kGrey = Color(0xFF86868F);
const Color kSurface = Color(0xFFF5F5F7);
const Color kLine = Color(0xFFE6E6EB);
const Color kGreen = Color(0xFF1FA45B);
const Color kRed = Color(0xFFE53935);
const Color kStar = Color(0xFFFFB400);

const List<BoxShadow> kShadow = [
  BoxShadow(color: Color(0x14000000), blurRadius: 18, offset: Offset(0, 6)),
];

const double kDeliveryFee = 2.99;
const double kFreeDeliveryFrom = 30.0;

TextStyle hStyle(double size, {Color color = kInk}) => TextStyle(
      fontSize: size,
      fontWeight: FontWeight.w800,
      color: color,
      height: 1.2,
      letterSpacing: size > 20 ? -0.5 : -0.2,
    );

TextStyle bStyle(double size,
        {Color color = kGrey, FontWeight weight = FontWeight.w500}) =>
    TextStyle(fontSize: size, fontWeight: weight, color: color, height: 1.4);

String money(double v) => '\$${v.toStringAsFixed(2)}';

const List<String> _months = [
  'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
];
String fmtDate(DateTime d) => '${_months[d.month - 1]} ${d.day}, ${d.year}';

String greeting() {
  final h = DateTime.now().hour;
  if (h < 12) return 'Good morning';
  if (h < 17) return 'Good afternoon';
  return 'Good evening';
}

// ───────────────────────── Models & sample data ─────────────────────────

class Restaurant {
  final String id, name, cuisine, image, address, about;
  final double rating, km;
  final int reviews, minutes;
  const Restaurant({
    required this.id,
    required this.name,
    required this.cuisine,
    required this.image,
    required this.address,
    required this.about,
    required this.rating,
    required this.km,
    required this.reviews,
    required this.minutes,
  });
}

class Food {
  final String id, restaurantId, name, desc, image, category, emoji;
  final double price, rating;
  final int calories;
  const Food({
    required this.id,
    required this.restaurantId,
    required this.name,
    required this.desc,
    required this.image,
    required this.category,
    required this.emoji,
    required this.price,
    required this.rating,
    required this.calories,
  });
}

class FoodCategory {
  final String name, emoji;
  const FoodCategory(this.name, this.emoji);
}

class CartItem {
  final Food food;
  int qty;
  CartItem(this.food, this.qty);
  double get total => food.price * qty;
}

class Order {
  final String id, payment, address, status;
  final DateTime date;
  final List<CartItem> items;
  final double deliveryFee;
  const Order({
    required this.id,
    required this.payment,
    required this.address,
    required this.status,
    required this.date,
    required this.items,
    required this.deliveryFee,
  });
  double get subtotal => items.fold(0.0, (s, i) => s + i.total);
  double get total => subtotal + deliveryFee;
  int get count => items.fold(0, (s, i) => s + i.qty);
}

const String kImg = 'https://images.unsplash.com/photo-';
const String kImgQ = '?auto=format&fit=crop&w=900&q=80';

const List<FoodCategory> categories = [
  FoodCategory('Burgers', '🍔'),
  FoodCategory('Pizza', '🍕'),
  FoodCategory('Sushi', '🍣'),
  FoodCategory('Pasta', '🍝'),
  FoodCategory('Chicken', '🍗'),
  FoodCategory('Salads', '🥗'),
  FoodCategory('Desserts', '🍰'),
  FoodCategory('Drinks', '🥤'),
];

const List<Restaurant> restaurants = [
  Restaurant(
    id: 'r1',
    name: 'Burger Barn',
    cuisine: 'Burgers and American grill',
    image: '${kImg}1517248135467-4c7edcad34c4$kImgQ',
    address: '14 Market Street',
    about: 'Hand-pressed burgers, hot crispy fries and sauces made in house. Every order is cooked fresh when you place it.',
    rating: 4.7, km: 1.2, reviews: 1240, minutes: 20,
  ),
  Restaurant(
    id: 'r2',
    name: 'Napoli Slice',
    cuisine: 'Italian pizza and pasta',
    image: '${kImg}1555396273-367ea4eb4db5$kImgQ',
    address: '8 Olive Avenue',
    about: 'Wood-fired pizza with slow-proofed dough, plus pasta made daily from classic Italian recipes.',
    rating: 4.8, km: 2.4, reviews: 980, minutes: 30,
  ),
  Restaurant(
    id: 'r3',
    name: 'Sakura Sushi',
    cuisine: 'Japanese sushi',
    image: '${kImg}1559339352-11d035aa65de$kImgQ',
    address: '3 Cherry Lane',
    about: 'Fresh nigiri and signature rolls prepared by trained sushi chefs, packed to travel well.',
    rating: 4.6, km: 3.1, reviews: 760, minutes: 35,
  ),
  Restaurant(
    id: 'r4',
    name: 'Crispy Coop',
    cuisine: 'Fried and grilled chicken',
    image: '${kImg}1552566626-52f8b828add9$kImgQ',
    address: '27 Union Road',
    about: 'Buttermilk fried chicken with a golden crunch, and a smoky grill menu for lighter appetites.',
    rating: 4.5, km: 1.8, reviews: 1510, minutes: 25,
  ),
  Restaurant(
    id: 'r5',
    name: 'Green Bowl',
    cuisine: 'Healthy salads and bowls',
    image: '${kImg}1414235077428-338989a2e8c0$kImgQ',
    address: '5 Garden Walk',
    about: 'Crisp seasonal greens, grains and protein bowls. Light, filling and ready in minutes.',
    rating: 4.4, km: 0.9, reviews: 430, minutes: 15,
  ),
  Restaurant(
    id: 'r6',
    name: 'Sweet Tooth',
    cuisine: 'Desserts and drinks',
    image: '${kImg}1424847651672-bf20a4b0982b$kImgQ',
    address: '90 Sugar Street',
    about: 'Cakes, donuts and cold drinks baked and blended daily. The perfect finish to any order.',
    rating: 4.9, km: 2.0, reviews: 2100, minutes: 18,
  ),
];

const List<Food> foods = [
  Food(id: 'f1', restaurantId: 'r1', name: 'Classic Smash Burger', category: 'Burgers', emoji: '🍔', price: 8.99, rating: 4.8, calories: 640,
      desc: 'Two smashed beef patties, melted cheddar, pickles, onion and our house sauce in a toasted brioche bun.',
      image: '${kImg}1568901346375-23c9450c58cd$kImgQ'),
  Food(id: 'f2', restaurantId: 'r1', name: 'Double Bacon Burger', category: 'Burgers', emoji: '🍔', price: 11.49, rating: 4.7, calories: 890,
      desc: 'Double beef, smoked bacon, cheese, caramelised onions and smoky BBQ sauce. Served with crispy fries.',
      image: '${kImg}1550547660-d9450f859349$kImgQ'),
  Food(id: 'f3', restaurantId: 'r1', name: 'Spicy Chicken Burger', category: 'Burgers', emoji: '🍔', price: 9.75, rating: 4.5, calories: 710,
      desc: 'Crunchy spiced chicken fillet, slaw, jalapeños and chilli mayo on a soft sesame bun.',
      image: '${kImg}1606755962773-d324e0a13086$kImgQ'),
  Food(id: 'f4', restaurantId: 'r2', name: 'Margherita Pizza', category: 'Pizza', emoji: '🍕', price: 12.50, rating: 4.8, calories: 780,
      desc: 'San Marzano tomato, fresh mozzarella and basil on a thin wood-fired crust.',
      image: '${kImg}1574071318508-1cdbab80d002$kImgQ'),
  Food(id: 'f5', restaurantId: 'r2', name: 'Pepperoni Pizza', category: 'Pizza', emoji: '🍕', price: 14.00, rating: 4.7, calories: 920,
      desc: 'Generous pepperoni, mozzarella and tomato sauce with a touch of chilli honey.',
      image: '${kImg}1628840042765-356cda07504e$kImgQ'),
  Food(id: 'f6', restaurantId: 'r2', name: 'Creamy Carbonara', category: 'Pasta', emoji: '🍝', price: 13.25, rating: 4.6, calories: 850,
      desc: 'Spaghetti tossed in a silky egg and pecorino sauce with crispy pancetta and black pepper.',
      image: '${kImg}1612874742237-6526221588e3$kImgQ'),
  Food(id: 'f7', restaurantId: 'r3', name: 'Salmon Nigiri Set', category: 'Sushi', emoji: '🍣', price: 16.90, rating: 4.8, calories: 520,
      desc: 'Eight pieces of hand-pressed salmon nigiri served with ginger, wasabi and soy.',
      image: '${kImg}1579871494447-9811cf80d66c$kImgQ'),
  Food(id: 'f8', restaurantId: 'r3', name: 'Dragon Roll', category: 'Sushi', emoji: '🍣', price: 15.50, rating: 4.6, calories: 610,
      desc: 'Shrimp tempura and cucumber rolled in rice, topped with avocado and sweet eel sauce.',
      image: '${kImg}1617196034796-73dfa7b1fd56$kImgQ'),
  Food(id: 'f9', restaurantId: 'r4', name: 'Crispy Fried Chicken', category: 'Chicken', emoji: '🍗', price: 10.99, rating: 4.6, calories: 830,
      desc: 'Six pieces of buttermilk-brined chicken fried until golden, with a side of honey hot sauce.',
      image: '${kImg}1626082927389-6cd097cdc6ec$kImgQ'),
  Food(id: 'f10', restaurantId: 'r4', name: 'Grilled Chicken Plate', category: 'Chicken', emoji: '🍗', price: 12.49, rating: 4.5, calories: 560,
      desc: 'Flame-grilled chicken breast with herb rice, charred vegetables and garlic yoghurt.',
      image: '${kImg}1598103442097-8b74394b95c6$kImgQ'),
  Food(id: 'f11', restaurantId: 'r5', name: 'Garden Power Salad', category: 'Salads', emoji: '🥗', price: 9.75, rating: 4.4, calories: 380,
      desc: 'Mixed greens, cherry tomatoes, cucumber, chickpeas, feta and a lemon herb dressing.',
      image: '${kImg}1512621776951-a57141f2eefd$kImgQ'),
  Food(id: 'f12', restaurantId: 'r5', name: 'Avocado Quinoa Bowl', category: 'Salads', emoji: '🥗', price: 11.25, rating: 4.5, calories: 470,
      desc: 'Quinoa, ripe avocado, roasted sweet potato, edamame and a sesame ginger dressing.',
      image: '${kImg}1546069901-ba9599a7e63c$kImgQ'),
  Food(id: 'f13', restaurantId: 'r6', name: 'Chocolate Layer Cake', category: 'Desserts', emoji: '🍰', price: 6.50, rating: 4.9, calories: 540,
      desc: 'Three layers of moist chocolate sponge with dark ganache and whipped cream.',
      image: '${kImg}1578985545062-69928b1d9587$kImgQ'),
  Food(id: 'f14', restaurantId: 'r6', name: 'Glazed Donut Box', category: 'Desserts', emoji: '🍩', price: 7.99, rating: 4.7, calories: 620,
      desc: 'Six soft, freshly glazed donuts in assorted flavours. Great for sharing.',
      image: '${kImg}1551024601-bec78aea704b$kImgQ'),
  Food(id: 'f15', restaurantId: 'r6', name: 'Berry Smoothie', category: 'Drinks', emoji: '🥤', price: 5.25, rating: 4.6, calories: 210,
      desc: 'Blended strawberries, blueberries and banana with creamy yoghurt.',
      image: '${kImg}1553530666-ba11a7da3888$kImgQ'),
  Food(id: 'f16', restaurantId: 'r6', name: 'Iced Caramel Latte', category: 'Drinks', emoji: '🥤', price: 4.75, rating: 4.7, calories: 180,
      desc: 'Double espresso over ice with cold milk and a ribbon of salted caramel.',
      image: '${kImg}1461023058943-07fcbe16d735$kImgQ'),
];

Food foodById(String id) => foods.firstWhere((f) => f.id == id);
Restaurant restaurantOf(Food f) =>
    restaurants.firstWhere((r) => r.id == f.restaurantId);
List<Food> menuOf(Restaurant r) =>
    foods.where((f) => f.restaurantId == r.id).toList();

// ───────────────────────── App state ─────────────────────────

class AppState extends ChangeNotifier {
  AppState() {
    orders.addAll([
      Order(
        id: 'CN-1041',
        date: DateTime(2026, 11, 20),
        items: [CartItem(foodById('f4'), 1), CartItem(foodById('f15'), 2)],
        payment: 'Visa •••• 4242',
        address: address,
        status: 'Delivered',
        deliveryFee: kDeliveryFee,
      ),
      Order(
        id: 'CN-1034',
        date: DateTime(2026, 11, 12),
        items: [CartItem(foodById('f7'), 1), CartItem(foodById('f8'), 1)],
        payment: 'Chop Wallet',
        address: address,
        status: 'Delivered',
        deliveryFee: 0,
      ),
    ]);
  }

  final List<CartItem> cart = [];
  final List<Order> orders = [];
  String name = 'Alex Morgan';
  String email = 'alex.morgan@email.com';
  String phone = '+1 555 014 2290';
  String address = '24 Maple Street, Downtown';
  bool pushOn = true;
  bool promoOn = false;

  void update(VoidCallback fn) {
    fn();
    notifyListeners();
  }

  int get itemCount => cart.fold(0, (s, c) => s + c.qty);
  double get subtotal => cart.fold(0.0, (s, c) => s + c.total);
  double get deliveryFee =>
      (cart.isEmpty || subtotal >= kFreeDeliveryFrom) ? 0 : kDeliveryFee;
  double get total => subtotal + deliveryFee;

  void add(Food f, int qty) {
    final i = cart.indexWhere((c) => c.food.id == f.id);
    if (i >= 0) {
      cart[i].qty += qty;
    } else {
      cart.add(CartItem(f, qty));
    }
    notifyListeners();
  }

  void changeQty(CartItem item, int delta) {
    item.qty += delta;
    if (item.qty <= 0) cart.remove(item);
    notifyListeners();
  }

  void remove(CartItem item) {
    cart.remove(item);
    notifyListeners();
  }

  void clearCart() {
    cart.clear();
    notifyListeners();
  }

  void reorder(Order o) {
    for (final i in o.items) {
      add(i.food, i.qty);
    }
  }

  Order placeOrder(String payment) {
    final order = Order(
      id: 'CN-${1042 + orders.length - 2}',
      date: DateTime.now(),
      items: cart.map((c) => CartItem(c.food, c.qty)).toList(),
      payment: payment,
      address: address,
      status: 'Preparing',
      deliveryFee: deliveryFee,
    );
    orders.insert(0, order);
    cart.clear();
    notifyListeners();
    return order;
  }
}

final AppState app = AppState();
final ValueNotifier<int> tabIndex = ValueNotifier<int>(0);
final ValueNotifier<String> exploreCategory = ValueNotifier<String>('All');
final ValueNotifier<int> exploreMode = ValueNotifier<int>(0); // 0 restaurants, 1 dishes

// ───────────────────────── Helpers ─────────────────────────

void goTo(BuildContext context, Widget page) =>
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));

void openCart(NavigatorState nav) {
  tabIndex.value = 2;
  nav.popUntil((r) => r.isFirst);
}

void openExplore({String category = 'All', int mode = 0}) {
  exploreCategory.value = category;
  exploreMode.value = mode;
  tabIndex.value = 1;
}

void addToCart(BuildContext context, Food f, [int qty = 1]) {
  final nav = Navigator.of(context);
  final messenger = ScaffoldMessenger.of(context);
  app.add(f, qty);
  messenger.hideCurrentSnackBar();
  messenger.showSnackBar(SnackBar(
    content: Text('$qty × ${f.name} added'),
    duration: const Duration(seconds: 2),
    action: SnackBarAction(
        label: 'View cart', textColor: kPrimary, onPressed: () => openCart(nav)),
  ));
}

void toast(BuildContext context, String message) {
  final m = ScaffoldMessenger.of(context);
  m.hideCurrentSnackBar();
  m.showSnackBar(SnackBar(content: Text(message), duration: const Duration(seconds: 2)));
}

Future<String?> promptText(BuildContext context, String title, String initial,
    {TextInputType? type}) {
  return showDialog<String>(
    context: context,
    builder: (_) => _PromptDialog(title: title, initial: initial, type: type),
  );
}

Future<void> editField(BuildContext context, String title, String current,
    void Function(String) save, {TextInputType? type}) async {
  final v = await promptText(context, title, current, type: type);
  if (v != null && v.trim().isNotEmpty) save(v.trim());
}

// ───────────────────────── App root & theme ─────────────────────────

ThemeData buildTheme() {
  final scheme = ColorScheme.fromSeed(seedColor: kPrimary, brightness: Brightness.light)
      .copyWith(primary: kPrimary, onPrimary: Colors.white, surface: Colors.white);
  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      foregroundColor: kInk,
      centerTitle: true,
      titleTextStyle: TextStyle(color: kInk, fontSize: 18, fontWeight: FontWeight.w800),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: kPrimary,
        foregroundColor: Colors.white,
        minimumSize: const Size(88, 54),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      indicatorColor: kTint,
      height: 68,
      labelTextStyle: WidgetStateProperty.resolveWith((s) => TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: s.contains(WidgetState.selected) ? kPrimary : kGrey,
          )),
      iconTheme: WidgetStateProperty.resolveWith((s) =>
          IconThemeData(color: s.contains(WidgetState.selected) ? kPrimary : kGrey)),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.all(Colors.white),
      trackColor: WidgetStateProperty.resolveWith((s) =>
          s.contains(WidgetState.selected) ? kPrimary : const Color(0xFFD0D0D6)),
      trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
    ),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: kInk,
      contentTextStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),
    dividerColor: kLine,
  );
}

class ChopNowApp extends StatelessWidget {
  const ChopNowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChopNow',
      debugShowCheckedModeBanner: false,
      theme: buildTheme(),
      // Keeps the phone layout centred on wide screens (e.g. DartPad / web).
      builder: (context, child) => ColoredBox(
        color: const Color(0xFFE9E9ED),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: child ?? const SizedBox.shrink(),
          ),
        ),
      ),
      home: const MainShell(),
    );
  }
}

// ───────────────────────── Main shell + bottom navigation ─────────────────────────

class MainShell extends StatelessWidget {
  const MainShell({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([tabIndex, app]),
      builder: (context, _) {
        final i = tabIndex.value;
        final n = app.itemCount;
        return Scaffold(
          body: IndexedStack(
            index: i,
            children: const [HomeScreen(), ExploreScreen(), CartScreen(), ProfileScreen()],
          ),
          bottomNavigationBar: NavigationBar(
            selectedIndex: i,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            onDestinationSelected: (v) => tabIndex.value = v,
            destinations: [
              const NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home_rounded),
                  label: 'Home'),
              const NavigationDestination(
                  icon: Icon(Icons.explore_outlined),
                  selectedIcon: Icon(Icons.explore_rounded),
                  label: 'Explore'),
              NavigationDestination(
                icon: Badge(
                  isLabelVisible: n > 0,
                  backgroundColor: kPrimary,
                  label: Text('$n'),
                  child: const Icon(Icons.shopping_bag_outlined),
                ),
                selectedIcon: Badge(
                  isLabelVisible: n > 0,
                  backgroundColor: kPrimary,
                  label: Text('$n'),
                  child: const Icon(Icons.shopping_bag_rounded),
                ),
                label: 'Cart',
              ),
              const NavigationDestination(
                  icon: Icon(Icons.person_outline_rounded),
                  selectedIcon: Icon(Icons.person_rounded),
                  label: 'Profile'),
            ],
          ),
        );
      },
    );
  }
}

// ───────────────────────── Reusable widgets ─────────────────────────

class NetImage extends StatelessWidget {
  final String url;
  
