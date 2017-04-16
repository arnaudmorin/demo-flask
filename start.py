#!/usr/bin/python

import platform
import codecs
import yaml

from flask import Flask

app = Flask(__name__)

@app.route('/')
def homepage():
    html = """
<html><head>
<style>
html {
    background: url(http://thecatapi.com/api/images/get?format=src&type=gif) no-repeat center center fixed; 
    -webkit-background-size: cover;
    -moz-background-size: cover;
    -o-background-size: cover;
    background-size: cover;
}
h1 {
    color: white;
    top: 30%;
    position: absolute;
    width: 100%;
    font-size: 70px;
}
</style>
</head>"""

    html += """
<body><center>
<h1>hello from<br/>{}</h1>
</center></body></html>
""".format(
        platform.node(),
    )

    return html


if __name__ == "__main__":
    app.run(host='0.0.0.0')
