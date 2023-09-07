//*** work process with channels ***//
process runPhysiCell {
    //*** directive (https://www.nextflow.io/docs/latest/process.html#directives) **//
    //debug true
    executor 'local'  //'local','slurm' (nextflow.config)
    //maxForks  //cpu -1 (default)
    publishDir "$params.s_nfwd" + 'output/', mode: 'move'  //'copy','move','symlink' (default)
    tag "$s_parameter"

    //*** element ***//
    input:
        path p_setting
        path p_rule
        tuple val(s_init), path(p_init)
        val s_parameter
        val xp_parameter
        each r_parameter
        each s_take

    output:
        path 'output_*'

    script:
        template 'physicell.sh'
}


//*** workflow with channels ***//
workflow {
    // specify model
    p_setting = channel.value("$params.s_nfwd" + 'PhysiCell_settings.xml')
    p_rule = channel.value("$params.s_nfwd" + 'rules.csv')
    // specfy seeding
    tsp_init = channel.of(
        ['seeding_tag', "$params.s_nfwd" + 'cells.csv'],
    )
    // settings.xml parameter scan
    s_parameter = channel.value('PARAMETER')
    xp_parameter = channel.value('.//ELEMENT/PARAMETER') // xpath to find correct line in the PhysiCell_settings.xml
    r_parameter = channel.of('0.00', '0.00')  // parameter values for scan.
    // rules.csv paramerer scan

    // how many takes per parameter setting
    s_take = channel.of('a', 'b')
    // simulation run
    runPhysiCell(p_setting, p_rule, tsp_init, s_parameter, xp_parameter, r_parameter, s_take) | view {it.name}
}
