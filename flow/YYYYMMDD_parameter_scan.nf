/* work process specification */
process RUNPHYSICELL {
    /* directive (https://www.nextflow.io/docs/latest/process.html#directives) */
    //debug true
    executor 'local'  //'local','slurm' (nextflow.config)
    //maxForks  //cpu -1 (default)
    publishDir "$projectDir"+'/output/', mode: 'move'  //'copy','move','symlink' (default)
    tag "$s_parameter"

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

