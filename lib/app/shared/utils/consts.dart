// URLs
/// Ip padrap do emulador AVD.
const URL_BASE = 'http://10.0.2.2:3000/';
//const URL_BASE = 'http://Seu.Ip:3000/';

// Nomes das categorias
const CATEGORY_FOOD = 'food';
const CATEGORY_DRINK = 'drink';

// Nomes das subcategorias
const SUBCATEGORY_SAVORY = 'savory';
const SUBCATEGORY_PIZZA = 'pizza';
const SUBCATEGORY_HAMBURGER = 'hambrger';
const SUBCATEGORY_JUICE = 'juice';
const SUBCATEGORY_SMOOTHIE = 'smoothie';

// Usuario logado e seu carrinho
const LOGGED_USER_LOCAL_STORAGE_KEY = 'loggedUser';
const CURR_CART = 'cart';

// Nomes das tabelas.
const DATABASE_NAME = "salgadar.db";
const TABLE_USER_NAME = 'users';
const TABLE_ITEM_NAME = 'items';
const TABLE_CART_NAME = 'carts';
const TABLE_ITEM_CART_NAME = 'items_cart';
const TABLE_PURCHASE_NAME = 'purchases';

// URL das tabelas (resources)
const URL_USER = URL_BASE + TABLE_USER_NAME;
const URL_ITEM = URL_BASE + TABLE_ITEM_NAME;
const URL_CART = URL_BASE + TABLE_CART_NAME;
const URL_ITEM_CART = URL_BASE + TABLE_ITEM_CART_NAME;
const URL_PURCHASE = URL_BASE + TABLE_PURCHASE_NAME;

// Atributos de [TABLE_USER_NAME].
const USER_ID = 'id';
const USER_USERNAME = 'username';
const USER_PASSWORD = 'password';
const USER_NAME = 'name';
const USER_BIRTHDAY = 'birthday';
const USER_EMAIL = 'email';

// Atributos de [TABLE_ITEM_NAME].
const ITEM_ID = 'id';
const ITEM_NAME = 'name';
const ITEM_DESCRIPTION = 'description';
const ITEM_IMAGE = 'image';
const ITEM_CATEGORY = 'category';
const ITEM_SUBCATEGORY = 'subCategory';
const ITEM_PRICE = 'price';

// Atributos de [TABLE_CART_NAME].
const CART_ID = 'id';
const CART_ITEMS = 'items';

// Atributos de [TABLE_ITEM_CART_NAME].
const ITEM_CART_ITEMID = 'itemId';
const ITEM_CART_CARTID = 'cartId';
const ITEM_CART_QTT = 'qtt';
const ITEM_CART_ITEMPRICE = 'itemPrice';

// Atributos de [TABLE_PURCHASE_NAME].
const PURCHASE_USERID = 'userId';
const PURCHASE_CARTID = 'cartId';
const PURCHASE_TOTALVALUE = 'totalValue';
const PURCHASE_DATE = 'date';
const PURCHASE_ISDELETED = 'isDeleted';
