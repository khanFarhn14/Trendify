class ProductsUrl{
  static const String _baseUrl = 'https://fakestoreapi.com';

  static String allProductsUrl = '$_baseUrl/products';

  static String allCateogriesUrl = '$_baseUrl/products/categories';

  static String productSpecificCategoryUrl = '$_baseUrl/products/category/';

  static String sortDescProductUrl = '$_baseUrl/products?sort=desc';
  static String sortAscProductUrl = '$_baseUrl/products?sort=asc';
}

class AuthUrl{
  static String loginUrl = '${ProductsUrl._baseUrl}/auth/login';
}