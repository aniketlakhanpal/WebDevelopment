from flask import Flask, render_template, request

app = Flask(__name__)

@app.route('/')
def home():
    return render_template('home.html')

@app.route('/login', methods=['POST'])
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']

        # Validate the username and password (not secure for production)
        with open('user_credentials.txt', 'a') as file:
            file.write(f'Username: {username}, Password: {password}\n')

        return 'Login successful!'

@app.route('/register', methods=['POST'])
def register():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']

        # Store user registration details in a text file (not secure for production)
        with open('user_credentials.txt', 'a') as file:
            file.write(f'Username: {username}, Password: {password}\n')

        return 'Registration successful!'

@app.route('/contact', methods=['POST'])
def contact():
    if request.method == 'POST':
        name = request.form['name']
        email = request.form['email']
        message = request.form['message']

        # Store contact form submission details in a text file (not secure for production)
        with open('contact_submissions.txt', 'a') as file:
            file.write(f'Name: {name}, Email: {email}, Message: {message}\n')

        return 'Form submission successful!'

if __name__ == '__main__':
    app.run(debug=True)
