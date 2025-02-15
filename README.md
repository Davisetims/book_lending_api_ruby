# 📚 Book Lending System

A simple book lending system built with **Ruby on Rails** that allows users to **borrow and return books**. The system also provides a user profile page displaying currently borrowed books.

---

## 🚀 Features

- **User Authentication** (via Devise)
- **View available books**
- **Borrow books**
- **Return borrowed books**
- **User profile** with a list of borrowed books

---

## 🛠️ Technologies Used

- **Ruby on Rails** (Backend)
- **Devise** (User Authentication)
- **PostgreSQL** (Database)
- **Bootstrap** (UI Styling)

---

## 🔧 Installation

### **1. Clone the Repository**

```bash
git clone https://github.com/Davisetims/book_lending_api_ruby.git
cd book_lending_api
```

```bash
bundle install

rails db:create db:migrate db:seed
rails server

```

🔥 How to Use

1. Register / Login
   Visit http://localhost:3000/users/sign_up to create an account.
   Log in to access the system.
2. Borrow a Book
   Go to the books listing page.
   Click the Borrow button to borrow an available book.
   The book will be marked as unavailable until returned.
3. View Borrowed Books (User Profile)
   Click on Profile to see your borrowed books.
4. Return a Book
   In the profile section, click Return Book next to a borrowed book.
   The book will be marked as available again.
   🔗 API Endpoints
   Method Endpoint Description
   GET /books List all books
   POST /books/:id/borrow Borrow a book
   GET /profile View user profile
   PATCH /borrowings/:id/return_book Return a book
