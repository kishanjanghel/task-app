import 'dart:async';

import 'package:flutter/material.dart';

class Carousel3D extends StatefulWidget {
  const Carousel3D({super.key});

  @override
  State<Carousel3D> createState() => _Carousel3DState();
}

class _Carousel3DState extends State<Carousel3D> {
  final PageController _controller = PageController(viewportFraction: 0.5);
  double _currentPage = 0.0;
  Timer? _autoPlayTimer;

  final List<String> _originalImages = [
    'https://picsum.photos/id/1015/400/300',
    'https://picsum.photos/id/1016/400/300',
    'https://picsum.photos/id/1018/400/300',
    'https://picsum.photos/id/1019/400/300',
    'https://picsum.photos/id/1020/400/300',
  ];

  late List<String> imageUrls;

  @override
  void initState() {
    super.initState();
    imageUrls = List.generate(
        1000, (index) => _originalImages[index % _originalImages.length]);

    _controller.addListener(() {
      setState(() {
        _currentPage = _controller.page!;
      });
    });

    _autoPlayTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (_controller.hasClients) {
        final nextPage = _controller.page!.round() + 1;
        _controller.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.jumpToPage(imageUrls.length ~/ 2);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _autoPlayTimer?.cancel();
    super.dispose();
  }

  void _onTapCenter(String imageUrl, String tag) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => DetailsPage(imageUrl: imageUrl, tag: tag),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          title: const Text("3D Carousel"), backgroundColor: Colors.black),
      body: PageView.builder(
        controller: _controller,
        itemBuilder: (context, index) {
          final delta = index - _currentPage;
          final clampedDelta = delta.clamp(-1.0, 1.0);
          final isCenter = delta.abs() < 0.5;
          final imageUrl = imageUrls[index];
          final tag = 'image_$index';

          final transformed = Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(clampedDelta * -0.6)
              ..translate(0.0, isCenter ? -20.0 : 20.0)
              ..scale(isCenter ? 1.1 : 0.9),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 40),
              child: GestureDetector(
                onTap: () {
                  if (isCenter) {
                    _onTapCenter(imageUrl, tag);
                  }
                },
                child: Hero(
                  tag: tag,
                  child: Card(
                    elevation: isCenter ? 12 : 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    clipBehavior: Clip.antiAlias,
                    child: Image.network(imageUrl, fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
          );

          return transformed;
        },
      ),
    );
  }
}

class DetailsPage extends StatelessWidget {
  final String imageUrl;
  final String tag;

  const DetailsPage({super.key, required this.imageUrl, required this.tag});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.black),
      body: Center(
        child: Hero(
          tag: tag,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(imageUrl, fit: BoxFit.contain),
          ),
        ),
      ),
    );
  }
}
