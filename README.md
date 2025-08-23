# erp_using_mockapi_and_bloc

https://github.com/user-attachments/assets/af3b5442-e26b-4289-86d6-04205f41c35b

## ❓ Ques: What is this Project?

**Ans:**

1. **Sales Order Listing Page**  
   - Pulled sales order data from a mock/dummy API.  
   - Displayed key details: Customer Name, Order Date, Total Amount, and Status (Pending/Delivered).  
   - Added filters such as *Today’s Orders* and *Pending only*.  

2. **Create New Sales Order Page**  
   - Built a form with fields: Customer Name, Product (dropdown from API), Quantity, and Rate.  
   - Implemented auto-calculation of Total (Quantity × Rate).  
   - On save: mock-post to API → show confirmation → navigate back to listing page.  

3. **AI Reminder / High-Value Order Alert**  
   - Triggered real-time alert if any order total > ₹10,000.  
   - Implemented using custom alert pop-up.  
   - Persisted alerts with `SharedPreferences` to re-display on app restart.  

4. **Daily Sales Summary Notification**  
   - Displayed a summary pop-up on app launch: *“You have X pending orders worth ₹Y”*.  
   - Calculated dynamically from local/mock database.  

---

## ❓ Ques: What I used?

**Ans:**

1. Implemented **BLoC state management** to separate UI from business logic, enabling predictable state handling, scalability, and a clean architecture for long-term maintainability.  
2. Integrated a **Mock API** for simulating backend communication and **SharedPreferences** to persist dark mode preferences, while improving the user experience with daily sales summaries and alerts for high-value orders.  

