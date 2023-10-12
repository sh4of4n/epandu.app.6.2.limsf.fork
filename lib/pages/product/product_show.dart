import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ProductShowPage extends StatefulWidget {
  const ProductShowPage({super.key});

  @override
  State<ProductShowPage> createState() => _ProductShowPageState();
}

class _ProductShowPageState extends State<ProductShowPage> {
  late PageController _pageController;
  int _currentPage = 0;
  final List<String> _photos = [
    'https://images.pexels.com/photos/90946/pexels-photo-90946.jpeg?cs=srgb&dl=pexels-math-90946.jpg&fm=jpg',
    'https://images.pexels.com/photos/90946/pexels-photo-90946.jpeg?cs=srgb&dl=pexels-math-90946.jpg&fm=jpg',
    'https://images.pexels.com/photos/90946/pexels-photo-90946.jpeg?cs=srgb&dl=pexels-math-90946.jpg&fm=jpg',
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 250,
                  width: double.infinity,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _photos.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return Image.network(
                        _photos[index],
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
                Positioned(
                    top: 16.0,
                    left: 16.0,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.grey[500], //<-- SEE HERE
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    )),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Product Name',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    'Price: \$100.00',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Product Description',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  const SizedBox(height: 24.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Add to Cart'),
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Buy Now'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  const Divider(),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Product Reviews',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  const ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://example.com/user-avatar.jpg',
                      ),
                    ),
                    title: Text('John Doe'),
                    subtitle: Text('Great product! Highly recommended.'),
                  ),
                  const ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://example.com/user-avatar.jpg',
                      ),
                    ),
                    title: Text('Jane Smith'),
                    subtitle: Text('Good quality and fast delivery.'),
                  ),
                  // Add more review list items as needed
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
