# demo-flask
Demo Flask python app


## Installation
`pip3 install -r requirements.txt`

## Usage
### Start in foreground

`python3 start.py`

or

`./start.sh`


### Start in background

```
nohup ./start.sh &
```

or use the systemd service file provided:

```
cp demo-cat.service /etc/systemd/system/
systemctl enable demo-cat.service
systemctl daemon-reload
systemctl start demo-cat.service
```
