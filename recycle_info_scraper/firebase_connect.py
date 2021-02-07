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
    path = "recycle-info-firebase-adminsdk.json"
    cred = firebase_admin.credentials.Certificate(path)
    firebase_admin.initialize_app(cred)
    fd = open(path,'r')
    data = json.load(fd)
    ROOT = db.reference(url=f"https://{data['project_id']}-default-rtdb.europe-west1.firebasedatabase.app/")
    fd.close()
    print("initialized")

def get_key():
    return ROOT.push().key

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
