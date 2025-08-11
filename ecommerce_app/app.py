from flask import Flask, render_template, request, redirect, url_for

app = Flask(__name__)

items = [
    {"id": 1, "name": "Laptop", "price": 50000, "image": "laptop.jpg"},
    {"id": 2, "name": "Phone", "price": 20000, "image": "phone.jpg"},
    {"id": 3, "name": "Headphones", "price": 2000, "image": "headphones.jpg"}
]

cart = []

@app.route('/')
def index():
    total_price = sum(item['price'] for item in cart)
    gst = total_price * 0.18
    grand_total = total_price + gst
    return render_template('index.html', items=items, cart=cart, total_price=total_price, gst=gst, grand_total=grand_total)

@app.route('/add/<int:item_id>')
def add_to_cart(item_id):
    for item in items:
        if item['id'] == item_id:
            cart.append(item)
            break
    return redirect(url_for('index'))

@app.route('/delete/<int:item_id>')
def delete_from_cart(item_id):
    global cart
    cart = [item for item in cart if item['id'] != item_id]
    return redirect(url_for('index'))

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
