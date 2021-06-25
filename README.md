# Testing Data 

Test data is required to code/test against when updating the clinical dictionaries or services. 

This repository hosts test data to initialize a program with **both** clinical and molecular data. 

## Test Dataset Overview 
The test data has been designed to test several different uses cases for both molecular and clinical data. The following chart summarizes the different clinical and molecular data states for different donors that are being tested. This dataset can be found in the ARGO QA Environment, with a summary of process data as found in QA RDPC [here](https://docs.google.com/spreadsheets/d/1gdKi4IoXdRzp63ZDgYHeX8Bg4wwsCJHUZ1IXpR82mCo/edit#gid=0).

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

Sample Parameters: 
```
{
	"analysis_id": "c52c6e97-2b13-451c-ac6e-972b13751c86",
	"study_id": "ROSI-RU",
	"score_url": "https://score.rdpc-qa.cancercollaboratory.org",
	"song_url": "https://song.rdpc-qa.cancercollaboratory.org",
	"ref_genome_fa": "/nfs-dev-1-vol-qa-1/reference/GRCh38_hla_decoy_ebv/GRCh38_hla_decoy_ebv.fa",
	"download": {
		"song_cpus": 2,
		"song_mem": 2,
		"score_cpus": 4,
		"score_mem": 10,
		"score_url": "https://submission-score.rdpc-qa.cancercollaboratory.org",
		"song_url": "https://submission-song.rdpc-qa.cancercollaboratory.org"
	},
	"cpu": 6,
	"mem": 18
}
```
Workflow Engine Parameters: 
```
{
      "revision": "1.5.1"
}
```

### Sanger
Workflow URL: 

```
{
  "study_id":"ROSI-RU",
  "tumour_aln_analysis_id":"1d8b0eb1-47db-4984-8b0e-b147dba984b6",
  "normal_aln_analysis_id":"1947f9c8-33df-491c-87f9-c833df991cdb",
  "song_url":"https://song.rdpc-qa.cancercollaboratory.org",
  "score_url":"https://score.rdpc-qa.cancercollaboratory.org",
  "cpus":2,
  "mem":6,
  "max_retries": 3,
  "first_retry_wait_time": 5,
  "download":{
    "song_cpus":2,
    "song_mem":2,
    "score_cpus":3,
    "score_mem":8
  },
  "generateBas":{
    "cpus":6,
    "mem":8,
    "ref_genome_fa":"/nfs-dev-1-vol-qa-1/reference/GRCh38_hla_decoy_ebv/GRCh38_hla_decoy_ebv.fa"
  },
  "sangerWgsVariantCaller":{
    "cpus":12,
    "mem":108,
    "ref_genome_tar":"/nfs-dev-1-vol-qa-1/reference/sanger-variant-calling/core_ref_GRCh38_hla_decoy_ebv.tar.gz",
    "vagrent_annot":"/nfs-dev-1-vol-qa-1/reference/sanger-variant-calling/VAGrENT_ref_GRCh38_hla_decoy_ebv_ensembl_91.tar.gz",
    "ref_snv_indel_tar":"/nfs-dev-1-vol-qa-1/reference/sanger-variant-calling/SNV_INDEL_ref_GRCh38_hla_decoy_ebv-fragment.tar.gz",
    "ref_cnv_sv_tar":"/nfs-dev-1-vol-qa-1/reference/sanger-variant-calling/CNV_SV_ref_GRCh38_hla_decoy_ebv_brass6+.tar.gz",
    "qcset_tar":"/nfs-dev-1-vol-qa-1/reference/sanger-variant-calling/qcGenotype_GRCh38_hla_decoy_ebv.tar.gz",
    "exclude":"chr1,chr2,chr3,chr4,chr5,chr6,chr7,chr8,chr9,chr10,chr11,chr12,chr13,chr14,chr15,chr16,chr17,chr18,chr19,chr20,chr22,chrX,chrY,chrUn%,HLA%,%_alt,%_random,chrM,chrEBV"
  },
  "repackSangerResults":{
    "cpus":2,
    "mem":4
  },
  "prepSangerSupplement":{
    "cpus":2,
    "mem":8
  },
  "cavemanVcfFix":{
    "cpus":2,
    "mem":16
  },
  "extractSangerCall":{
    "cpus":2,
    "mem":4
  },
  "payloadGenVariantCall":{
    "cpus":2,
    "mem":8
  },
  "prepSangerQc":{
    "cpus":2,
    "mem":8
  },
  "upload":{
    "song_cpus":2,
    "song_mem":2,
    "score_cpus":3,
    "score_mem":8
  }
}
```
### Mutect2
Workflow URL: 
```
https://github.com/icgc-argo/gatk-mutect2-variant-calling
```
Sample Workflow Parameters:
```
{
  "study_id": "ROSI-RU",
  "tumour_aln_analysis_id": "2abd861d-39fc-4f9f-bd86-1d39fc9f9f6f",
  "normal_aln_analysis_id": "a9ba1bc5-ac14-40d7-ba1b-c5ac1490d784",

  "song_url": "https://song.rdpc-qa.cancercollaboratory.org",
  "score_url": "https://score.rdpc-qa.cancercollaboratory.org",

  "publish_dir": "",
  "max_retries": 3,
  "first_retry_wait_time": 5,

  "perform_bqsr": false,

  "ref_fa": "/nfs-dev-1-vol-qa-1/reference/GRCh38_hla_decoy_ebv/GRCh38_hla_decoy_ebv.fa",
  "mutect2_scatter_interval_files": "/nfs-dev-1-vol-qa-1/reference/gatk-resources/mutect2.scatter_by_chr/chr*.interval_list",
  "germline_resource_vcfs": [
    "/nfs-dev-1-vol-qa-1/reference/gatk-resources/af-only-gnomad.pass-only.hg38.vcf.gz"
  ],
  "panel_of_normals": "/nfs-dev-1-vol-qa-1/reference/gatk-resources/1000g_pon.hg38.vcf.gz",
  "contamination_variants": "/nfs-dev-1-vol-qa-1/reference/gatk-resources/af-only-gnomad.pass-only.biallelic.snp.hg38.vcf.gz",

  "mem": 40,
  "cpus": 8
}
```
Workflow Engine Parameters:
```
  {
    "projectDir": "/nfs-dev-1-vol-qa-1/test-projects",
    "revision": "main"
  }
```