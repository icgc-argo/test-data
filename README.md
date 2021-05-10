# Testing Data 

Test data is required to code/test against when updating the clinical dictionaries or services. 

This repository hosts test data to initialize a program with **both** clinical and molecular data. 

## Test Dataset Overview 
The test data has been designed to test several different uses cases for both molecular and clinical data. The following chart summarizes the different clinical and molecular data states for different donors that are being tested. 

| Donor ID | Primary Site | Vital Status | Gender | Clinical Complete  | T/N Status | # T  | # N | # Primary Diagnosis| # Treatments | # Follow Ups  |
|-|-|-|-|-|-|-|-|-|-|-|
| Donor-1 | Brain | Alive | M | Yes | Paired | 2 | 1 | 1 | 1 | 3 |
| Donor-2 | Breast | Alive | F | No | Single | 1 | 0 | 1 | 5 | 5 |
| Donor-3 | Esophagus | Alive | F | No | Single | 0 | 1 | 1 | 3 | 3 |
| Donor-4 | Esophagus | Alive | M | Yes | Paired | 1 | 1 | 1 | 1 (has multiple) | 4 |
| Donor-5 | Pancreas | Deceased | M | Yes | Paired | 1 | 1 | 1 | 1 | 1 |
| Donor-6 | Pancreas | Deceased | M | Yes | Paired | 1 | 1 | 1 | 2 | 2 |
| Donor-7 | Pancreas | Deceased | M | No | Single | 1 | 0 | 1 | 3 (has multiple) | 3 |
| Donor-8 | Pancreas | Alive | F | Yes | Paired | 1 | 1 | 1 | 1 | 2 |
| Donor-9 | Colon | Alive | M | No | Single | 0 | 1 | 1 |  | 1 |
| Donor-10 | Colon | Deceased | M | No | Paired | 1 | 1 | 2 | 2 | 3 |
# Submitting data 
Replace the `program_id` column in all clinical files with the correct Program Code of the program you are working with. 

## 1. Registering Samples. 
Register the samples using `sample_registration.tsv`.

## 2. Clinical 
Submit all clinical files to the Clinical Submission UI. 

## 3. Molecular
To submit molecular data to a program:
- The program must exist as a song study 
- you must have upload permissions for that study

1. Configure your Song/Score clients using the correct Song/Score URLS for your environment, and an API Key with either system permissions or upload permissions to your study.  A guide to configuration can be found on the [ARGO docs site](https://docs.icgc-argo.org/docs/submission/submitting-molecular-data#data-submission-client-configuration). 
2. If needed, update the `upload.sh` directory paths in the scripts.  By default, this script is configured to work with the `TEST-QA` data set with the test data in the structure defined in this repository. 

## Launching a workflow
### Alignment

Alignment Parameters: 
Workflow URL:
"https://github.com/icgc-argo/dna-seq-processing-wfs.git"

Sample Params: 
```
{
	"analysis_id": "0c78bd4c-3447-4dea-b8bd-4c34479dea01",
	"study_id": "ROSI-RU",
	"score_url": "https://score.rdpc-qa.cancercollaboratory.org",
	"song_url": "https://song.rdpc-qa.cancercollaboratory.org",
	"ref_genome_fa": "/nfs-dev-1-vol-qa-1/reference/GRCh38_hla_decoy_ebv/GRCh38_hla_decoy_ebv.fa",
	"download": {
		"song_cpus": 2,
		"song_mem": 2,
		"score_cpus": 4,
		"score_mem": 10,
		"score_url": "https://score.rdpc-qa.cancercollaboratory.org",
		"song_url": "https://song.rdpc-qa.cancercollaboratory.org"
	},
	"cpu": 6,
	"mem": 18
}
```
Workflow Params: 
```
      "revision": "1.5.1"
```

### Sanger

### Mutect2

