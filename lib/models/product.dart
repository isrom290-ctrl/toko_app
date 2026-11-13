class Product {
  final int id;
  final String name;
  final double price;
  final String imageUrl;
  final String description;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.description,
  });

  String get formattedPrice => formatRupiah(price);
}

// Format angka: 450000 -> "Rp 450.000"
String formatRupiah(double value) {
  final s = value.toStringAsFixed(0);
  final buffer = StringBuffer();
  for (int i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) buffer.write('.');
    buffer.write(s[i]);
  }
  return 'Rp $buffer';
}

// Cari produk berdasarkan id; null jika tidak ada
Product? findProductById(int id) {
  for (final product in dummyProducts) {
    if (product.id == id) return product;
  }
  return null;
}

const List<Product> dummyProducts = [
  Product(
    id: 1,
    name: 'Sepatu Lari',
    price: 450000,
    imageUrl: 'https://down-id.img.susercontent.com/file/id-11134207-7r98z-loqkd2ocdnbud3',
    description: 'Sepatu lari ringan dengan sol empuk untuk latihan harian.',
  ),
  Product(
    id: 2,
    name: 'Tas Ransel',
    price: 275000,
    imageUrl: 'https://down-id.img.susercontent.com/file/58b1ea1b78d790ec880a103032a0ca15',
    description: 'Ransel 20 liter dengan slot laptop 14 inci.',
  ),
  Product(
    id: 3,
    name: 'Jam Tangan',
    price: 820000,
    imageUrl: 'https://down-id.img.susercontent.com/file/id-11134207-7r98t-lm4i1188alji11',
    description: 'Jam tangan analog tahan air hingga 50 meter.',
  ),
  Product(
    id: 4,
    name: 'Headphone',
    price: 650000,
    imageUrl: 'https://cdn.pixabay.com/photo/2020/04/19/16/33/headphones-5064411_1280.jpg',
    description: 'Headphone nirkabel dengan baterai tahan 30 jam.',
  ),
  Product(
    id: 5,
    name: 'Botol Minum',
    price: 95000,
    imageUrl: 'https://down-id.img.susercontent.com/file/id-11134207-7r98z-lp6ohunw2u1a21',
    description: 'Botol stainless 750 ml, menjaga suhu hingga 12 jam.',
  ),
];