# PlantTribes
## Overview
PlantTribes is a collection of automated modular analysis pipelines that utilize objective classifications of complete protein sequences from sequenced plant genomes to perform comparative evolutionary studies. It post-processes *de novo* assembly transcripts into putative coding sequences and their corresponding amino acid translations, locally assembles targeted gene families, estimates paralogous/orthologous pairwise synonymous/non-synonymous substitution rates for a set of gene sequences, classifies gene sequences into pre-computed orthologous plant gene family clusters, and builds gene family multiple sequence alignments and their corresponding phylogenies. A user provides *de novo* assembly transcripts, and PlantTribes produces predicted coding sequences and their corresponding translations, a table of pairwise synonymous/non-synonymous substitution rates for reciprocal best blast transcript pairs, results of significant duplication components in the distribution of Ks (synonymous substitutions) values, a summary table for transcripts classified into orthologous plant gene family clusters with their corresponding functional annotations, gene family amino acid and nucleotide fasta sequences, multiple sequence alignments, and inferred maximum likelihood phylogenies. Optionally, a user can provide externally predicted coding sequences and their corresponding amino acid translations derived from a transcriptome assembly or gene predictions from a sequenced genome. 

All questions and inquires should be addressed to our user email group: `PlantTribes-users@googlegroups.com`

In addition to this README file, you can consult the PlantTribes [manual](./PlantTribes.md) for more detailed information.

