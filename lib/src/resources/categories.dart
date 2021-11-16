class CategorieModel {
  String categorieName;
  String imageAssetUrl;
  CategorieModel(this.categorieName, this.imageAssetUrl);
}

List<CategorieModel> getCategories() {
  List<CategorieModel> categories = [];
  CategorieModel categorieModel;

  categorieModel = new CategorieModel("regional",
      "https://images.unsplash.com/photo-1614107151491-6876eecbff89?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cmVnaW9uYWx8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60");
  categories.add(categorieModel);

  categorieModel = new CategorieModel("technology",
      "https://images.unsplash.com/photo-1488590528505-98d2b5aba04b?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8dGVjaG5vbG9neXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60");
  categories.add(categorieModel);

  categorieModel = new CategorieModel("lifestyle",
      "https://images.unsplash.com/photo-1508672019048-805c876b67e2?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8bGlmZXN0eWxlfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60");
  categories.add(categorieModel);

  categorieModel = new CategorieModel("business",
      "https://images.unsplash.com/photo-1578574577315-3fbeb0cecdc2?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8YnVzaW5lc3N8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60");
  categories.add(categorieModel);

  categorieModel = new CategorieModel("general",
      "https://images.unsplash.com/photo-1489533119213-66a5cd877091?ixid=MnwxMjA3fDB8MHxzZWFyY2h8N3x8Z2VuZXJhbHxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60");
  categories.add(categorieModel);

  categorieModel = new CategorieModel("programming",
      "https://images.unsplash.com/photo-1605379399642-870262d3d051?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cHJvZ3JhbW1pbmd8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60");
  categories.add(categorieModel);

  categorieModel = new CategorieModel("science",
      "https://images.unsplash.com/photo-1507413245164-6160d8298b31?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8c2NpZW5jZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60");
  categories.add(categorieModel);

  categorieModel = new CategorieModel("entertainment",
      "https://images.unsplash.com/photo-1603190287605-e6ade32fa852?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8ZW50ZXJ0YWlubWVudHxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60");
  categories.add(categorieModel);

  categorieModel = new CategorieModel("world",
      "https://images.unsplash.com/photo-1534294228306-bd54eb9a7ba8?ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8d29ybGR8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60");
  categories.add(categorieModel);

  categorieModel = new CategorieModel("sports",
      "https://images.unsplash.com/photo-1461896836934-ffe607ba8211?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8c3BvcnRzfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60");
  categories.add(categorieModel);

  categorieModel = new CategorieModel("finance",
      "https://images.unsplash.com/photo-1591696205602-2f950c417cb9?ixid=MnwxMjA3fDB8MHxzZWFyY2h8N3x8ZmluYW5jZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60");
  categories.add(categorieModel);

  categorieModel = new CategorieModel("academia",
      "https://images.unsplash.com/photo-1505664194779-8beaceb93744?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8YWNhZGVtaWF8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60");
  categories.add(categorieModel);

  categorieModel = new CategorieModel("politics",
      "https://images.unsplash.com/photo-1529107386315-e1a2ed48a620?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cG9saXRpY3N8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60");
  categories.add(categorieModel);

  categorieModel = new CategorieModel("health",
      "https://images.unsplash.com/photo-1498837167922-ddd27525d352?ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8aGVhbHRofGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60");
  categories.add(categorieModel);

  categorieModel = new CategorieModel("opinion",
      "https://images.unsplash.com/photo-1598363431659-330370aaaa7b?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8b3BpbmlvbnxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60");
  categories.add(categorieModel);

  categorieModel = new CategorieModel("food",
      "https://images.unsplash.com/photo-1432139509613-5c4255815697?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MzR8fGZvb2R8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60");
  categories.add(categorieModel);

  categorieModel = new CategorieModel("game",
      "https://images.unsplash.com/10/wii.jpg?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8Z2FtZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60");
  categories.add(categorieModel);

  return categories;
}
