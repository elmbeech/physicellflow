//*** work process with channels ***//
process RUNPHYSICELL {
    //*** directive (https://www.nextflow.io/docs/latest/process.html#directives) **//
    //debug true
    executor 'local'  //'local','slurm' (nextflow.config)
    //maxForks  //cpu -1 (default)
    publishDir "$projectDir" + 'output/', mode: 'move'  //'copy','move','symlink' (default)
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
    p_setting = channel.value("$projectDir" + 'PhysiCell_settings.xml')
    p_rule = channel.value("$projectDir" + 'rules.csv')

    // specfy seeding
    tsp_init = channel.of(
        ['SEEDINGTAG', "$projectDir" + 'cells.csv'],
        ['SEEDINGTAG', "$projectDir" + 'cells.csv'],
    )

    // settings.xml parameter scan
    // rules.csv paramerer scan

    //s_parameter = channel.value('PARAMETERSETTING')
    //xp_parameter = channel.value('.//ELEMENT/PARAMETER') // xpath to find correct line in the PhysiCell_settings.xml
    //r_parameter = channel.of('0.00', '0.00')  // parameter values for scan.

    tsp_parameter = channel.of(
        ['PARAMETERSETTINGTAG', [
            ['xml', './/ELEMENT/PARAMETER', '0.00'],
            ['csv', 'RULELABEL', 'COLUMN', 0.00],   // satuartion_value, half_max, hill_power
        ]],
        ['PARAMETERSETTINGTAG', [
            ['xml', './/ELEMENT/PARAMETER', '0.00'],
            ['csv', 'RULELABEL', 'COLUMN', 0.00],
        ]],
    )

    // how many takes per setting
    s_take = channel.of('a', 'b')

    // simulation run
    RUNPHYSICELL(p_setting, p_rule, tsp_init, s_parameter, xp_parameter, r_parameter, s_take) | view {it.name}
}
