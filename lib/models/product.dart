class Product {
  int id;
  String name;

  Product(int id, String name) {
    this.id = id;
    this.name = name;
  }

  @override
  String toString() {
    return 'Product {id: $id, name: $name}\n';
  }
}