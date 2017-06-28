

pushd /home/w205/github/w205/excercise01/loading_and_modelling


echo making copy of raw data files, no header row

tail -n +2 "Hospital General Information.csv"       > "hospitals.csv"
tail -n +2 "Measure Dates.csv"                      > "measure_dates.csv"
tail -n +2 "Complications - Hospital.csv"           > "complications_hospital.csv"
tail -n +2 "HCAHPS - Hospital.csv"                  > "hcahps_hospital.csv"
tail -n +2 "Readmissions and Deaths - Hospital.csv" > "readmissions_deaths_hospital.csv"
tail -n +2 "hvbp_hcahps_11_10_2016.csv"             > "hvbp_hcahps.csv"
tail -n +2 "Complications - State.csv"              > "complications_state.csv"
tail -n +2 "Readmissions and Deaths - State.csv"    > "readmissions_deaths_state.csv"


echo creating folders in HDFS for data

hdfs dfs -mkdir /user/w205/hospital_compare
hdfs dfs -mkdir /user/w205/hospital_compare/hospitals
hdfs dfs -mkdir /user/w205/hospital_compare/measure_dates
hdfs dfs -mkdir /user/w205/hospital_compare/complications_hospital
hdfs dfs -mkdir /user/w205/hospital_compare/hcahps_hospital
hdfs dfs -mkdir /user/w205/hospital_compare/readmissions_deaths_hospital
hdfs dfs -mkdir /user/w205/hospital_compare/hvbp_hcahps
hdfs dfs -mkdir /user/w205/hospital_compare/complications_state
hdfs dfs -mkdir /user/w205/hospital_compare/readmissions_deaths_state


echo loading data into HDFS

hdfs dfs -put hospitals.csv /user/w205/hospital_compare/hospitals
hdfs dfs -put measure_dates.csv /user/w205/hospital_compare/measure_dates
hdfs dfs -put complications_hospital.csv /user/w205/hospital_compare/complications_hospital
hdfs dfs -put hcahps_hospital.csv /user/w205/hospital_compare/hcahps_hospital
hdfs dfs -put readmissions_deaths_hospital.csv /user/w205/hospital_compare/readmissions_deaths_hospital
hdfs dfs -put hvbp_hcahps.csv /user/w205/hospital_compare/hvbp_hcahps
hdfs dfs -put complications_state.csv /user/w205/hospital_compare/complications_state
hdfs dfs -put readmissions_deaths_state.csv /user/w205/hospital_compare/readmissions_deaths_state



popd
