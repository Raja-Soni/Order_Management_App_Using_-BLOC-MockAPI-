# 📦 Order Management App (Flutter - Android)

https://github.com/user-attachments/assets/d234366b-ef37-4d4d-8586-7bf25554fd39

## ❓ What is this Project?

1. **Sales Order Listing Page**  
   - Pulled order data from a mock/dummy API.  
   - Displayed key details: **Customer Name, Order Date, Total Amount, and Status** (Pending / Delivered / Cancelled) ordered newest to oldest.  
   - Implemented **pagination** for scalability.  
   - Added filters: *All Orders*, *Today’s Orders*, *Pending*, *Delivered*, *Cancelled*.  
   - Supported **order deletion** for better management.  

2. **Create New Sales Order Page**  
   - Built a dynamic form with **Customer Name** and an **Add Item button**.  
   - On clicking *Add Item*, a pop-up form appears with fields: **Item Name, Quantity, and Price** (with validation).  
   - Added items are displayed in a **hidden ListView** (visible only when items exist), showing: *Name, Qty, Price, Item Total*.  
   - Implemented real-time **auto-calculation** of the total order amount as items are added or removed.  
   - Provided a **remove button** for each list item, allowing users to delete items and auto-update the total.  
   - If no items are added, the total remains **₹0** and item list is hidden.  
   - On save: mock-post to API → show confirmation → navigate back to listing.  

3. **Detailed Order Page**  
   - Accessible by tapping any order in the listing.  
   - Displayed **full order details** with all ordered items.  
   - Allowed **real-time status updates** (Pending, Delivered, Cancelled).  

4. **High-Value Order Alert**  
   - Triggered alert when an order total **> ₹10,000**.  
   - Persisted with `SharedPreferences` to show **only once** after app restart.  

5. **Daily Sales Summary Notification**  
   - Showed summary on app launch:  
     *"In the last 10 orders, X are pending worth ₹Y."*  
   - Calculated dynamically from local/mock database.  

---

## ⚙️ What I Used

- **Flutter & BLoC State Management** → Separated UI from business logic for predictable state handling, scalability, and clean architecture.  
- **Mock API** → Simulated backend communication for listing, creating, and updating orders.  
- **SharedPreferences** → Persisted dark mode preferences, one-time high-value order alerts, and app-level settings.  

---

**Brief Summary**

An Android application built with Flutter for managing orders efficiently. It supports order listing, creation, deletion, and advanced filtering (All, Today’s, Pending, Delivered, Cancelled) with real-time status updates. Features include detailed order views, a dynamic New Order page with itemized lists and auto-calculated totals, daily sales summaries, one-time high-value order alerts, dark mode persistence, and clean architecture using BLoC with Mock API integration.
