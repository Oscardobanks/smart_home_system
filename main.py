# This is a sample Python script.
from flask import Flask, request
import serial
import firebase_admin
from firebase_admin import credentials
from firebase_admin import db

# Press Shift+F10 to execute it or replace it with your code.
# Press Double Shift to search everywhere for classes, files, tool windows, actions, and settings.

app = Flask(__name__)

led_status = False
# arduino = serial.Serial('COM3', 9600)  # Replace with your Arduino port

cred = credentials.Certificate("credentials.json")
firebase_admin.initialize_app(cred, {
    'databaseURL': 'https://console.firebase.google.com/u/1/project/smart-home-2f535/database/smart-home-2f535-default-rtdb/data/~2F'
})


@app.route('/devices/2', methods=['POST'])
def control_led():
    global led_status
    status = request.form['status']

    if status.lower() == 'on':
        led_status = True
        # Code to turn on the LED

    elif status.lower() == 'off':
        led_status = False
        # Code to turn off the LED

    # Update the LED state in Firebase Firestore
    doc_ref = db.collection('devices').document('Lights')
    doc_ref.set({'status': led_status})

    return 'LED status updated'


# Press the green button in the gutter to run the script.
if __name__ == '__main__':
    app.run(debug=True)

# See PyCharm help at https://www.jetbrains.com/help/pycharm/
