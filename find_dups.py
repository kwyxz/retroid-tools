#!/usr/bin/env python3

"""
find duplicates in DAT files
"""

import argparse
import xml.etree.ElementTree as ET

parser = argparse.ArgumentParser(
    prog='find_dup',
    description='find duplicates in DAT files')
parser.add_argument('datfile', type=argparse.FileType('r'))
args = parser.parse_args()

tree = ET.parse(args.datfile)
root = tree.getroot()

game_list = {}
dups = {}

for game in root.findall('game'):
    name = game.get('name')
    rom = game.find('rom').get('name')
    if name in game_list:
        if name in dups:
            dups[name].append(rom)
        else:
            dups[name] = [game_list[name],rom]
    else:
        game_list[name] = rom

for gamename, romname in sorted(dups.items()):
    print(f"=== GAME : {gamename}")
    for romfile in romname:
        print(f" \"{romfile}\"")

