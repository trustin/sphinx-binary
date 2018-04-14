from PyInstaller.utils.hooks import collect_submodules, collect_data_files, is_module_satisfies
hiddenimports = (
    collect_submodules('sphinx.builders') +
    collect_submodules('sphinx.environment.collectors') +
    collect_submodules('sphinx.ext') +
    collect_submodules('sphinx.parsers') +
    collect_submodules('sphinx.search') +
    collect_submodules('sphinx.websupport.search') +
    collect_submodules('sphinx.domains') +
    collect_submodules('sphinx.util') +
    ['inspect', 'locale'] +
    collect_submodules('yaml') +
    collect_submodules('javasphinx') +
    collect_submodules('recommonmark') +
    collect_submodules('sphinxcontrib') +
    ['sphinxcontrib.httpdomain',
     'sphinxcontrib.inlinesyntaxhighlight',
     'sphinxcontrib.plantuml'])

datas = collect_data_files('sphinx')
datas.extend(collect_data_files('alabaster'))
datas.extend(collect_data_files('guzzle_sphinx_theme'))
datas.extend(collect_data_files('sphinx_bootstrap_theme'))
datas.extend(collect_data_files('sphinx_rtd_theme'))
