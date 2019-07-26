# -*- coding: utf-8 -*-

import sys, os
import yaml

import alabaster
import sphinx_bootstrap_theme
import sphinx_rtd_theme

# Ensure we can load a YAML file.
with open('test.yaml', 'r') as stream:
    test_yaml = yaml.load(stream, Loader=yaml.FullLoader)
    assert test_yaml[0] == 'a'
    assert test_yaml[1] == 'b'
    assert test_yaml[2] == 'c'

# Make sure all theme modules are loaded correctly.
alabaster.get_path()
sphinx_bootstrap_theme.get_html_theme_path()
sphinx_rtd_theme.get_html_theme_path()

project = u'sphinx-binary-demo'
copyright = u'2018, Trustin Lee'
version = '1.0'
release = '1.0.0'

# General options
needs_sphinx = '1.0'
master_doc = 'index'
pygments_style = 'tango'
add_function_parentheses = True

extensions = ['sphinx.ext.autodoc', 'sphinx.ext.autosectionlabel', 'sphinx.ext.autosummary',
              'sphinx.ext.coverage', 'sphinx.ext.doctest', 'sphinx.ext.extlinks',
              'sphinx.ext.githubpages', 'sphinx.ext.graphviz', 'sphinx.ext.ifconfig',
              'sphinx.ext.imgconverter', 'sphinx.ext.inheritance_diagram', 'sphinx.ext.intersphinx',
              'sphinx.ext.linkcode', 'sphinx.ext.imgmath', 'sphinx.ext.napoleon', 'sphinx.ext.todo',
              'sphinx.ext.viewcode', 'sphinx_markdown_tables',
              'sphinxcontrib.httpdomain', 'sphinxcontrib.imagesvg', 'sphinxcontrib.openapi',
              'sphinxcontrib.plantuml', 'sphinxcontrib.redoc', 'sphinxcontrib.youtube',
              'sphinxemoji.sphinxemoji']

templates_path = ['_templates']
exclude_trees = ['.build']
source_suffix = ['.rst', '.md']
source_encoding = 'utf-8-sig'
source_parsers = {
  '.md': 'recommonmark.parser.CommonMarkParser'
}

# HTML options
#html_theme_path = 'alabaster'
#html_theme_path = [alabaster.get_path()]
html_theme = 'bootstrap'
html_theme_path = sphinx_bootstrap_theme.get_html_theme_path()
#html_theme = 'sphinx_rtd_theme'
#html_theme_path = [sphinx_rtd_theme.get_html_theme_path()]
print(alabaster.get_path())
print(sphinx_bootstrap_theme.get_html_theme_path())
print(sphinx_rtd_theme.get_html_theme_path())

html_short_title = "sphinx-maven-plugin"
htmlhelp_basename = 'sphinx-maven-plugin-doc'
html_use_index = True
html_show_sourcelink = False
html_static_path = ['_static']

# PlantUML options
plantuml = "java -jar plantuml-1.2019.7.jar"

# ReDoc options
redoc = [{ 'name': 'Batcomputer API',
           'page': 'sphinxcontrib-redoc',
           'spec': 'openapi.yaml' }]

# SphinxEmoji options
sphinxemoji_style = 'twemoji'

# linkcode options
def linkcode_resolve(domain, info):
    return "https://example.com/linkcode.html"
