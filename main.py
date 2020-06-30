from flask import Flask, render_template, request, session, redirect
from flask_sqlalchemy import SQLAlchemy
from werkzeug import secure_filename
import smtplib
from flask_mail import Mail, Message
import json
import os
import math
from datetime import datetime

with open('config.json', 'r') as c:
	params = json.load(c) ["params"]


local_server = True
app = Flask(__name__)
app.secret_key = "secret-key"
app.config['UPLOAD_FOLDER'] = params['upload_location']
app.config.update(
	Mail_SERVER = 'smtp.gmail.com',
	MAIL_PORT = '465',
	MAIL_USE_SSL = True,
	MAIL_USERNAME = params['gmail_id'],
	MAIL_PASSWORD = params['gmail_pass']
)
mail = Mail(app)
if(local_server):
	app.config['SQLALCHEMY_DATABASE_URI'] = params["local_uri"]
else:
	app.config['SQLALCHEMY_DATABASE_URI'] = params["product_uri"]
db = SQLAlchemy(app)

class Contacts(db.Model):
	# sno, name, phone, msg, email, date
    sno = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(55), nullable=True)
    phone = db.Column(db.Integer, nullable=True)
    msg = db.Column(db.String(100), nullable=True)
    email = db.Column(db.String(65), nullable=True)
    date = db.Column(db.String(120))

class Posts(db.Model):
	# sno, title, slug, content, date
    sno = db.Column(db.Integer, primary_key=True)
    img_file = db.Column(db.String(70), nullable=True)
    title = db.Column(db.String(70), nullable=True)
    tagline = db.Column(db.String(60), nullable=True)
    slug = db.Column(db.String(25), nullable=False)
    content = db.Column(db.String(300), nullable=True)
    date = db.Column(db.String(120))


@app.route("/")
def home():
	posts = Posts.query.filter_by().all()
	last = math.ceil(len(posts)/int(params['no_of_posts']))
	page = request.args.get('page')
	if(not str(page).isnumeric()):
		page = 1
	page = int(page)
	posts = posts[(page-1)*int(params['no_of_posts']):(page-1)*int(params['no_of_posts'])+int(params['no_of_posts'])]

	if(page==1):
		prev = "#"
		next = "/?page=" + str(page+1)
	elif (page==last):
		prev = "/?page=" + str(page-1)
		next = "#"
	else:
		prev = "/?page=" + str(page-1)
		next = "/?page=" + str(page+1)

	return render_template('index.html', params = params, posts = posts, prev=prev, next=next)

@app.route("/post/<string:post_slug>", methods=['GET'])
def post_route(post_slug):
	post = Posts.query.filter_by(slug=post_slug).first()
	return render_template('post.html', params = params, post=post)

@app.route("/about")
def about():
	return render_template('about.html', params = params)

@app.route("/dashboard", methods = ['GET', 'POST'])
def dashboard():
	if ('user' in session and session['user'] == params["admin_user"]):
		posts = Posts.query.all()
		# return "Hello"
		return render_template('dashboard.html', params = params, posts = posts)

	if (request.method == "POST"):
		user_name = request.form.get('uname')
		user_password = request.form.get('upass')
		if(user_name == params['admin_user'] and user_password == params['admin_pass']):
			session['user'] = user_name
			posts = Posts.query.all()
			# return "Hellu World"
			return render_template('dashboard.html', params = params, posts = posts)

	return render_template('login.html', params = params)

@app.route("/edit/<string:sno>", methods = ['POST', 'GET'])
def edit(sno):
	if ('user' in session and session['user'] == params["admin_user"]):
		if request.method == 'POST':
			box_title = request.form.get('title')
			tagline = request.form.get('tagline')
			slug = request.form.get('slug')
			content = request.form.get('content')
			img_file = request.form.get('img_file')

			if sno == '0':
				post = Posts(img_file = img_file, title = box_title, tagline = tagline, slug = slug, content = content)
				db.session.add(post)
				db.session.commit()
			else:
				post = Posts.query.filter_by(sno=sno).first()
				post.title = box_title
				post.slug = slug
				post.contact = contact
				post.img_file = img_file
				post.tagline = tagline
				db.session.commit()
				return redirect('/edit/'+sno)

		post = Posts.query.filter_by(sno = sno).first()
		return render_template('edit.html', params = params, post = post)

@app.route("/logout")
def logout():
	session.pop('user')
	return redirect('/dashboard')

@app.route("/delete/<string:sno>")
def delete(sno):
	if ('user' in session and session['user'] == params["admin_user"]):
		post = Posts.query.filter_by(sno=sno).first()
		db.session.delete(post)
		db.session.commit()
	return redirect('/dashboard')


@app.route("/uploader", methods = ['GET', 'POST'])
def uploader():
	if ('user' in session and session['user'] == params["admin_user"]):
		if (request.method == 'POST'):
			f = request.files['file1']
			f.save(os.path.join(app.config['UPLOAD_FOLDER'], secure_filename(f.filename)))
			# return "Uploaded Successfully"
			return redirect('/dashboard')


@app.route("/contact", methods = ['GET', 'POST'])
def contact():
	if(request.method=='POST'):
		# Add entry to database
		name = request.form.get('name')
		phone = request.form.get('phone')
		message = request.form.get('msg')
		email = request.form.get('email')
		entry = Contacts(name = name, phone = phone, msg = message, email = email, date = datetime.now())
		db.session.add(entry)
		db.session.commit()
		# mail.send_message( "New message from " + name, sender = email, recipients = [params['gmail_id']], body = message + '\n Contact: ' + phone )
		# mail.send_message( "New message from " + name, sender = "bhagabatiprasada@gmail.com", recipients = "sendmailfrom80@gmail.com", body = message + '\n Contact: ' + phone )

	return render_template('contact.html', params = params)

# @app.route("/post")
# def post():
# 	return render_template('post.html', params = params, post = Posts)


app.run(port=5000,debug=True)
