import os
import sys
cluster_file = sys.argv[1]
log_file = sys.argv[2]
output_file = sys.argv[3]
print('working...')
#cluster_file = os.path.join(os.getcwd(), 'cluster_info_drug')
#log_file = os.path.join(os.getcwd(), 'log.txt')
#output_file = os.path.join(os.getcwd(), 'output_new_drug_barplot.csv')
header_dict = {}
with open(cluster_file) as fp_read:
    header_ = fp_read.readline().strip()
    headerArr = header_.split(',') 
    header_dict = {ele.strip(): '0' for ele in headerArr}
data_dict = {}
with open(log_file) as fp_read:
    for line in fp_read:
        data_value_list = []
        line = line.strip()
        lineArr = line.split(',') 
        header__ = lineArr[0].strip()
        data_Arr = lineArr[1:] 
        data_inner_dict = {}
        for line2 in data_Arr:
            line2 = line2.strip()
            if line2:
                line2_arr = line2.split(':')
                data_inner_dict[line2_arr[0]] = line2_arr[1]
        for key,value in header_dict.items():
            if key in data_inner_dict:
                data_value_list.append(data_inner_dict[key])
            else:
                data_value_list.append(value)
        data_dict[header__] = data_value_list

with open(output_file, 'w') as fp_write:
    fp_write.write(',' + header_ + '\n')
    for key in data_dict:
        fp_write.write(key + ',' + ','.join(data_dict[key]) + '\n')
print('done!!')
