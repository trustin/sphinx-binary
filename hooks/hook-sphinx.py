from PyInstaller.utils.hooks import collect_submodules, collect_data_files, copy_metadata, is_module_satisfies
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
    collect_submodules('lib2to3') +
    collect_submodules('babel') +
    collect_submodules('yaml') +
    collect_submodules('javasphinx') +
    collect_submodules('recommonmark') +
    collect_submodules('sphinxcontrib') +
    # Themes
    collect_submodules('alabaster') +
    collect_submodules('sphinx_bootstrap_theme') +
    collect_submodules('sphinx_rtd_theme'))

datas = collect_data_files('sphinx')
datas.extend(collect_data_files('alabaster'))
datas.extend(collect_data_files('sphinx_bootstrap_theme'))
datas.extend(collect_data_files('sphinx_rtd_theme'))
datas.extend(collect_data_files('sphinxcontrib'))
datas.extend(copy_metadata('sphinxcontrib-redoc'))
