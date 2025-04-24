<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>RC Gold Shop</title>
  <link rel="stylesheet" href="styles.css" />
</head>
<body>
  <header>
    <h1>Gold Shop</h1>
  </header>

  <main>
    <section id="product-list" class="product-grid"></section>
    <section id="cart" class="cart">
      <h2>Shopping Cart</h2>
      <ul id="cart-items"></ul>
      <p>Total: <span id="cart-total">$0</span></p>
      <form id="checkout-form">
        <input type="text" id="customer-name" placeholder="Your Name" required />
        <input type="email" id="customer-email" placeholder="Your Email" required />
        <button type="submit">Submit Order</button>
      </form>
    </section>
  </main>

  <script src="script.js"></script>
</body>
</html>

/* styles.css */
body {
  font-family: Arial, sans-serif;
  margin: 0;
  padding: 0;
  background: #f9f7f3;
}

header {
  background-color: #ffd700;
  padding: 1rem;
  text-align: center;
  color: #fff;
}

.product-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 1rem;
  padding: 1rem;
}

.product-card {
  background: white;
  border-radius: 10px;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
  overflow: hidden;
  text-align: center;
}

.product-card img {
  width: 100%;
  height: 200px;
  object-fit: cover;
}

.product-card h2 {
  margin: 0.5rem 0;
}

.product-card p {
  color: #b6862c;
  font-weight: bold;
}

.product-card button {
  background-color: #ffd700;
  border: none;
  color: #fff;
  padding: 0.5rem 1rem;
  margin: 0.5rem 0;
  cursor: pointer;
  border-radius: 5px;
}

.cart {
  padding: 1rem;
  background: #fff;
  margin: 1rem;
  border-radius: 10px;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

.cart ul {
  list-style: none;
  padding: 0;
}

.cart li {
  padding: 0.5rem 0;
  border-bottom: 1px solid #eee;
}

#checkout-form {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
  margin-top: 1rem;
}

#checkout-form input, #checkout-form button {
  padding: 0.5rem;
  border-radius: 5px;
  border: 1px solid #ccc;
}

#checkout-form button {
  background-color: #ffd700;
  color: white;
  border: none;
  cursor: pointer;
}

/* script.js */
let cart = [];

function updateCart() {
  const cartList = document.getElementById("cart-items");
  const cartTotal = document.getElementById("cart-total");
  cartList.innerHTML = "";
  let total = 0;
  cart.forEach((item) => {
    const li = document.createElement("li");
    li.textContent = `${item.name} - ${item.price}`;
    cartList.appendChild(li);
    total += parseFloat(item.price.replace(/[^0-9.]/g, ""));
  });
  cartTotal.textContent = `$${total.toFixed(2)}`;
}

document.addEventListener("DOMContentLoaded", () => {
  fetch("/api/products.php")
    .then((res) => res.json())
    .then((products) => {
      const container = document.getElementById("product-list");
      container.innerHTML = products
        .map(
          (p) => `
          <div class="product-card">
            <img src="${p.image}" alt="${p.name}" />
            <h2>${p.name}</h2>
            <p>${p.price}</p>
            <button onclick='addToCart(${JSON.stringify(p)})'>Add to Cart</button>
          </div>
        `
        )
        .join("");
    });

  document.getElementById("checkout-form").addEventListener("submit", function (e) {
    e.preventDefault();
    const name = document.getElementById("customer-name").value;
    const email = document.getElementById("customer-email").value;

    fetch("/api/checkout.php", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        name,
        email,
        cart,
      }),
    })
      .then((res) => res.json())
      .then((data) => {
        alert(data.message);
        cart = [];
        updateCart();
        document.getElementById("checkout-form").reset();
      });
  });
});

function addToCart(product) {
  cart.push(product);
  updateCart();
}

// api/checkout.php
<?php
$host = 'localhost';
$db = 'goldshop';
$user = 'root';
$pass = '';
$conn = new mysqli($host, $user, $pass, $db);
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

$data = json_decode(file_get_contents("php://input"), true);
$name = $conn->real_escape_string($data['name']);
$email = $conn->real_escape_string($data['email']);
$cart = json_encode($data['cart']);

$sql = "INSERT INTO orders (customer_name, customer_email, cart) VALUES ('$name', '$email', '$cart')";

if ($conn->query($sql) === TRUE) {
  echo json_encode(["message" => "Order placed successfully!"]);
} else {
  echo json_encode(["message" => "Error: " . $conn->error]);
}
?>

-- SQL to create orders table --
CREATE TABLE orders (
  id INT AUTO_INCREMENT PRIMARY KEY,
  customer_name VARCHAR(255),
  customer_email VARCHAR(255),
  cart TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
