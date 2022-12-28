import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';

class EndGameModal extends StatelessWidget {
  final VoidCallback? onRetry;
  final String text;

  const EndGameModal({
    required this.text,
    this.onRetry,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.8),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Fim de Jogo",
              style: TextStyle(
                fontSize: 24,
                fontFamily: "press start2p regular",
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          IconButton(
            onPressed: onRetry,
            iconSize: 50,
            icon: const Icon(
              CommunityMaterialIcons.restart,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
