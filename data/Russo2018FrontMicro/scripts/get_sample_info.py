from lxml import etree
import csv

tree = etree.parse('sample_data/sra-info.xml')

d_list = []
for x in tree.xpath('//EXPERIMENT_PACKAGE'):
    for node in x.xpath('SAMPLE'):
        srs = node.attrib['accession']
    d = {}
    d['SRS'] = srs
    #print(node.xpath('SAMPLE_ATTRIBUTES/SAMPLE_ATTRIBUTE/TAG'))
    for child in node.xpath('SAMPLE_ATTRIBUTES/SAMPLE_ATTRIBUTE'): #Iterate over sample attributes
        #print('\t',child.tag)
        for g in child.iterchildren():
            if g.tag == 'TAG':
                tag = g.text
            if g.tag == 'VALUE':
                value = g.text
        d[tag] = value
    for node in x.xpath('RUN_SET/RUN'):
        #print(node.attrib['accession'])
        d['SRR'] = node.attrib['accession']
    d_list.append(d)

keys = d_list[0].keys()
with open('sample_data/sample_info.csv','w') as output_file:
    dict_writer = csv.DictWriter(output_file,keys)
    dict_writer.writeheader()
    dict_writer.writerows(d_list)