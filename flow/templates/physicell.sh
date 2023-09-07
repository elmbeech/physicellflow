#!/usr/bin/env python3

# library
import os
import sys
import lxml.etree as ET
import pandas as pd

# const
s_pathfile_setting = '$p_setting'
s_pathfile_rule = '$p_rule'
s_init = '$s_init'
s_pathfile_init = '$p_init'
s_parameter = '$s_parameter'
s_xpath_parameter = '$xp_parameter'
r_parameter = '$r_parameter'
s_take = '$s_take'

# process setting.xml file
x_tree = ET.parse(s_pathfile_setting)
x_root = x_tree.getroot()

# manipulate parameter xml element
if s_xpath_parameter != 'None':
    lx_element = x_root.xpath(s_xpath_parameter)
    for x_element in lx_element:
        x_element.text = r_parameter

# manipulate output folder xml element
s_xpath_output = './/save/folder'
lx_element = x_root.findall(s_xpath_output)
if len(lx_element) != 1:
    print('xpath:', s_xpath_output)
    sys.exit(f'Error @ runPhysiCell : in {s_pathfile_setting}, found non or more than one element for xpath.')
s_out = f'ouput_{s_init}_{s_parameter}{r_parameter}_{s_take}'
os.mkdir(s_out)
lx_element[0].text = s_out

# maniplate rules xml element
s_xpath_rule = './/cell_rules/rulesets//filename'
lx_element = x_root.findall(s_xpath_rule)
if len(lx_element) != 1:
    print('xpath:', s_xpath_rule)
    sys.exit('Error @ runPhysiCell : in {s_pathfile_setting}, found non or more than one element for xpath.')
lx_element[0].text = s_pathfile_rule

# manipulate initial condition xml element
s_xpath_init = './/initial_conditions/cell_positions//filename'
lx_element = x_root.findall(s_xpath_init)
if len(lx_element) != 1:
     print('xpath:', s_xpath_init)
     sys.exit('Error @ runPhysiCell : in {s_pathfile_setting}, found non or more than one element for xpath.')
lx_element[0].text = s_pathfile_init

# write settings file
s_nfsetting = f"{s_pathfile_setting.replace('.xml','_')}{s_init}_{s_parameter}{r_parameter}.xml"
x_tree.write(
    s_nfsetting,
    xml_declaration='<?xml version="1.0" encoding="UTF-8"?>'
)

# process rule.csv file

# run dmc
os.system(f'physicell {s_nfsetting}')

