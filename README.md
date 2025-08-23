# erp_using_mockapi_and_bloc

https://github.com/user-attachments/assets/af3b5442-e26b-4289-86d6-04205f41c35b

Ques: What is this Project?
Ans: 1) Sales Order Listing Page
        a) Pulled sales order data from a mock/dummy API.
        b) Displayed key details: Customer Name, Order Date, Total Amount, and Status (Pending/Delivered).
        c) Added filters such as Today’s Orders and Pending only.

2) Create New Sales Order Page
   a) Built a form with fields: Customer Name, Product (dropdown from API), Quantity, and Rate.
   b) Implemented auto-calculation of Total (Quantity × Rate).
   c) On save: mock-post to API → show confirmation → navigate back to listing page.

4) AI Reminder / High-Value Order Alert
   a) Triggered real-time alert if any order total > ₹10,000.
   b) Implemented using custom alert pop-up.
   c) Persisted alerts with SharedPreferences to re-display on app restart.

5) Daily Sales Summary Notification
   a) Displayed a summary pop-up on app launch: “You have X pending orders worth ₹Y”.
   b) Calculated dynamically from local/mock database.



Ques: What I used?
Ans: 1) Implemented BLoC state management to separate UI from business logic, enabling predictable state handling, scalability, and a clean architecture for long-term maintainability.
2) Integrated a Mock API for simulating backend communication and SharedPreferences to persist dark mode preferences, while improving the user experience with daily sales summaries and alerts for high-value orders.

