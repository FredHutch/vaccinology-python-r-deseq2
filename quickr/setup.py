# Copyright 2020 Fred Hutchinson Cancer Research Center
# from distutils.core import setup

from setuptools import setup, find_packages


packages = find_packages(exclude=['tests']);


setup(name='quickr',
      author='Andrew Fiore-Gartland',
      description='Run an R script from python',
      license='License :: OSI Approved :: GNU Lesser General Public License v3 (LGPLv3)',
      version='0.1',
      url='https://github.com/...',
      classifiers=[
          'Development Status :: 3 - Alpha',
          'License :: OSI Approved :: GNU Lesser General Public License v3 (LGPLv3)',
          'Programming Language :: Python :: 3.6'
          ],
      keywords='R interface',
      packages=packages,
      install_requires=['pandas'],
      python_requires='>=3.6',
      )
