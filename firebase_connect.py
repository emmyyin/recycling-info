import firebase_admin
from firebase_admin import db
import json

# Database keys
RECYCLEABLES = "recycleables"       # ID: (NAMES, TYPE, RECYCLE_PLACES, HAZARDUOS)
NAMES = "names"
RECYCLE_PLACES = "recycle_places"
HAZARDUOS_MATERIALS = "hazardous"

def init():
    global ROOT
    cred = firebase_admin.credentials.Certificate("recycle-info-firebase-adminsdk.json")
    firebase_admin.initialize_app(cred)
    fd = open('recycle-info-firebase-adminsdk.json','r')
    data = json.load(fd)
    ROOT = db.reference(url=f"https://{data['project_id']}-default-rtdb.europe-west1.firebasedatabase.app/")
    fd.close()
    print("initialized")

def insert_recycleable(recycleable, post):
    """ Insert new recycleable """
    ROOT.child(RECYCLEABLES).child(recycleable).set(post)

def insert_name(recycleable, post):
    """ Insert new associated name """
    ROOT.child(RECYCLEABLES).child(recycleable).child(NAMES).push(post)

def insert_recycle_place(recycleable, post):
    """ Insert new associated recycle place """
    ROOT.child(RECYCLEABLES).child(recycleable).child(RECYCLE_PLACES).push(post)

def insert_hazarduos_material(recycleable, post):
    """ Insert new associated hazarduos material """
    ROOT.child(RECYCLEABLES).child(recycleable).child(HAZARDUOS_MATERIALS).push(post)