## Installation
PlantTribes pipeline scripts have many external dependencies that need to be installed before the pipelines can be used. Executables of external dependencies should be set in the **_plantTribes.config_** file that is in the **_config_** subdirectory of the installation. 
#### Pipeline dependencies
- **AssemblyPostProcesser pipeline**:  
[ESTScan (version 2.1)](http://estscan.sourceforge.net/), [TransDecoder (version 2.0.1)](https://github.com/TransDecoder/TransDecoder/releases), and [GenomeTools (version 1.5.4)](http://genometools.org/).
- **GeneFamilyClassifier pipeline**:  
[BLASTP (NCBI BLAST version 2.2.29+)](http://blast.ncbi.nlm.nih.gov/Blast.cgi?PAGE_TYPE=BlastDocs&DOC_TYPE=Download), and [HMMScan (HMMER version 3.1b1)](http://hmmer.janelia.org/).
- **PhylogenomicsAnalysis pipeline**:  
[MAFFT (version 7.215 )](http://mafft.cbrc.jp/alignment/software/), [PASTA](https://github.com/smirarab/pasta), [trimAl (version 1.4.rev8)](http://trimal.cgenomics.org/), [RAxML (version 8.1.16)](http://sco.h-its.org/exelixis/web/software/raxml/index.html), and [FastTreeMP (version 2.1.7 SSE3)](http://meta.microbesonline.org/fasttree/).
- **KaKsAnalysis pipeline**:  
[BLASTP (NCBI BLAST version 2.2.29+)](http://blast.ncbi.nlm.nih.gov/Blast.cgi?PAGE_TYPE=BlastDocs&DOC_TYPE=Download), [PAML (version 4.8)](http://abacus.gene.ucl.ac.uk/software/paml.html#download), [EMMIX (version 1.0.1)](http://www.maths.uq.edu.au/~gjm/), and [mclust (version 4.4)](http://www.stat.washington.edu/mclust/).

#### PlantTribes scaffolds data 
- **22 plant genomes (Angiosperms clusters, version 1.0)**  
Download: http://fgp.huck.psu.edu/planttribes_data/22Gv1.0.tar.bz2  
MD5 checksum: `3e509094a6f763d8af1f9a3f781f3a0d`  
- **22 plant genomes (Angiosperms clusters, version 1.1)**  
Download: http://fgp.huck.psu.edu/planttribes_data/22Gv1.1.tar.bz2  
MD5 checksum: `5f4f602f4ee2e274fa6ed8398993af60`

#### Install PlantTribes
1. Open a terminal and change to the location where you would to keep PlantTribes. 
  - Example: `cd ~/softwares`
2. Clone the [PlantTribes](https://github.com/dePamphilis/PlantTribes) GitHub repository or download the [zip archive](https://github.com/dePamphilis/PlantTribes/archive/master.zip) and decompress it in your desired location.   
  - Examples: `git clone https://github.com/dePamphilis/PlantTribes.git` or `unzip https://github.com/dePamphilis/PlantTribes/archive/master.zip`
3. Download the scaffold data set(s) that you would like to use in the PlantTribes' **_data_** subdirectory and decompress them.
  - Examples: `cd PlantTribes/data`, `md5sum 22Gv1.1.tar.bz` (should match the provided MD5 checksum for the data archive), followed by `tar -xjvf 22Gv1.1.tar.bz2`

## Using PlantTribes
The execulables for the PlantTribes pipelines are in the **_pipelines_** subdrectory of the installation. You can either add them to your PATH environment variable or execute directly from the PlantTribes installation.

- **AssemblyPostProcesser pipeline**: 
  - Display all usage options: 
    - `PlantTribes/pipelines/AssemblyPostProcesser`
  - Basic run using ESTScan prediction method:
    - `PlantTribes/pipelines/AssemblyPostProcesser  --transcripts transcripts.fasta --prediction_method estscan --score_matrices /path/to/score/matrices/Arabidopsis_thaliana.smat`
- **GeneFamilyClassifier pipeline**: 
  - Display all usage options: 
    - `PlantTribes/pipelines/GeneFamilyClassifier`
  - Basic run using 22Gv1.1 scaffolds, orthomcl clustering method, and blastp classifier:
    - `PlantTribes/pipelines/GeneFamilyClassifier --proteins proteins.fasta --scaffold 22Gv1.1 --method orthomcl --classifier blastp`
- **PhylogenomicsAnalysis pipeline**: 
  - Display all usage options: 
    - `PlantTribes/pipelines/PhylogenomicsAnalysis`
  - Basic run using 22Gv1.1 scaffolds, orthomcl clustering method, and raxml Phylogenetic trees inference method:
    - `PlantTribes/pipelines/PhylogenomicsAnalysis --orthogroup_faa geneFamilyClassification_dir/orthogroups_fasta --scaffold 22Gv1.1  --method orthomcl  --add_alignments  --tree_inference raxml`
- **KaKsAnalysis pipeline**
  - Coming soon!

## Pipeline options

#### AssemblyPostProcesser pipeline
```
Required Options:

--transcripts <string>          : de novo transcriptome assembly fasta file (transcripts.fasta)

--prediction_method <string>    : The prediction method for coding regions
                                  If ESTScan: estscan
                                  If TransDecoder: transdecoder

--score_matrices <string>       : Required if the coding regions prediction method is ESTScan
                                  (i.e. Arabidopsis_thaliana.smat, Oryza_sativa.smat, Zea_mays.smat)
                                  
Target Gene Family Assembly:

--gene_family_search <string>   : File with a list of orthogroup identifiers for target gene families to assemble
                                  - requires "--scaffold" and "--method" 
                                  
--scaffold <string>             : Orthogroups or gene families proteins scaffold - required by "--gene_family_search"
                                  If Angiosperms clusters (version 1.0): 22Gv1.0
                                  If Angiosperms clusters (version 1.1): 22Gv1.1	

--method <string>               : Protein clustering method - required by "--gene_family_search"
                                  If GFam: gfam
                                  If OrthoFinder: orthofinder
                                  If OrthoMCL: orthomcl

--gap_trimming <float>          : Removes gappy sites in alignments (i.e. 0.1 removes sites with 90% gaps): [0.0 to 1.0]
                                  Default: 0.1
   
Others Options:

--strand_specific               : If de novo transcriptome assembly was performed with strand-specific library
                                  Default: not strand-specific 

--dereplicate                   : Remove reapeated sequences in predicted coding regions

--min_length <int>              : Minimum sequence length of predicted coding regions

--num_threads <int>             : number of threads (CPUs) - only required for targeted gene family assembly                                                               Default: 1
```
#### GeneFamilyClassifier 
```
Required Options:

--proteins <string>             : Amino acids (proteins) sequences fasta file (proteins.fasta)

--scaffold <string>             : Orthogroups or gene families proteins scaffold
                                  If Angiosperms clusters (version 1.0): 22Gv1.0
                                  If Angiosperms clusters (version 1.1): 22Gv1.1

--method <string>               : Protein clustering method
                                  If GFam: gfam
                                  If OrthoFinder: orthofinder
                                  If OrthoMCL: orthomcl

--classifier <string>           : Protein classification method 
                                  If BLASTP: blastp
                                  If HMMScan: hmmscan
                                  If BLASTP and HMMScan: both
                  
Others Options:

--num_threads <int>             : number of threads (CPUs) to used for HMMScan, BLASTP, and MAFFT
                                  Default: 1 

--super_orthogroups <string>    : SuperOrthogroups MCL clustering - blastp e-value matrix between all pairs of orthogroups
                                  If minimum e-value: min_evalue (default) 
                                  If average e-value: avg_evalue

--single_copy_custom		        : Single copy orthogroup custom selection - incompatible with "--single_copy_taxa"
                                  (see the single copy configuration files the config directory of the distribution
                                  on how to customize the single copy selection)	
                                    
--single_copy_taxa <int>        : Minumum single copy taxa required in orthogroup - incompatible with "--single_copy_custom"

--taxa_present <int>            : Minumum taxa required in single copy orthogroup - requires "--single_copy_taxa"

--orthogroup_fasta              : Create orthogroup fasta files - requires "--coding_sequences" for CDS orthogroup fasta
                                    
--coding_sequences <string>     : Corresponding coding sequences (CDS) fasta file (cds.fasta)
```
#### PhylogenomicsAnalysis pipeline
```

```
#### KaKsAnalysis pipeline
Coming soon!

## Configuration files


## Scaffold data


## Helper scripts


## Test data


## Others


## License
PlantTribes is distributed under the GNU GPL v3. For more information, see [license](../LICENSE).

