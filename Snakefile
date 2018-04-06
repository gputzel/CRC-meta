studies = {}

studies['Baxter2016GenomeMed'] = {
    'title':'Microbiota-based model improves the sensitivity of fecal immunochemical test for detecting colonic lesions',
    'url':'https://www.ncbi.nlm.nih.gov/pubmed/27056827',
    'authors':'Baxter N.T. et al.',
    'journal':'Genome Medicine',
    'year':'2016',
    'pcoa.column':'Group',
    'comparison.column':'Group',
    'CRC.group':'CRC',
    'Healthy.group':'Healthy'
}

rule overview:
    input:
        ["data/" + study + "/qiime1/ps_qiime1.rds" for study in studies.keys()],
        "RNotebooks/Overview.Rmd"
    output:
        "Overview.html"
    script:
        "RNotebooks/Overview.Rmd"

rule overview_Rmd:
    input:
        "RNotebooks/Overview_template.Rmd"
    output:
        "RNotebooks/Overview.Rmd"
    run:
        import jinja2
        template = jinja2.Environment(loader=jinja2.FileSystemLoader('./RNotebooks/')).get_template('Overview_template.Rmd')
        with open("RNotebooks/Overview.Rmd",'w') as fo:
            fo.write(template.render(studies=studies))
