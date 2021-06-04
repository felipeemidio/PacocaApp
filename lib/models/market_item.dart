class MarketItem {
  int id;
  String name;
  double price;
  bool selected = false;

  MarketItem(int id, String name) {
    this.id = id;
    this.name = name;
    this.price = 0.0;
    this.selected = false;
  }

  toggleSelection() {
    selected = !selected;
  }

  @override
  String toString() {
    return 'MarketItem {id: $id, name: $name, price: $price, selected: $selected}\n';
  }
}
