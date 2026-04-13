import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../modules/auth/screens/login_screen.dart';
import '../../modules/auth/screens/signup_screen.dart';
import '../../modules/auth/screens/splash_screen.dart';
import '../../modules/auth/screens/role_selection_screen.dart';
import '../../modules/auth/screens/otp_verification_screen.dart';
import '../../modules/auth/screens/set_password_screen.dart';
import '../../modules/auth/controllers/auth_controller.dart';
import '../models/user_role.dart';
import '../models/food_item.dart';
import '../models/order.dart';
import '../../modules/user/screens/user_dashboard_shell.dart';
import '../../modules/user/screens/canteen_details_screen.dart';
import '../../modules/user/screens/canteen_list_screen.dart';
import '../../modules/user/widgets/cart_screen.dart';
import '../../modules/user/screens/checkout_screen.dart';
import '../../modules/user/screens/order_tracking_screen.dart';
import '../../modules/user/screens/orders_history_screen.dart';
import '../../modules/user/screens/orders_history_screen.dart';
import '../../modules/user/screens/profile_screen.dart';
import '../../modules/user/widgets/user_home_screen.dart';
import '../../modules/vendor/screens/vendor_dashboard_shell.dart';
import '../../modules/vendor/screens/restaurant_home_screen.dart';
import '../../modules/vendor/screens/restaurant_orders_screen.dart';
import '../../modules/vendor/screens/menu_management_screen.dart';
import '../../modules/vendor/screens/add_food_item_screen.dart';
import '../../modules/vendor/screens/edit_food_item_screen.dart';
import '../../modules/vendor/screens/sales_screen.dart';
import '../../modules/vendor/screens/restaurant_profile_screen.dart';
import '../../modules/delivery/screens/delivery_dashboard_shell.dart';
import '../../modules/delivery/screens/delivery_home_screen.dart';
import '../../modules/delivery/screens/assigned_orders_screen.dart';
import '../../modules/delivery/screens/delivery_tracking_screen.dart';
import '../../modules/delivery/screens/delivery_profile_screen.dart';
import '../../modules/admin/screens/admin_dashboard_shell.dart';
import '../../modules/admin/screens/admin_home_screen.dart';
import '../../modules/admin/screens/admin_orders_screen.dart';
import '../../modules/admin/screens/canteen_management_screen.dart';
import '../../modules/admin/screens/add_canteen_screen.dart';
import '../../modules/admin/screens/delivery_management_screen.dart';
import '../../modules/admin/screens/analytics_screen.dart';
import '../../modules/admin/screens/admin_profile_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authControllerProvider);

  return GoRouter(
    initialLocation: '/splash',
    redirect: (context, state) {
      final isAuthRoute = state.uri.path == '/login' || 
                         state.uri.path == '/signup' || 
                         state.uri.path == '/splash' || 
                         state.uri.path == '/role-selection' ||
                         state.uri.path == '/verify-otp' ||
                         state.uri.path == '/set-password';
      
      if (authState == null) {
        return isAuthRoute ? null : '/splash';
      }

      // If user is authenticated but has a placeholder profile, 
      // they MUST finish setting their password/name first.
      if (authState.isPlaceholder) {
        if (state.uri.path == '/set-password') return null;
        return '/set-password';
      }

      if (isAuthRoute) {
        switch (authState.role) {
          case UserRole.admin:
            return '/admin/home';
          case UserRole.vendor:
            return '/vendor/home';
          case UserRole.delivery:
            return '/delivery/home';
          case UserRole.user:
          case UserRole.customer:
            return '/user/home';
        }
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/role-selection',
        name: 'role_selection',
        builder: (context, state) => const RoleSelectionScreen(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) {
          final role = state.extra as UserRole?;
          return LoginScreen(initialRole: role);
        },
      ),
      GoRoute(
        path: '/signup',
        name: 'signup',
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: '/verify-otp',
        name: 'verify_otp',
        builder: (context, state) => const OtpVerificationScreen(),
      ),
      GoRoute(
        path: '/set-password',
        name: 'set_password',
        builder: (context, state) => const SetPasswordScreen(),
      ),
      
      // User Dashboard with Shell
      ShellRoute(
        builder: (context, state, child) => UserDashboardShell(child: child),
        routes: [
          GoRoute(
            path: '/user/home',
            name: 'user_home',
            builder: (context, state) => const UserHomeScreen(),
          ),
          GoRoute(
            path: '/user/cart',
            name: 'user_cart',
            builder: (context, state) => const CartScreen(),
          ),
          GoRoute(
            path: '/user/orders',
            name: 'user_orders',
            builder: (context, state) => const OrderHistoryScreen(),
          ),
          GoRoute(
            path: '/user/profile',
            name: 'user_profile',
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),

      // Standalone User Screens
      GoRoute(
        path: '/user/canteen-list',
        name: 'canteen_list',
        builder: (context, state) => const CanteenListScreen(),
      ),
      GoRoute(
        path: '/user/canteen/:id',
        name: 'canteen_details',
        builder: (context, state) => CanteenDetailsScreen(
          canteenId: state.pathParameters['id']!,
        ),
      ),
      GoRoute(
        path: '/user/checkout',
        name: 'checkout',
        builder: (context, state) => const CheckoutScreen(),
      ),
      GoRoute(
        path: '/user/order-tracking/:id',
        name: 'order_tracking',
        builder: (context, state) => OrderTrackingScreen(
          orderId: state.pathParameters['id']!,
        ),
      ),

      // Restaurant Dashboard with Shell
      ShellRoute(
        builder: (context, state, child) => VendorDashboardShell(child: child),
        routes: [
          GoRoute(
            path: '/vendor/home',
            name: 'vendor_home',
            builder: (context, state) => const RestaurantHomeScreen(),
          ),
          GoRoute(
            path: '/vendor/orders',
            name: 'vendor_orders',
            builder: (context, state) => const RestaurantOrdersScreen(),
          ),
          GoRoute(
            path: '/vendor/menu',
            name: 'vendor_menu',
            builder: (context, state) => const MenuManagementScreen(),
          ),
          GoRoute(
            path: '/vendor/sales',
            name: 'vendor_sales',
            builder: (context, state) => const SalesScreen(),
          ),
          GoRoute(
            path: '/vendor/profile',
            name: 'vendor_profile',
            builder: (context, state) => const RestaurantProfileScreen(),
          ),
        ],
      ),

      // Standalone Restaurant Screens
      GoRoute(
        path: '/vendor/add-item',
        name: 'add_menu_item',
        builder: (context, state) => const AddFoodItemScreen(),
      ),
      GoRoute(
        path: '/vendor/edit-item/:id',
        name: 'edit_menu_item',
        builder: (context, state) {
          final item = state.extra as FoodItem;
          return EditFoodItemScreen(item: item);
        },
      ),
      // Delivery Dashboard with Shell
      ShellRoute(
        builder: (context, state, child) => DeliveryDashboardShell(child: child),
        routes: [
          GoRoute(
            path: '/delivery/home',
            name: 'delivery_home',
            builder: (context, state) => const DeliveryHomeScreen(),
          ),
          GoRoute(
            path: '/delivery/assigned',
            name: 'assigned_orders',
            builder: (context, state) => const AssignedOrdersScreen(),
          ),
          GoRoute(
            path: '/delivery/tracking/:id',
            name: 'delivery_tracking',
            builder: (context, state) {
              final order = state.extra as Order;
              return DeliveryTrackingScreen(order: order);
            },
          ),
          GoRoute(
            path: '/delivery/profile',
            name: 'delivery_profile',
            builder: (context, state) => const DeliveryProfileScreen(),
          ),
        ],
      ),

      // Admin Dashboard with Shell
      ShellRoute(
        builder: (context, state, child) => AdminDashboardShell(child: child),
        routes: [
          GoRoute(
            path: '/admin/home',
            name: 'admin_home',
            builder: (context, state) => const AdminHomeScreen(),
          ),
          GoRoute(
            path: '/admin/orders',
            name: 'admin_orders',
            builder: (context, state) => const AdminOrdersScreen(),
          ),
          GoRoute(
            path: '/admin/canteens',
            name: 'admin_canteens',
            builder: (context, state) => const CanteenManagementScreen(),
          ),
          GoRoute(
            path: '/admin/delivery',
            name: 'admin_delivery',
            builder: (context, state) => const DeliveryManagementScreen(),
          ),
          GoRoute(
            path: '/admin/analytics',
            name: 'admin_analytics',
            builder: (context, state) => const AnalyticsScreen(),
          ),
          GoRoute(
            path: '/admin/profile',
            name: 'admin_profile',
            builder: (context, state) => const AdminProfileScreen(),
          ),
        ],
      ),

      // Standalone Admin Screens
      GoRoute(
        path: '/admin/add-canteen',
        name: 'add_canteen',
        builder: (context, state) => const AddCanteenScreen(),
      ),
    ],
  );
});
