import sys
import json
from function import *


try:
    path = sys.argv[1]
    if validate_directory(path) == False:
        sys.exit(2)
    lexroid_path = validate_input(path)
    dictionary = {
        "path":f"{lexroid_path}"
    }
    with open("data/data.json", "w") as outfile:
        json.dump(dictionary, outfile)
        outfile.close()
    print(get_key('path', dictionary))
    sys.exit(0)

# if no argument had given to path_handler.py
except (IndexError):
    json_file = open('data/data.json')
    try :
        data = json.load(json_file)
        print(get_key('path', data))
    except (json.decoder.JSONDecodeError):
        json_file.close()
        # bash will recive the error
        sys.exit(1)