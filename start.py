import platform
import codecs
import yaml

from flask import Flask
#from flask_redis import Redis

app = Flask(__name__)
#app.config['REDIS_HOST'] = 'localhost'
#app.config['REDIS_DB'] = '5'
#app.config['REDIS_KEY'] = 'count'


# Locate the config file to use
app.config.from_object('config')

#redis = Redis(app)

@app.route('/')
def homepage():
#    count = redis.incr(app.config['REDIS_KEY'])
    return """
<html><head></head>
<body><center>
<h1>Hi, I\'m {}.</h1>
<!-- <h2>This page has been seen  times.</h2> -->
<a href="http://thecatapi.com">
 <img src="http://thecatapi.com/api/images/get?format=src&type=gif">
</a>
</center></body></html>
""".format(
        platform.node(),
#        count,
    )


if __name__ == "__main__":
    app.run(host='0.0.0.0')
