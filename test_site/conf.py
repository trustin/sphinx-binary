# -*- coding: utf-8 -*-

import sys, os
from recommonmark.parser import CommonMarkParser
import yaml

import alabaster
import guzzle_sphinx_theme
import sphinx_bootstrap_theme
import sphinx_rtd_theme

# Ensure we can load a YAML file.
with open('test.yaml', 'r') as stream:
    test_yaml = yaml.load(stream)
    assert test_yaml[0] == 'a'
    assert test_yaml[1] == 'b'
    assert test_yaml[2] == 'c'

# Make sure all theme modules are loaded correctly.
alabaster.get_path()
guzzle_sphinx_theme.html_theme_path()
sphinx_bootstrap_theme.get_html_theme_path()
sphinx_rtd_theme.get_html_theme_path()

project = u'sphinx-maven-plugin'
copyright = u'2016, Trustin Lee et al'
version = '1.7'
release = '1.7.0'

# General options
needs_sphinx = '1.0'
master_doc = 'index'
pygments_style = 'tango'
add_function_parentheses = True

extensions = ['sphinx.ext.autodoc', 'javasphinx', 'sphinxcontrib.httpdomain',
              'sphinxcontrib.inlinesyntaxhighlight', 'sphinxcontrib.plantuml']

templates_path = ['_templates']
exclude_trees = ['.build']
source_suffix = ['.rst', '.md']
source_encoding = 'utf-8-sig'
source_parsers = {
  '.md': CommonMarkParser
}

# HTML options
html_theme = 'sphinx_rtd_theme'
html_short_title = "sphinx-maven-plugin"
htmlhelp_basename = 'sphinx-maven-plugin-doc'
html_use_index = True
html_show_sourcelink = False
html_static_path = ['_static']

# PlantUML options
plantuml = "java -jar plantuml-8059.jar"
