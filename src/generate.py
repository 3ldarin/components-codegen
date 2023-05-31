#!/usr/bin/env python3

import json
import os
from jinja2 import Environment, FileSystemLoader, PackageLoader, select_autoescape

INPUTS_DIR="inputs"
OUTPUTS_DIR="outputs"

TYPESCRIPT_TYPE_MAP = {
    "bool": "boolean",
    "uint32": "number",
    "uint256": "BigNumberish",
    "string": "string",
    "address": "string",
}

COMPONENT_LIB_TYPE_MAP = {
    "bool": "TypesLibrary.SchemaValue.BOOLEAN",
    "uint32": "TypesLibrary.SchemaValue.UINT32",
    "uint256": "TypesLibrary.SchemaValue.UINT256",
    "string": "TypesLibrary.SchemaValue.STRING",
    "address": "TypesLibrary.SchemaValue.ADDRESS",
}

SOLIDITY_TYPE_MAP = {
    "bool": "bool",
    "uint32": "uint32",
    "uint256": "uint256",
    "string": "string",
    "address": "address",
}


# a function that takes in a dictionary of the format like bounty.json and outputs a new json with all the variable types changed using the TYPESCRIPT_TYPE_MAP
def add_language_specific_types(config):
    for var_idx in range(len(config["variables"])):
        if not "typescript_type" in config["variables"][var_idx]:
            config["variables"][var_idx]["typescript_type"] = TYPESCRIPT_TYPE_MAP[config["variables"][var_idx]["type"]]
            # raise Exception(f"Type {config.variables[var_idx]['type']} not found in TYPESCRIPT_TYPE_MAP")
        if not "component_lib_type" in config["variables"][var_idx]:
            config["variables"][var_idx]["component_lib_type"] = COMPONENT_LIB_TYPE_MAP[config["variables"][var_idx]["type"]]
        if not "solidity_type" in config["variables"][var_idx]:
            config["variables"][var_idx]["solidity_type"] = SOLIDITY_TYPE_MAP[config["variables"][var_idx]["type"]]
    return config

def enrich(config):
    return add_language_specific_types(config)

def main():
    env = Environment(
    loader=FileSystemLoader("templates"),
    autoescape=select_autoescape())

    for config_file in os.listdir(INPUTS_DIR):
        contents = open(os.path.join(INPUTS_DIR, config_file), "r").read()
        config = json.loads(contents)
        typescript_template = env.get_template("template.ts")
        solidity_template = env.get_template("template.sol")
        open(os.path.join(OUTPUTS_DIR, config_file + ".ts"), "w").write(typescript_template.render(**enrich(config)))
        open(os.path.join(OUTPUTS_DIR, config_file + ".sol"), "w").write(solidity_template.render(**enrich(config)))


if __name__ == "__main__":
    main()