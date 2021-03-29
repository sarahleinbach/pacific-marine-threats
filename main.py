import csv
import os
import re
import collections as c
import jgraph as jgraph


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
data_folder = "Data"
# looping through each region
for region in region_list:
    region_data_folder = os.path.join(data_folder, region)
    threats = c.defaultdict(set)
    species_set = set()
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

    # generating file that contains threats and species threatened by it
    with open(os.path.join(region_data_folder,"threat_regioncount.txt"), mode='w+') as outfile:
        outfile.write(f"number of species: {len(species_set)} \n")
        outfile.write("Threats:\n")
        for key in threats:
            outfile.write(f"{threat_dict[key]}: ( {len(threats[key])} species) (weight:{len(threats[key])/len(species_set)})\n")
            outfile.write(', '.join(threats[key]) + '\n\n')

    # weight = {}
    # for taxa_key in taxa:
    #     for threat_key in threats:
    #         if taxa_key not in weight:
    #             weight[taxa_key] = {}
    #         if threat_key not in weight[taxa_key]:
    #             weight[taxa_key][threat_key] = 0
    #         for species in taxa[taxa_key]:
    #             if species in threats[threat_key]:
    #                 weight[taxa_key][threat_key] = weight[taxa_key][threat_key] + 1
    #
    #         weight[taxa_key][threat_key] = weight[taxa_key][threat_key]/float(len(taxa[taxa_key]))
    #
    # g = igraph.Graph()
    # for taxa_key in taxa:
    #     g.add_vertex(taxa_key)
    # for threat in threats:
    #     g.add_vertex(threat)
    # for taxa_key in weight:
    #     for threat in weight[taxa_key]:
    #         g.add_edge(taxa_key,threat,weight = weight[taxa_key][threat])
    # visual_style = {}
    # visual_style["vertex_label"] = g.vs["name"]
    # layout = g.layout("circle")
    # igraph.plot(g,layout = layout, vertex_label = g.vs["name"])
    # with open('threat_graph', mode = 'w+') as outfile:
    #     igraph.Graph.write_graphml(g,outfile)
    #
    # with open("antarctic_taxa.csv", mode='r') as csv_file:
    #     csv_reader = csv.DictReader(csv_file)
    #     line_count = 0
    #     for row in csv_reader:
    #         if line_count == 0:
    #             line_count += 1
    #         zone_taxa['Antarctica'].add(row['scientificName'])
    # with open("e_pacific_taxa.csv", mode='r') as csv_file:
    #     csv_reader = csv.DictReader(csv_file)
    #     line_count = 0
    #     for row in csv_reader:
    #         if line_count == 0:
    #             line_count += 1
    #         zone_taxa['East'].add(row['scientificName'])
    # with open("ne_pacific_taxa.csv", mode='r') as csv_file:
    #     csv_reader = csv.DictReader(csv_file)
    #     line_count = 0
    #     for row in csv_reader:
    #         if line_count == 0:
    #             line_count += 1
    #         zone_taxa['Northeast'].add(row['scientificName'])
    # with open("nw_pacific_taxa.csv", mode='r') as csv_file:
    #     csv_reader = csv.DictReader(csv_file)
    #     line_count = 0
    #     for row in csv_reader:
    #         if line_count == 0:
    #             line_count += 1
    #         zone_taxa['Northwest'].add(row['scientificName'])
    # with open("se_pacific_taxa.csv", mode='r') as csv_file:
    #     csv_reader = csv.DictReader(csv_file)
    #     line_count = 0
    #     for row in csv_reader:
    #         if line_count == 0:
    #             line_count += 1
    #         zone_taxa['Southeast'].add(row['scientificName'])
    # with open("sw_pacific_taxa.csv", mode='r') as csv_file:
    #     csv_reader = csv.DictReader(csv_file)
    #     line_count = 0
    #     for row in csv_reader:
    #         if line_count == 0:
    #             line_count += 1
    #         zone_taxa['Southwest'].add(row['scientificName'])
    # with open("w_pacific_taxa.csv", mode='r') as csv_file:
    #     csv_reader = csv.DictReader(csv_file)
    #     line_count = 0
    #     for row in csv_reader:
    #         if line_count == 0:
    #             line_count += 1
    #         zone_taxa['West'].add(row['scientificName'])
    #
    # zone_threats = {}
    #
    # for zone in zone_taxa:
    #     for threat in threats:
    #         if zone not in zone_threats:
    #             zone_threats[zone] = {}
    #         if threat not in zone_threats[zone]:
    #             zone_threats[zone][threat] = 0
    #         for species in zone_taxa[zone]:
    #             if species in threats[threat]:
    #                 zone_threats[zone][threat] = zone_threats[zone][threat] + 1
    #
    # with open("zone_threats.txt", mode='w+') as outfile:
    #     for zone in zone_threats:
    #         outfile.write(zone + ':\n')
    #         for threat in zone_threats[zone]:
    #             outfile.write('\t' + threat_dict[threat] + ': ' + str(zone_threats[zone][threat]) + '\n')
    #
    # # Calculting number of species per threat in each taxon
    # taxa_threats = {}
    # for taxa_key in taxa:
    #     taxa_threats[taxa_key] = {}
    #     for threat_key in threats:
    #         taxa_threats[taxa_key][threat_key] = 0
    #         for species in taxa[taxa_key]:
    #             if species in threats[threat_key]:
    #                 taxa_threats[taxa_key][threat_key] = taxa_threats[taxa_key][threat_key] + 1
    # with open("taxa_threats.txt", mode='w+') as outfile:
    #     for taxa_key in taxa_threats:
    #         outfile.write(taxa_key + ':\n')
    #         for threat in taxa_threats[taxa_key]:
    #             outfile.write('\t' + threat_dict[threat] + ': ' + str(taxa_threats[taxa_key][threat]) + '\n')
    #
    # # Calculating average number of links per spieces per zone
    # zone_mean_links = {}
    # for zone in zone_taxa:
    #     zone_mean_links[zone] = 0
    #     for species in zone_taxa[zone]:
    #         for threat in threats:
    #             if species in threats[threat]:
    #                 zone_mean_links[zone] = zone_mean_links[zone] + 1
    #     zone_mean_links[zone] = zone_mean_links[zone] / float(len(zone_taxa[zone]))
    # with open("zone_mean_links.txt", mode='w+') as outfile:
    #     for zone in zone_mean_links:
    #         outfile.write(zone + ' mean links: ' + str(zone_mean_links[zone]) + '\n')
    #
    # # Calculating average number of links per spieces per taxon
    # taxa_mean_links = {}
    # for taxa_key in taxa:
    #     taxa_mean_links[taxa_key] = 0
    #     for species in taxa[taxa_key]:
    #         for threat in threats:
    #             if species in threats[threat]:
    #                 taxa_mean_links[taxa_key] = taxa_mean_links[taxa_key] + 1
    #     taxa_mean_links[taxa_key] = taxa_mean_links[taxa_key] / float(len(taxa[taxa_key]))
    # with open("taxa_mean_links.txt", mode='w+') as outfile:
    #     for taxa_key in taxa_mean_links:
    #         outfile.write(taxa_key + ' mean links: ' + str(taxa_mean_links[taxa_key]) + '\n')
    #
    #
    #
    #
    #
    #
    #
    #
    #
    #
    #
    #
    #
    #
    #
    #
