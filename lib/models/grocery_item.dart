class GroceryItem {
  int id;
  String name;
  double price;
  bool selected = false;

  GroceryItem(int id, String name, double price) {
    this.id = id;
    this.name = name;
    this.price = price;
    this.selected = false;
  }

  toggleSelection() {
    selected = !selected;
  }

  @override
  String toString() {
    return 'GroceryItem {id: $id, name: $name, price: $price, selected: $selected}\n';
  }
}
