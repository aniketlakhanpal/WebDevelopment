# WebDevelopment
# Simple Website with Python (Flask)

This project demonstrates a simple website developed using Flask, a Python web framework, for basic user registration, login functionality, and a contact form. User registration details and contact form submissions are stored in text files.

## Features

- **User Registration:** Allows users to register by providing a username and password.
- **Login System:** Allows registered users to log in with their credentials.
- **Contact Form:** Provides a form for users to submit their name, email, and a message.

## Files and Directories

- **`app.py`:** Flask application file containing server-side logic.
- **`templates/`:** Directory containing HTML templates for different pages.
  - **`home.html`:** Homepage of the website.
  - **`login.html`:** Login page.
  - **`register.html`:** User registration page.
  - **`contact.html`:** Contact form page.
- **`static/`:** Directory containing static files (CSS, JS).
  - **`style.css`:** CSS file for styling the web pages.
- **`user_credentials.txt`:** Text file to store registered user credentials.
- **`contact_submissions.txt`:** Text file to store contact form submissions.

## Usage

1. Clone the repository to your local machine.
2. Install Flask using the following command:
   ```bash
   pip install flask
3. Access the website through the browser.
4. Explore the different pages: Login, Register, Contact Us.
5. Registration details and contact form submissions will be stored in text files (`user_credentials.txt` and `contact_submissions.txt`).
