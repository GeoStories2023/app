import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geostories_app/consumer/settings/consumer_settings.dart';
import 'package:geostories_app/widgets/page_transitions.dart';

import '../auth/auth_service.dart';

class ProfilePicture extends StatelessWidget {
  final bool? _showName;
  final bool? _showNotifications;
  final bool? _showEmail;

  const ProfilePicture({super.key})
      : _showName = false,
        _showEmail = false,
        _showNotifications = false;

  const ProfilePicture.withName({super.key})
      : _showName = true,
        _showEmail = false,
        _showNotifications = false;

  const ProfilePicture.withEmail({super.key})
      : _showName = false,
        _showEmail = true,
        _showNotifications = false;

  const ProfilePicture.withNotifications({super.key})
      : _showName = false,
        _showEmail = false,
        _showNotifications = true;

  @override
  Widget build(BuildContext context) {
    if (_showName!) {
      return _buildWithName(context);
    }

    if (_showNotifications!) {
      return _buildWithNotifications(context);
    }

    if (_showEmail!) {
      return _buildWithEmail(context);
    }

    return Hero(
      tag: "profilePic",
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: _userImage(),
      ),
    );
  }

  Widget _buildWithNotifications(BuildContext context) {
    return Stack(
      children: [
        Hero(
          tag: "profilePic",
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: _userImage(),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: _notificationIndicator(),
        ),
      ],
    );
  }

  Widget _buildWithName(BuildContext context) {
    return Column(
      children: [
        Hero(
          tag: "profilePic",
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: _userImage(),
          ),
        ),
        Text(
          AuthService().currentUser?.displayName ?? "",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildWithEmail(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Hero(
            tag: "profilePic",
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: _userImage(),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: _settingsIcon(context),
          ),
        ],
      ),
    );
  }

  Widget _settingsIcon(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: GestureDetector(
        child: FaIcon(
          FontAwesomeIcons.cog,
          color: Colors.green[500],
        ),
        onTap: () => Navigator.of(context).push(
          slideLeftTransition(const ConsumerSettings()),
        ),
      ),
    );
  }

  Widget _userImage() {
    final String? url = AuthService().currentUser?.photoURL;
    if (url != null) {
      return Image.network(url, scale: 1.5);
    }
    return const FaIcon(FontAwesomeIcons.user);
  }

  Widget _notificationIndicator() {
    // TODO: replace with get notification count
    int notifications = 69;

    return Container(
      decoration: BoxDecoration(
          color: Colors.red, borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Text(
          notifications.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
