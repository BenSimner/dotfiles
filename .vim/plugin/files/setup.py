from setuptools import setup

setup(
    name = 'TODO_ProjectName'
    , version = '0.1'
    , py_modules = ['TODO_PythonModuleName']
    , install_requires = ['nose']
    , entry_points = '''
        [console_scripts]
        TODO_ExectableName = PyModule:FunctionName
    '''
)
