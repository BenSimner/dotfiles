try:
    from setuptools import setup
except ImportError:
    from distutils.core import setup

config = {
    'description': 'TODO_ProjectDescription',
    'author': 'Ben Simner',
    'url': 'TODO_ProjectUrl',
    'download_url': 'TODO_ProjectDownloadUrl',
    'author_email': 'TODO_ProjectEmail',
    'version': '0.1',
    'install_requires': ['nose'],
    'packages': ['_VIM_PROJECTNAME_'],
    'scripts': [],
    'name': '_VIM_PROJECTNAME_'
}

setup(**config)
