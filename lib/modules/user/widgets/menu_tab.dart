import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/models/food_item.dart';

class MenuTab extends StatelessWidget {
  final List<FoodItem> items;
  final String category;
  final Function(FoodItem)? onAdd;

  const MenuTab({
    super.key,
    required this.items,
    required this.category,
    this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    final filteredItems = items.where((item) => item.category == category).toList();

    if (filteredItems.isEmpty) {
      return const Center(
        child: Text('No items in this category', style: TextStyle(color: AppTheme.textLight)),
      );
    }

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 20),
      itemCount: filteredItems.length,
      itemBuilder: (context, index) {
        final item = filteredItems[index];
        return _AnimatedFoodCard(item: item, onAdd: onAdd);
      },
    );
  }
}

class _AnimatedFoodCard extends StatefulWidget {
  final FoodItem item;
  final Function(FoodItem)? onAdd;

  const _AnimatedFoodCard({required this.item, this.onAdd});

  @override
  State<_AnimatedFoodCard> createState() => _AnimatedFoodCardState();
}

class _AnimatedFoodCardState extends State<_AnimatedFoodCard> with SingleTickerProviderStateMixin {
  bool _isPressed = false;
  late AnimationController _animController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    setState(() => _isPressed = true);
    _animController.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() => _isPressed = false);
    _animController.reverse();
  }

  void _handleTapCancel() {
    setState(() => _isPressed = false);
    _animController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    // Generate a pseudo-random rating between 4.0 and 5.0
    final double rating = 4.0 + (widget.item.id.hashCode % 11) / 10;

    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) => Transform.scale(
          scale: _scaleAnimation.value,
          child: child,
        ),
        child: Container(
          margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: _isPressed ? Colors.black.withOpacity(0.02) : Colors.black.withOpacity(0.08),
                blurRadius: _isPressed ? 10 : 20,
                offset: _isPressed ? const Offset(0, 5) : const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Large image header
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                child: SizedBox(
                  height: 140,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        widget.item.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: AppTheme.softPink,
                          child: const Icon(Icons.fastfood, color: AppTheme.primaryPink, size: 40),
                        ),
                      ),
                      Positioned(
                        top: 12,
                        right: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4, offset: const Offset(0, 2)),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.star, color: AppTheme.warningOrange, size: 16),
                              const SizedBox(width: 4),
                              Text(
                                rating.toStringAsFixed(1),
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.item.name,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppTheme.textDark),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.item.description,
                            style: const TextStyle(color: AppTheme.textLight, fontSize: 13),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            '₹${widget.item.price.toStringAsFixed(0)}',
                            style: const TextStyle(fontWeight: FontWeight.w900, color: AppTheme.primaryPink, fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    if (widget.item.isAvailable)
                      _AnimatedAddButton(
                        onPressed: widget.onAdd != null ? () => widget.onAdd!(widget.item) : null,
                      )
                    else
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Text('Sold Out', style: TextStyle(color: AppTheme.errorRed, fontWeight: FontWeight.bold)),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AnimatedAddButton extends StatefulWidget {
  final VoidCallback? onPressed;

  const _AnimatedAddButton({this.onPressed});

  @override
  State<_AnimatedAddButton> createState() => _AnimatedAddButtonState();
}

class _AnimatedAddButtonState extends State<_AnimatedAddButton> with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(vsync: this, duration: const Duration(milliseconds: 100));
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(_animController);
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _animController.forward(),
      onTapUp: (_) {
        _animController.reverse();
        if (widget.onPressed != null) widget.onPressed!();
      },
      onTapCancel: () => _animController.reverse(),
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) => Transform.scale(
          scale: _scaleAnimation.value,
          child: child,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppTheme.primaryPink, Color(0xFFF06292)], // Slightly lighter pink
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppTheme.primaryPink.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.add, color: Colors.white, size: 20),
              SizedBox(width: 4),
              Text(
                'ADD',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
