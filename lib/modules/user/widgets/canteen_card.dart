import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/models/canteen.dart';

class CanteenCard extends StatelessWidget {
  final Canteen canteen;
  final VoidCallback onTap;

  const CanteenCard({
    super.key,
    required this.canteen,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: canteen.imageUrl.startsWith('http')
                        ? Image.network(
                            canteen.imageUrl,
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
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: canteen.isOpen ? AppTheme.successGreen : AppTheme.errorRed,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      canteen.isOpen ? 'OPEN' : 'CLOSED',
                      style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
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
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.star, color: AppTheme.warningOrange, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          canteen.rating.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
                if (!canteen.isOpen)
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
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          canteen.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textDark,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      _buildQueueBadge(canteen.queueLoad),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined, size: 14, color: AppTheme.textLight),
                      const SizedBox(width: 4),
                      Text(
                        canteen.location,
                        style: const TextStyle(color: AppTheme.textLight, fontSize: 13),
                      ),
                      const SizedBox(width: 8),
                      const Text('•', style: TextStyle(color: AppTheme.textLight)),
                      const SizedBox(width: 8),
                      Text(
                        '${canteen.distance} km',
                        style: const TextStyle(color: AppTheme.textLight, fontSize: 13),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _buildInfoTile(Icons.access_time_rounded, '${canteen.avgPrepTimeMinutes} mins'),
                      const SizedBox(width: 16),
                      _buildInfoTile(Icons.local_fire_department_outlined, 'Trending'),
                    ],
                  ),
                ],
              ),
            ),
          ],
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
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppTheme.primaryPink),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
            color: AppTheme.textDark,
          ),
        ),
      ],
    );
  }
}
