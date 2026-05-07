import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/models/canteen.dart';

class CanteenCard extends StatefulWidget {
  final Canteen canteen;
  final VoidCallback onTap;

  const CanteenCard({
    super.key,
    required this.canteen,
    required this.onTap,
  });

  @override
  State<CanteenCard> createState() => _CanteenCardState();
}

class _CanteenCardState extends State<CanteenCard> with SingleTickerProviderStateMixin {
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
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.97).animate(
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
    widget.onTap();
  }

  void _handleTapCancel() {
    setState(() => _isPressed = false);
    _animController.reverse();
  }

  @override
  Widget build(BuildContext context) {
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
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: _isPressed ? Colors.black.withOpacity(0.04) : Colors.black.withOpacity(0.08),
                blurRadius: _isPressed ? 10 : 20,
                offset: _isPressed ? const Offset(0, 5) : const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: widget.canteen.imageUrl.startsWith('http')
                          ? Image.network(
                              widget.canteen.imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
                            )
                          : _buildPlaceholder(),
                    ),
                  ),
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: widget.canteen.isOpen ? AppTheme.successGreen : AppTheme.errorRed,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4, offset: const Offset(0, 2)),
                        ],
                      ),
                      child: Text(
                        widget.canteen.isOpen ? 'OPEN' : 'CLOSED',
                        style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1),
                      ),
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
                        children: [
                          const Icon(Icons.star, color: AppTheme.warningOrange, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            widget.canteen.rating.toStringAsFixed(1),
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (!widget.canteen.isOpen)
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.4),
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                        ),
                        child: const Center(
                          child: Text(
                            'CLOSED',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.canteen.name,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.textDark,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        _buildQueueBadge(widget.canteen.queueLoad),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined, size: 16, color: AppTheme.textLight),
                        const SizedBox(width: 4),
                        Text(
                          widget.canteen.location,
                          style: const TextStyle(color: AppTheme.textLight, fontSize: 14),
                        ),
                        const SizedBox(width: 8),
                        const Text('•', style: TextStyle(color: AppTheme.textLight)),
                        const SizedBox(width: 8),
                        Text(
                          '${widget.canteen.distance} km',
                          style: const TextStyle(color: AppTheme.textLight, fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        _buildInfoTile(Icons.access_time_rounded, '${widget.canteen.avgPrepTimeMinutes} mins'),
                        const SizedBox(width: 20),
                        _buildInfoTile(Icons.local_fire_department_outlined, 'Trending'),
                      ],
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

  Widget _buildPlaceholder() {
    return Container(
      color: AppTheme.softPink,
      child: const Center(
        child: Icon(Icons.storefront, size: 48, color: AppTheme.primaryPink),
      ),
    );
  }

  Widget _buildQueueBadge(QueueLoad load) {
    Color color;
    String label;
    switch (load) {
      case QueueLoad.low:
        color = AppTheme.successGreen;
        label = 'Low Wait';
        break;
      case QueueLoad.medium:
        color = AppTheme.warningOrange;
        label = 'Busy';
        break;
      case QueueLoad.high:
        color = AppTheme.errorRed;
        label = 'High Wait';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppTheme.primaryPink),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 13,
            color: AppTheme.textDark,
          ),
        ),
      ],
    );
  }
}
