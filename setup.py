from setuptools import Extension, setup
from Cython.Build import cythonize

extensions = [
    Extension(
        "powerlaw",
        [
            "powerlaw/powerlaw.pyx",
            "powerlaw/src/LineObstacle.cpp",
            "powerlaw/src/lq2D.cpp"
        ],
        include_dirs=["powerlaw/src"],
        language="c++",
    )
]

with open("README.md", "r") as fh:
    long_description = fh.read()

setup(
    name="powerlaw",
    version="1.0.0",
    description="Python wrapper for the Powerlaw Collision Avoidance model",
    long_description=long_description,
    long_description_content_type="text/markdown",
    author="Alex Day",
    author_email="alex@alexday.me",
    url="https://github.com/AlexanderDavid/Powerlaw",
    ext_modules=cythonize(extensions)
)
