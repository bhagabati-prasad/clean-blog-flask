from flask import Flask, render_template
app = Flask(__name__)

@app.route("/")
def hello():
	return render_template('index.html')

@app.route("/about")
def about():
	name = "Bond"
	return render_template('about.html', person = name)

app.run(debug=True)