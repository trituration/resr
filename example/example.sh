restriction_sites_hider.py find_by_pattern ./NC_005816.fna AGCCAG test.txt
restriction_sites_hider.py remove_by_pattern ./NC_005816.fna test.txt AGCCAG NC_005816_pattern.fa


restriction_sites_hider.py find_known_sites ./NC_005816.fna ScaI test.txt
restriction_sites_hider.py remove_known_sites ./NC_005816.fna test.txt ScaI NC_005816_known_sites.fa
