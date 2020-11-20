from setuptools import Extension, setup
from Cython.Build import cythonize
from glob import glob

extensions = [
    Extension(
        "Powerlaw",
        ["AnticipatoryModel.pyx", "src/LineObstacle.cpp", "src/lq2D.cpp",],
        include_dirs=["src"],
        language="c++",
    )
]
setup(name="Python Powerlaw", ext_modules=cythonize(extensions))
