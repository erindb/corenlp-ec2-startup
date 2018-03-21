#! /usr/bin/env python

import json
import requests

"""
use corenlp server (see https://github.com/erindb/corenlp-ec2-startup)
to parse sentences: tokens, dependency parse
"""
def get_parse(sentence, depparse=True):
    sentence = sentence.replace("'t ", " 't ")
    if depparse:
        url = "http://localhost:12345?properties={annotators:'tokenize,ssplit,pos,depparse'}"
    else:
        url = "http://localhost:12345?properties={annotators:'tokenize,ssplit,pos'}"
    data = sentence
    parse_string = requests.post(url, data=data).text
    return parse_string

parse_string = get_parse("This is true because this other thing is true.")
parse = json.loads(parse_string)

print json.dumps(parse, indent=4, sort_keys=True)