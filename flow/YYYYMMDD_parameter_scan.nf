/* work process specification */
process RUNPHYSICELL {
    /* directive (https://www.nextflow.io/docs/latest/process.html#directives) */
    // bigred200 slurm : https://kb.iu.edu/d/awrz
    debug false  //false true : track command stdout

    executor 'local'  //'local','slurm'
    cpus = 6  //bigred200: 48 cpu-per-node (1 slurmjob = 1 process = 1 task; OMP_NUM_THREADS = cpus; 48 cpu-per-node / 8 cpu-per-task = 6 process-per-node)
    maxForks = cpus - 1  //default: cpus - 1
    memory = "${2*cpus}G"  //bigread200: 56G  (56G / 48 cpu = 1.166G)
    if (executor == 'slurm') {
        clusterOptions = "-A r00000 --nodes=1 --cpus-per-task=${cpus} --mail-type=fail --mail-user=ME@iu.edu"
        queue = 'general'   // partition
        time = '12h'
    }

    tag "${s_parammanipu}"
    publishDir "${projectDir}"+'/output/', mode: 'move'  //'copy','move','symlink' (default)

    /* element */
    input:
        path p_setting
        path p_rule
        each path(p_seed)
        path p_paramjson
        each s_parammanipu
        each s_take

    output:
        path 'output_*'

    script:
        """
        runphysicell.py -r $p_rule -i $p_seed -p $p_paramjson -t $s_take $p_setting $s_parammanipu
        """
}

/* workflow and channels specification */
workflow {
    // specify model
    p_setting = channel.value("$projectDir"+'/PhysiCell_settings.xml')
    p_rule = channel.value("$projectDir"+'/rules.csv')

    // specify seeding
    // chose a meaningful name for your prj_seeding.csv file!
    p_seed = channel.of(
        "$projectDir"+'/cells.csv',
    )

    // specify parameter scan
    // chose meaningful parameter_manipulation_tag names!
    p_paramjson = channel.value("$projectDir"+'/parameter_scan.json')
    s_parammanipu = channel.of(
        'parameter_manipulation_tag00',
        'parameter_manipulation_tag01',
    )

    // specify how many takes per setting
    s_take = channel.of(
        'a','b',
    )

    // simulation run
    RUNPHYSICELL(p_setting, p_rule, p_seed, p_paramjson, s_parammanipu, s_take) | view {it.name}
}

