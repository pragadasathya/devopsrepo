<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Gold Shop</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #fef8e7;
      margin: 0;
      padding: 20px;
    }
    h1 {
      text-align: center;
      color: goldenrod;
    }
    .shop-container {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
      gap: 20px;
    }
    .item-card {
      border: 1px solid #e5c76e;
      border-radius: 10px;
      background-color: #fffef5;
      padding: 15px;
      text-align: center;
      box-shadow: 2px 2px 10px rgba(0,0,0,0.1);
    }
    .item-card img {
      width: 100px;
      height: 100px;
      object-fit: cover;
    }
    .item-name {
      font-size: 18px;
      font-weight: bold;
      color: #333;
    }
    .item-price {
      color: #8b8000;
      margin: 10px 0;
      font-size: 16px;
    }
    .buttons {
      display: flex;
      justify-content: center;
      gap: 10px;
    }
    .buttons button {
      padding: 5px 10px;
      border: none;
      background-color: goldenrod;
      color: white;
      border-radius: 5px;
      cursor: pointer;
    }
    .buttons button:hover {
      background-color: darkgoldenrod;
    }
  </style>
</head>
<body>

<h1>🪙 Gold Shop</h1>
<div class="shop-container">
  <!-- Item 1 -->
  <div class="item-card">
    <img src="https://example.com/gold-ring.jpg" alt="Gold Ring">
    <div class="item-name">Gold Ring</div>
    <div class="item-price">₹ 18,000</div>
    <div class="buttons">
      <button onclick="addToCart('Gold Ring')">Add</button>
      <button onclick="removeFromCart('Gold Ring')">Remove</button>
    </div>
  </div>

  <!-- Item 2 -->
  <div class="item-card">
    <img src="https://example.com/gold-chain.jpg" alt="Gold Chain">
    <div class="item-name">Gold Chain</div>
    <div class="item-price">₹ 35,000</div>
    <div class="buttons">
      <button onclick="addToCart('Gold Chain')">Add</button>
      <button onclick="removeFromCart('Gold Chain')">Remove</button>
    </div>
  </div>

  <!-- Item 3 -->
  <div class="item-card">
    <img src="https://example.com/gold-earrings.jpg" alt="Gold Earrings">
    <div class="item-name">Gold Earrings</div>
    <div class="item-price">₹ 22,000</div>
    <div class="buttons">
      <button onclick="addToCart('Gold Earrings')">Add</button>
      <button onclick="removeFromCart('Gold Earrings')">Remove</button>
    </div>
  </div>
</div>

<script>
  function addToCart(item) {
    alert(item + " added to cart!");
  }
  function removeFromCart(item) {
    alert(item + " removed from cart.");
  }
</script>

</body>
</html>
