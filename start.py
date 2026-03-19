#!/usr/bin/env python3

import os
import platform
from flask import Flask

app = Flask(__name__)
api = os.environ.get('CAT_API_URL') or 'https://cat.arnaudmorin.fr/cat'


@app.route('/')
def homepage():
    html = """
<html><head>
<style>
html {
"""
    html += f"background: url({api}) no-repeat center center fixed;"
    html += """
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
</head>
<body><center>"""
    html += f"<h1>hello from<br/>{platform.node()}</h1></center></body></html>"

    return html


if __name__ == "__main__":
    app.run(host='0.0.0.0', port=8080, debug=False)
