// OP1: insertMany() — insert all 3 documents from sample_documents.json
db.products.insertMany([
  {
    "product_id": "E1001",
    "name": "4K Smart TV",
    "category": "Electronics",
    "brand": "Sony",
    "price": 65000,
    "warranty_years": 2,
    "specs": {
      "screen_size_inches": 55,
      "resolution": "3840x2160",
      "hdmi_ports": 3,
      "voltage": "220V"
    },
    "tags": ["smart", "wifi", "hdr"]
  },
  {
    "product_id": "C2001",
    "name": "Men's Running Shoes",
    "category": "Clothing",
    "brand": "Nike",
    "price": 4500,
    "size_options": ["UK 7", "UK 8", "UK 9", "UK 10"],
    "material": {
      "upper": "mesh",
      "sole": "rubber"
    },
    "colors_available": ["black", "blue", "red"],
    "gender": "Male"
  },
  {
    "product_id": "G3001",
    "name": "Organic Almond Milk",
    "category": "Groceries",
    "brand": "HealthyLife",
    "price": 250,
    "volume_ml": 1000,
    "expiry_date": "2024-12-15",
    "nutritional_info": {
      "calories_per_100ml": 45,
      "protein_g": 1.2,
      "fat_g": 2.5
    },
    "is_refrigerated": true
  }
]);

// OP2: find() — retrieve all Electronics products with price > 20000
db.products.find({
  category: "Electronics",
  price: { $gt: 20000 }
});

// OP3: find() — retrieve all Groceries expiring before 2025-01-01
db.products.find({
  category: "Groceries",
  expiry_date: { $lt: "2025-01-01" }
});

// OP4: updateOne() — add a "discount_percent" field to a specific product
db.products.updateOne(
  { product_id: "E1001" },           // choose one specific product
  { $set: { discount_percent: 10 } } // e.g., 10% discount
);

// OP5: createIndex() — create an index on category field and explain why
db.products.createIndex({ category: 1 });
// This index speeds up queries that filter by category,
// such as finding all Electronics or all Groceries products.
