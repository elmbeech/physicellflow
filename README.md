# physicellflow

## concept
1. one repository per model
1. the complete physicell source code is an integral part of every physicell agent based model.
1. parameter scanning is done with nextflow, running on the compiled physicell model.
1. all scrips run by nextflow are stored in the flow/bin folder.
1. analysis is done with pip installable python3 libraries or modules stored in the flow/hackpy folder.

## install physicell
basic physicell installation on your operating system, to have all the dependencies installed:
+ https://github.com/physicell-training/ws2023/tree/main/setup

repository based physicell installation (at repository root):
1. `git clone --depth=1  https://github.com/MathCancer/PhysiCell.git`
1. `rm -fr PhysiCell/.git PhysiCell/.github PhysiCell/.gitignore PhysiCell/.travis.yml`
1. `git add PhysiCell`
1. `git commit -m'@ prj : install latest PhysiCell version.'`

once you have a prototyped, running physicell model,
copy the Physicell\_settings.xml, rules.csv, prj\_seeding.csv files into the flow directory,
and link the compiled binary to the flow/bin folder and name it physicell.
1. `cp PhysiCell/config/Physicell_settings.xml flow/`
1. `cp PhysiCell/config/rules.csv flow/`
1. `cp PhysiCell/config/prj_seeding.csv flow/`
1. `cp PhysiCell/config/rules.csv flow/`
1. `cd flow/bin`
1. `ln -s ../../PhysiCell/project physicell`

## install nextflow
basic nextflow installation on your operating system:
+ https://www.nextflow.io/docs/latest/getstarted.html#

## install the python3 libraries required for the runphysicell script
+ `pip install lxml`  (to manipulate settings.xml)
+ `pip install pandas`  (to manipulate rules.csv)

## the flow folder
parameter scan and data analysis working directory.
+ `flow/bin`: folder with shell scripts detected by nextflow.
+ `flow/hackpy`: folder for own python3 library code, which is not yet and probably never pip released.
+ `flow/nextflow.config`: nextflow configuration, utilized to specify slurm settings.  # EDIT ME
+ `flow/YYYYMMDD_parameterscan.nf`: nextflow parameter scan workflow template.  # EDIT ME
+ `flow/parameter_scan.json`: parameter manipulation json file template.  # EDIT ME
