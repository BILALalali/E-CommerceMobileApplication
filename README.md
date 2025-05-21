
# Flutter E-Commerce App

A modern e-commerce mobile application built with **Flutter** and **Firebase**, featuring three distinct interfaces for **customers**, **sellers**, and **admins**.

<div align="center">
  <img src="assets/screenshots/role_selection.png" width="250" alt="Role Selection Screen"/>
  <img src="assets/screenshots/home_page.png" width="250" alt="Home Page"/>
  <img src="assets/screenshots/chatbot.png" width="250" alt="Chatbot"/>
</div>

---

## 🧠 Overview

This application allows:

- 💼 **Sellers** to register, manage their business info, upload products, and view orders.
- 🛍️ **Customers** to browse products, view detailed info, use smart search, and make purchases.
- 🛠️ **Admins** to manage categories, verify sellers, and update banners through a powerful admin panel.

An **AI-based recommendation engine** suggests similar products using **TF-IDF**, **Cosine Similarity**, and **MobileNet**.

---

## 🚀 Technologies Used

- **Flutter** + **Dart**
- **Firebase Auth**, Firestore, and Storage
- **Google Dialogflow** chatbot via `dialogflow_flutter`
- **Machine Learning (TF-IDF, Keras, MobileNet)**
- **Provider** for state management

---

## 📱 Features

### 🧾 Customer Interface

- Product browsing & filtering
- Product details with images, sizes, and delivery info
- Add to cart, quantity updates, and payment simulation
- Chatbot for customer support
- Personalized product recommendations

<div align="center">
  <img src="assets/screenshots/product_details.png" width="250"/>
  <img src="assets/screenshots/add_to_cart.png" width="250"/>
  <img src="assets/screenshots/similar_products.png" width="250"/>
</div>

---

### 🧑‍💼 Seller Interface

- Business registration and Firebase-based authentication (email, phone, Google)
- Product upload with multiple tabs: info, shipping, specs, images
- Orders and earnings dashboard

<div align="center">
  <img src="assets/screenshots/seller_dashboard.png" width="250"/>
  <img src="assets/screenshots/upload_product.png" width="250"/>
</div>

---

### 🛠 Admin Panel

- Manage vendors (approve/reject)
- Add/Edit categories
- Upload promotional banners
- Built with `AdminScaffold` and GoRouter

<div align="center">
  <img src="assets/screenshots/admin_dashboard.png" width="250"/>
  <img src="assets/screenshots/category_screen.png" width="250"/>
</div>

---

## 🧩 Project Structure

```
lib/
├── customer/
├── seller/
├── admin/
├── models/
├── providers/
├── chatbot/
└── main.dart
```

---

## 🛠 How to Run

1. Clone the repo:
   ```bash
   git clone https://github.com/yourusername/flutter_ecommerce_app.git
   ```

2. Get dependencies:
   ```bash
   flutter pub get
   ```

3. Add your Firebase credentials & Dialogflow `dialogflow.json` to the `assets` folder.

4. Run on emulator or device:
   ```bash
   flutter run
   ```

---

## 🧾 Credits

This app was developed as part of a graduation project. Special thanks to all the contributors and tools used during the development process.

---

## 📷 Screenshots

> Add your actual screenshots to `assets/screenshots/` and update image paths above.

---

## 📬 License

This project is licensed for educational and demonstration purposes.
