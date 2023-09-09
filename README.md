# physicellflow

## concept
1. the complete physicell sourcode is an integral part of every physicell agent based model project.
1. parameter scan is done with nextflow, running on the compiled physicell model.
1. all scrips run by nextflow are stored in flow/bin folder.
1. analysis is done with pip installable python3 libraries or modules stored the flow/hackpy folder.

## install physicell
basic physicell installation on your operating system, to have all the dependencies installed:
+ https://github.com/physicell-training/ws2023/tree/main/setup

repository based physicell installation (at repository root):
1. `git clone --depth=1  https://github.com/MathCancer/PhysiCell.git`
1. `rm -fr PhysiCell/.git PhysiCell/.github PhysiCell/.gitignore PhysiCell/.travis.yml`
1. `git add PhysiCell`
1. `git commit -m'@ prj : install latest PhysiCell version.'`

once you have a prototyped, runnig physicell model, link the compiled binary to the flow/bin folder and name it physicell
1. `cd flow/bin`
1. `ln -s ../../PhysiCell/project physicell`

## install nextflow
basic nextflow installation on your operating system:
+ https://www.nextflow.io/docs/latest/getstarted.html#

## install runphysicell script required python3 libraries
+ `pip install lxml`  (to mainipulat settings.xml)
+ `pip install pandas`  (to mainipulate rules.csv)

## flow folder
+ parameter scan and data analysis working directory.

## flow/bin folder
+ folder with shell scripts detected by nextflow.

## flow/hackpy folder
+ folder for own python3 libraries code, which is not yet and probably never pip released.
