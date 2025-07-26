import 'package:flutter/material.dart';

class CustomIconWidget extends StatelessWidget {
  final String iconName;
  final Color? color;
  final double size;

  const CustomIconWidget({
    Key? key,
    required this.iconName,
    this.color,
    this.size = 24.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    IconData? iconData;
    
    // Map icon names to Flutter icons
    switch (iconName.toLowerCase()) {
      case 'camera':
        iconData = Icons.camera;
        break;
      case 'flash_on':
        iconData = Icons.flash_on;
        break;
      case 'flash_off':
        iconData = Icons.flash_off;
        break;
      case 'flip_camera_android':
        iconData = Icons.flip_camera_android;
        break;
      case 'rotate_right':
        iconData = Icons.rotate_right;
        break;
      case 'zoom_in':
        iconData = Icons.zoom_in;
        break;
      case 'zoom_out':
        iconData = Icons.zoom_out;
        break;
      case 'refresh':
        iconData = Icons.refresh;
        break;
      case 'psychology':
        iconData = Icons.psychology;
        break;
      case 'share':
        iconData = Icons.share;
        break;
      case 'save':
        iconData = Icons.save;
        break;
      case 'history':
        iconData = Icons.history;
        break;
      case 'compare':
        iconData = Icons.compare;
        break;
      case 'close':
        iconData = Icons.close;
        break;
      case 'check_circle':
        iconData = Icons.check_circle;
        break;
      case 'warning':
        iconData = Icons.warning;
        break;
      case 'info':
        iconData = Icons.info;
        break;
      case 'arrow_back':
        iconData = Icons.arrow_back;
        break;
      case 'arrow_forward':
        iconData = Icons.arrow_forward;
        break;
      case 'add':
        iconData = Icons.add;
        break;
      case 'remove':
        iconData = Icons.remove;
        break;
      case 'edit':
        iconData = Icons.edit;
        break;
      case 'delete':
        iconData = Icons.delete;
        break;
      case 'search':
        iconData = Icons.search;
        break;
      case 'menu':
        iconData = Icons.menu;
        break;
      case 'more_vert':
        iconData = Icons.more_vert;
        break;
      case 'favorite':
        iconData = Icons.favorite;
        break;
      case 'favorite_border':
        iconData = Icons.favorite_border;
        break;
      case 'star':
        iconData = Icons.star;
        break;
      case 'star_border':
        iconData = Icons.star_border;
        break;
      case 'star_half':
        iconData = Icons.star_half;
        break;
      case 'account_circle':
        iconData = Icons.account_circle;
        break;
      case 'settings':
        iconData = Icons.settings;
        break;
      case 'help':
        iconData = Icons.help;
        break;
      case 'logout':
        iconData = Icons.logout;
        break;
      case 'login':
        iconData = Icons.login;
        break;
      case 'person':
        iconData = Icons.person;
        break;
      case 'email':
        iconData = Icons.email;
        break;
      case 'phone':
        iconData = Icons.phone;
        break;
      case 'lock':
        iconData = Icons.lock;
        break;
      case 'visibility':
        iconData = Icons.visibility;
        break;
      case 'visibility_off':
        iconData = Icons.visibility_off;
        break;
      case 'calendar_today':
        iconData = Icons.calendar_today;
        break;
      case 'access_time':
        iconData = Icons.access_time;
        break;
      case 'location_on':
        iconData = Icons.location_on;
        break;
      case 'map':
        iconData = Icons.map;
        break;
      case 'notifications':
        iconData = Icons.notifications;
        break;
      case 'notifications_none':
        iconData = Icons.notifications_none;
        break;
      case 'notifications_off':
        iconData = Icons.notifications_off;
        break;
      case 'done':
        iconData = Icons.done;
        break;
      case 'cancel':
        iconData = Icons.cancel;
        break;
      case 'error':
        iconData = Icons.error;
        break;
      case 'check':
        iconData = Icons.check;
        break;
      case 'clear':
        iconData = Icons.clear;
        break;
      case 'arrow_upward':
        iconData = Icons.arrow_upward;
        break;
      case 'arrow_downward':
        iconData = Icons.arrow_downward;
        break;
      case 'arrow_back_ios':
        iconData = Icons.arrow_back_ios;
        break;
      case 'arrow_forward_ios':
        iconData = Icons.arrow_forward_ios;
        break;
      case 'chevron_left':
        iconData = Icons.chevron_left;
        break;
      case 'chevron_right':
        iconData = Icons.chevron_right;
        break;
      case 'expand_more':
        iconData = Icons.expand_more;
        break;
      case 'expand_less':
        iconData = Icons.expand_less;
        break;
      case 'home':
        iconData = Icons.home;
        break;
      case 'dashboard':
        iconData = Icons.dashboard;
        break;
      case 'list':
        iconData = Icons.list;
        break;
      case 'grid_on':
        iconData = Icons.grid_on;
        break;
      case 'view_list':
        iconData = Icons.view_list;
        break;
      case 'view_module':
        iconData = Icons.view_module;
        break;
      default:
        // Return a default icon if the name is not found
        iconData = Icons.help_outline;
    }

    return Icon(
      iconData,
      color: color,
      size: size,
    );
  }
}
