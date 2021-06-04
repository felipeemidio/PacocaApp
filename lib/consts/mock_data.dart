import 'package:pacocaApp/models/market_item.dart';
import 'package:pacocaApp/models/market_list.dart';
import 'package:pacocaApp/models/product.dart';

List<Product> mockProductsList = [
  Product(1, 'Maçã'),
  Product(2, 'Ovos'),
  Product(3, 'Macarrão'),
  Product(4, 'Biscoito'),
  Product(5, 'Suco de Uva'),
  Product(6, 'Arroz'),
  Product(7, 'Sorvete'),
  Product(8, 'Queijo Coalho'),
];

List<MarketList> mockMarketLists = [
  MarketList(1, 'Lista de Teste')..items.addAll([MarketItem(1, 'Maçã'), MarketItem(4, 'Biscoito')])
];