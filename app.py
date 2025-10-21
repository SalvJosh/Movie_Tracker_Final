from flask import Flask, render_template
from extensions import db, bcrypt, login_manager
from models import User, Movie
import os
from dotenv import load_dotenv

# Load environment variables from .env file
load_dotenv()

# Initialize Flask app
app = Flask(__name__)
app.jinja_env.autoescape = True
app.config['SECRET_KEY'] = os.getenv('SECRET_KEY', 'default_secret')
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///site.db'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False  # Avoid unnecessary warnings

@app.route('/')
def home():
    return render_template('base.html')

# Initialize extensions with app
db.init_app(app)
bcrypt.init_app(app)
login_manager.init_app(app)

@login_manager.user_loader
def load_user(user_id):
    return User.query.get(int(user_id))

# Register Blueprints
def register_blueprints():
    from routes import app_routes
    app.register_blueprint(app_routes)

register_blueprints()

if __name__ == '__main__':
    app.run(debug=True)
