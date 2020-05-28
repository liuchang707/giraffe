python scripts/cafetutorial_mcl2rawcafe.py -i mclOutput -o unfiltered_cafe_input.txt -sp "whitelippeddeer giraffe human cattle pronghorn horse forestmuskdeer pig dog okapi whale camel"
python scripts/cafetutorial_clade_and_size_filter.py -i unfiltered_cafe_input.txt -o filtered_cafe_input.txt -s

cafe cafetutorial_run1.sh
cat report_run1.cafe|awk -F '\t' '$3<=0.05' >report_run1.cafe.filterp # filter gene familes with 'Family-wide P-value' above 0.05
python scripts/cafetutorial_report_analysis.py -i reports/report_run1.cafe.filterp -o report_run1

perl get_cluster.giraffe.pl report_run1.cafe.filterp # get gene familes expanded or constracted in giraffe
