import csv
import os
import re
import collections as c
import igraph
import pandas as pd



threat_dict = {'1.1': 'housing and urban areas',
'1.2': 'commercial and industrial areas',
'1.3': 'tourism and recreation areas',
'7.2': 'dams and water management/use',
'7.3': 'other ecosystem modifications',
'12.1': 'other threats',
'7.1': 'fire and fire suppression',
'6.3': 'work and other activities',
'6.2': 'war civil unrest and military exercises',
'6.1': 'recreational activities',
'3.1': 'oil and gas drilling',
'2.3': 'livestock farming and ranching',
'2.2': 'wood and pulp plantations',
'2.1': 'annual and perennial nontimber crops',
'2.4': 'marine and freshwater aquaculture',
'8.1': 'invasive non native/alien species/diseases',
'5.1': 'hunting and trapping terrestrial animals',
'8.3': 'introduced genetic material',
'8.2': 'problematic native species/diseases',
'5.4': 'fishing and harvesting aquatic resources',
'8.4': 'problematic species/disease of unknown origin',
'4.3': 'shipping lanes',
'8.5': 'viral/prion induced diseases',
'8.6': 'disease of unknown cause',
'11.4': 'storms and flooding',
'11.5': 'other climate change and severe weather impacts',
'11.1': 'habitat shifting and alteration',
'11.2': 'droughts',
'11.3': 'temperature extremes',
'9.4': 'garbage and solid waste',
'9.5': 'airborne pollutants',
'9.6': 'excess energy',
'9.1': 'domestic and urban waste water',
'9.2': 'industrial and military effluents',
'9.3': 'agricultural and forestry effluents',
'10.1': 'volcanoes',
'4.4': 'flight paths',
'10.2': 'earthquakes/tsunamis',
'4.1': 'roads and railroads',
'5.3': 'logging and wood harvesting',
'3.2': 'mining and quarrying',
'3.3': 'renewable energy'}
zone_taxa = c.defaultdict(set)
region_list = ["EastCentral", "Northeastern", "Northwestern", "Southeastern", "Southwestern", "WesternCentral"]
region_threat_dict = dict()
region_species_dict = dict()
threats_overall = c.defaultdict(set)
data_folder = "Data"
# looping through each region
for region in region_list:
    region_data_folder = os.path.join(data_folder, region)
    threats = c.defaultdict(set)
    countries = c.defaultdict(set)
    species_set = set()
    species_links = c.defaultdict(int)
    # tabulating all the species threatened by each threat
    with open(os.path.join(region_data_folder, "threats.csv"), mode='r') as csv_file:
        csv_reader = csv.DictReader(csv_file)
        line_count = 0
        for row in csv_reader:
            if line_count == 0:
                print('Column names are' + ", ".join(row))
                line_count += 1
            line_count += 1
            m = re.match(r"(\d{1,}\.\d{1,})",row["code"])
            my_code = m.group(1)
            threats[my_code].add(row["scientificName"])
            species_set.add(row["scientificName"])
            threats_overall[my_code].add(row["scientificName"])
            species_links[row["scientificName"]] = species_links[row["scientificName"]]+1
    region_threat_dict[region] = threats
    region_species_dict[region] = species_set

    # generating file that contains threats and species threatened by it
    with open(os.path.join(region_data_folder,"threat_regioncount.txt"), mode='w+') as outfile:
        outfile.write(f"number of species: {len(species_set)} \n")
        outfile.write("Threats:\n")
        for key in threats:
            outfile.write(f"{threat_dict[key]}: ( {len(threats[key])} species) (weight:{len(threats[key])/len(species_set)})\n")
            outfile.write(', '.join(threats[key]) + '\n\n')

    # tabulating number of species threatened in each country and by each threat in each country
    with open(os.path.join(region_data_folder, "countries.csv"), mode='r') as csv_file:
        csv_reader = csv.DictReader(csv_file)
        line_count = 0
        for row in csv_reader:
            if line_count == 0:
                print('Column names are' + ", ".join(row))
                line_count += 1
            line_count += 1
            countries[row["name"]].add(row["scientificName"])
    country_species_pairs = [(x[0], len(x[1])) for x in countries.items()]
    country_list = [x[0] for x in country_species_pairs]
    species_countlist = [x[1] for x in country_species_pairs]
    species_proportion_list = [x[1]/len(species_set) for x in country_species_pairs]
    countries_dataframe = pd.DataFrame(list(zip(country_list, species_countlist, species_proportion_list)),
                      columns=['Country', 'Species', 'Proportion'])
    countries_dataframe.to_csv(os.path.join(region_data_folder, "countries_speciescount.csv"))
    species_links_df = pd.DataFrame.from_dict(species_links, orient="index", columns=["Links"])
    species_links_df.to_csv(os.path.join(region_data_folder, "species_links.csv"))
    threat_count_pairs = [(x[0], len(x[1])) for x in threats.items()]
    threats_list = [threat_dict[x[0]] for x in threat_count_pairs]
    species_countlist = [x[1] for x in threat_count_pairs]
    threat_counts_df = pd.DataFrame(list(zip(threats_list, species_countlist)),
                                    columns=['Threat', 'Species Count'])
    threat_counts_df.to_csv(os.path.join(region_data_folder, "threat_counts.csv"))

threat_count_pairs = [(x[0], len(x[1])) for x in threats_overall.items()]
threats_list = [threat_dict[x[0]] for x in threat_count_pairs]
species_countlist = [x[1] for x in threat_count_pairs]
threat_counts_df = pd.DataFrame(list(zip(threats_list, species_countlist)),
                                    columns=['Threat', 'Species Count'])
threat_counts_df.to_csv(os.path.join(data_folder, "threat_counts.csv"))

g = igraph.Graph()
for region in region_list:
    g.add_vertex(region)
for threat in threats:
    g.add_vertex(threat_dict[threat])

for region in region_list:
    for threat in threats:
        g.add_edge(region, threat_dict[threat], weight=len(region_threat_dict[region][threat])/len(region_species_dict[region]))
visual_style = {}
visual_style["vertex_label"] = g.vs["name"]
layout = g.layout("circle")
#igraph.plot(g, layout=layout, vertex_label=g.vs["name"])
with open('threat_graph.graphml', mode ='w+') as outfile:
    igraph.Graph.write_graphml(g, outfile)


















































































#
#
#
#
#
#
