#!/usr/bin/python

import toml
import json

class FilterModule(object):

    def filters(self):
        return {'from_toml': self.from_toml, 'to_toml': self.to_toml}


    def from_toml(self, toml_string):
        return toml.loads(toml_string)


    def to_toml(self, yaml_variable):
        s = json.dumps(dict(yaml_variable))
        d = json.loads(s)
        return toml.dumps(d)
