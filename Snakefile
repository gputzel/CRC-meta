import csv
import jinja2
with open('studies/completed.txt') as csvfile:
    reader = csv.DictReader(csvfile,delimiter='\t')
    studies = [row for row in reader]

rule overview:
    input:
        ["data/" + study['study'] + "/qiime1/ps_qiime1.rds" for study in studies],
        "RNotebooks/Overview.Rmd"
    output:
        "Overview.html"
    script:
        "RNotebooks/Overview.Rmd"

rule overview_Rmd:
    input:
        template="RNotebooks/Overview_template.Rmd",
        table="studies/completed.txt"
    output:
        "RNotebooks/Overview.Rmd"
    run:
        import jinja2
        template = jinja2.Environment(loader=jinja2.FileSystemLoader('./RNotebooks/')).get_template('Overview_template.Rmd')
        with open("RNotebooks/Overview.Rmd",'w') as fo:
            fo.write(template.render(studies=studies))
