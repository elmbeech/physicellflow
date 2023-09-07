# physicellflow

## layout
1. the complete physicell sourcode is an integral part of every physicell agent based model project.
2. parameter scan is done with nextflow.
3. for analysis julua is most probably the future, but not right now.
   the current analysis is done with python3 state of the art libraries.

## install physicell
basic physicell installation on your operating system, to have all the dependencies installed:
+ https://github.com/physicell-training/ws2023/tree/main/setup

project based physicell installation (at project repository root):
1. `git clone --depth=1  https://github.com/MathCancer/PhysiCell.git`
1. `rm -fr PhysiCell/.git PhysiCell/.github PhysiCell/.gitignore PhysiCell/.travis.yml`
1. `git add PhysiCell`
1. `git commit -m'@ prj : install latest PhysiCell version.'`

## install nextflow
basic nextflow installation on your operating system:
+ https://www.nextflow.io/docs/latest/getstarted.html#

## install required python libraries
+ `pip install lxml`  (to mainipulat settings.xml)
+ `pip install pandas`  (to mainipulate rules.csv)

## flow folder
+ parameter scan and data analysis working directory.

## flow/hack folder
+ folder for own python3 libraries code, which is not yet and probably never pip released.
