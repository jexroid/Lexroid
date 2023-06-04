import os

def validate_directory(value):
    if os.path.isdir(value):
        return True
    else:
        return False

def validate_input(value):
    rvalue = value.strip()
    if ((rvalue[-1])) == '/':
        new_val = rvalue[:-1]
    else:
        new_val = rvalue
    return new_val+'/lexroid'

def get_key(val, dict):
    for value, key in dict.items():
        if val == value:
            return key

