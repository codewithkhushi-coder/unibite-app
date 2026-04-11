import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/models/canteen.dart';
import '../../../core/models/food_item.dart';
import '../widgets/menu_tab.dart';
import '../controllers/canteen_controller.dart';
import '../controllers/order_controller.dart';

class CanteenDetailsScreen extends ConsumerStatefulWidget {
  final String canteenId;

  const CanteenDetailsScreen({
    super.key,
    required this.canteenId,
  });

  @override
  ConsumerState<CanteenDetailsScreen> createState() => _CanteenDetailsScreenState();
}

class _CanteenDetailsScreenState extends ConsumerState<CanteenDetailsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Canteen? canteen;

  @override
  void initState() {
    super.initState();
    // Use future delayed to avoid build conflicts if needed, but here we can just lookup
    final canteenData = ref.read(canteenControllerProvider).firstWhere((c) => c.id == widget.canteenId);
    canteen = canteenData;
    _tabController = TabController(length: canteenData.categories.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (canteen == null) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    
    final cart = ref.watch(orderControllerProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        canteen!.name,
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppTheme.textDark),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppTheme.softPink,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.star, color: AppTheme.warningOrange, size: 18),
                            const SizedBox(width: 4),
                            Text(canteen!.rating.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${canteen!.location} • ${canteen!.distance} km away',
                    style: const TextStyle(color: AppTheme.textLight),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _buildInfoBadge(Icons.timer_outlined, '${canteen!.avgPrepTimeMinutes} mins prep'),
                      const SizedBox(width: 12),
                      _buildInfoBadge(Icons.people_outline, canteen!.queueLoadStatus),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Menu Categories',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.textDark),
                  ),
                ],
              ),
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: _SliverAppBarDelegate(
              TabBar(
                controller: _tabController,
                isScrollable: true,
                indicatorColor: AppTheme.primaryPink,
                labelColor: AppTheme.primaryPink,
                unselectedLabelColor: AppTheme.textLight,
                tabs: canteen!.categories.map((cat) => Tab(text: cat)).toList(),
              ),
            ),
          ),
          SliverFillRemaining(
            child: TabBarView(
              controller: _tabController,
              children: canteen!.categories.map((cat) {
                 return MenuTab(
                  items: canteen!.menu, 
                  category: cat,
                  onAdd: (item) {
                    ref.read(orderControllerProvider.notifier).addToCart(item, canteen!.id, canteen!.name);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${item.name} added to tray!'),
                        duration: const Duration(seconds: 1),
                        backgroundColor: AppTheme.primaryPink,
                        action: SnackBarAction(label: 'VIEW', textColor: Colors.white, onPressed: () => context.push('/user/cart')),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
      floatingActionButton: cart.itemCount > 0 ? FloatingActionButton.extended(
        onPressed: () => context.push('/user/cart'),
        backgroundColor: AppTheme.primaryPink,
        label: Text('View Tray (${cart.itemCount} items)', style: const TextStyle(fontWeight: FontWeight.bold)),
        icon: const Icon(Icons.shopping_basket),
      ) : null,
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      backgroundColor: AppTheme.primaryPink,
      flexibleSpace: FlexibleSpaceBar(
        background: (canteen?.imageUrl ?? '').isNotEmpty 
          ? Image.network(canteen!.imageUrl, fit: BoxFit.cover)
          : Container(color: AppTheme.softPink),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  Widget _buildInfoBadge(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppTheme.primaryPink),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildFoodItemCard(FoodItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: SizedBox(
              width: 80,
              height: 80,
              child: Image.network(
                item.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: AppTheme.softPink,
                  child: const Icon(Icons.fastfood, color: AppTheme.primaryPink),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppTheme.textDark),
                ),
                Text(item.description, style: const TextStyle(color: AppTheme.textLight, fontSize: 12), maxLines: 2, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('₹${item.price.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.primaryPink, fontSize: 16)),
                    if (item.isAvailable)
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                          minimumSize: const Size(60, 32),
                          backgroundColor: AppTheme.softPink,
                          foregroundColor: AppTheme.primaryPink,
                        ),
                        child: const Text('ADD', style: TextStyle(fontWeight: FontWeight.bold)),
                      )
                    else
                      const Text('Sold Out', style: TextStyle(color: AppTheme.errorRed, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

// Reuse dummy data from Home Screen for consistency in preview
final List<FoodItem> _dummyFoodItems = [
  const FoodItem(id: 'f1', name: 'Exam Special Thali', description: 'Full meal with brain-boosting dry fruits and low oil.', price: 120, imageUrl: '', category: 'Meals'),
  const FoodItem(id: 'f2', name: 'Budget Student Burger', description: 'Classic aloo tikki burger for quick energy.', price: 45, imageUrl: '', category: 'Snacks'),
  const FoodItem(id: 'f3', name: 'Hot Masala Chai', description: 'Freshly brewed tea to keep you awake.', price: 15, imageUrl: '', category: 'Drinks'),
];

final List<Canteen> _dummyCanteens = [
  Canteen(
    id: 'c1',
    name: 'Main Block Canteen',
    location: 'Ground Floor, Main Block',
    distance: 0.2,
    avgPrepTimeMinutes: 10,
    isOpen: true,
    queueLoad: QueueLoad.low,
    imageUrl: 'https://images.unsplash.com/photo-1567529854338-fc097b30e738?w=500&q=80',
    rating: 4.5,
    categories: ['Meals', 'Drinks', 'Snacks'],
    menu: _dummyFoodItems,
  ),
];
