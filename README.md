# PlantTribes

## Overview
PlantTribes is a collection of automated modular analysis pipelines that utilize objective classifications of complete protein sequences from sequenced plant genomes to perform comparative evolutionary studies. It post-processes *de novo* assembly transcripts into putative coding sequences and their corresponding amino acid translations, locally assembles targeted gene families, estimates paralogous/orthologous pairwise synonymous/non-synonymous substitution rates for a set of gene sequences, classifies gene sequences into pre-computed orthologous plant gene family clusters, and builds gene family multiple sequence alignments and their corresponding phylogenies. 

Please cite: Wafula, E. K., Zhang, H., Kuster, G. V., Leebens-Mack, J. H., Honaas, L. A., and dePamphilis, C. W. (2023). PlantTribes2: Tools for comparative gene family analysis in plant genomics. Front Plant Sci 13, 1011199. [doi: 10.3389/fpls.2022.1011199](https://www.frontiersin.org/articles/10.3389/fpls.2022.1011199/full).  

Please submit all questions, inquires, and bugs using the PlantTribes repository [issues](https://github.com/dePamphilis/PlantTribes/issues) tab.

In addition to this README file, you can consult the PlantTribes [manual](docs/PlantTribes.md) for more detailed information.

## Installation
PlantTribes pipeline can be installed manualy, via [bioconda](https://bioconda.github.io/index.html), or via a container such as [docker](https://www.docker.com/) or [singularity](https://sylabs.io/#:~:text=Singularity%20is%20a%20widely%2Dadopted,into%20a%20single%20file%20(SIF)).  
If manual installation is preferred, external dependencies need to be installed and available on the environment's $PATH before the pipelines can be used.
#### Pipelines dependencies
- **AssemblyPostProcessor pipeline**:  
[ESTScan (version 2.1)](http://estscan.sourceforge.net/), [TransDecoder (version 5.5.0)](https://github.com/TransDecoder/TransDecoder/releases), [HMMSearch (HMMER version 3.1b1)](http://hmmer.janelia.org/),  
[MAFFT (version 7.215 )](http://mafft.cbrc.jp/alignment/software/), [trimAl (version 1.4.rev8)](http://trimal.cgenomics.org/), and [GenomeTools (version 1.5.4)](http://genometools.org/).
- **GeneFamilyClassifier pipeline**:  
[BLASTP (NCBI BLAST version 2.2.29+)](http://blast.ncbi.nlm.nih.gov/Blast.cgi?PAGE_TYPE=BlastDocs&DOC_TYPE=Download), and [HMMScan (HMMER version 3.1b1)](http://hmmer.janelia.org/).
- **PhylogenomicsAnalysis pipeline (legacy pipeline)**:  
[MAFFT (version 7.215 )](http://mafft.cbrc.jp/alignment/software/), [PASTA](https://github.com/smirarab/pasta), [trimAl (version 1.4.rev8)](http://trimal.cgenomics.org/), [RAxML (version 8.1.16)](http://sco.h-its.org/exelixis/web/software/raxml/index.html),  
and [FastTreeMP (version 2.1.7 SSE3)](http://meta.microbesonline.org/fasttree/).
- **GeneFamilyIntegrator**:  
No external dependencies required.
- **GeneFamilyAligner pipeline**:  
[MAFFT (version 7.215 )](http://mafft.cbrc.jp/alignment/software/), [PASTA](https://github.com/smirarab/pasta), and [trimAl (version 1.4.rev8)](http://trimal.cgenomics.org/).
- **GeneFamilyPhylogenyBuilder pipeline**:  
[RAxML (version 8.1.16)](http://sco.h-its.org/exelixis/web/software/raxml/index.html), and [FastTreeMP (version 2.1.7 SSE3)](http://meta.microbesonline.org/fasttree/).
- **KaKsAnalysis pipeline**:   
[MAKEBLASTDB/BLASTN (NCBI BLAST version 2.2.29+)](http://blast.ncbi.nlm.nih.gov/Blast.cgi?PAGE_TYPE=BlastDocs&DOC_TYPE=Download), [CRB-BLAST (version 0.6.9)](https://github.com/cboursnell/crb-blast), [MAFFT (version 7.215 )](http://mafft.cbrc.jp/alignment/software/), [PAML (version 4.8)](http://abacus.gene.ucl.ac.uk/software/paml.html#download),  
and [EMMIX (version 1.3)](https://people.smp.uq.edu.au/GeoffMcLachlan/emmix/emmix.html).

#### PlantTribes scaffolds datasets  
[PlantTribes gene family scaffolds download website](http://bigdata.bx.psu.edu/PlantTribes_scaffolds/)  

#### Manual installation
1. Open a terminal and change to the location where you would to keep PlantTribes. 
  - Example: `cd ~/softwares`
2. Clone the [PlantTribes](https://github.com/dePamphilis/PlantTribes) GitHub repository or download the [zip archive](https://github.com/dePamphilis/PlantTribes/archive/master.zip) and decompress it in your desired location.   
  - Examples: `git clone https://github.com/dePamphilis/PlantTribes.git` or `unzip https://github.com/dePamphilis/PlantTribes/archive/master.zip`
3. Download the scaffold data set(s) that you would like to use into the PlantTribes' [data](data) subdirectory and decompress them.
  - Examples: `cd PlantTribes/data`, `md5sum 22Gv1.1.tar.bz` (should match the provided MD5 checksum for the data archive), followed by `tar -xjvf 22Gv1.1.tar.bz2`

#### Install via Bioconda
1. With an activated Bioconda channel, install with:  
  - `conda install plant_tribes_assembly_post_processor`  
2. Replace `plant_tribes_assembly_post_processor` with other [mudule names](https://bioconda.github.io/search.html?q=PlantTribes) to install other modules.  
3. Alternatively, you can create a new environment with `conda create -n <your_env>` before installing PlantTribes.  

#### Install via docker
1. Use docker pull to install with:
  - `docker pull quay.io/biocontainers/plant_tribes_assembly_post_processor:<tag>`
    tags/ versions for each module are listed in the repository tags page, replace `<tag>` with the tag ID you want to use to install the correponding version of the module.  
2. Replace `plant_tribes_assembly_post_processor` with other [mudule names](https://bioconda.github.io/search.html?q=PlantTribes) and the corresponding tag to install.  

#### Install via Singularity
1. You can install and execute the module in one command! For example:
  - `singularity exec -B ${PWD} docker://quay.io/biocontainers/plant_tribes_gene_family_phylogeny_builder:1.0.4--hdfd78af_1 /usr/local/bin/GeneFamilyPhylogenyBuilder`
2. Replace `plant_tribes_gene_family_phylogeny_builder` and the `<tag>` with the desired module and correpsonding tag to run other modules.

## Using PlantTribes
The execulables for the PlantTribes pipelines are in the [pipelines](pipelines) subdrectory of the installation. You can either add them to your PATH environment variable or execute directly from the PlantTribes installation.

- **AssemblyPostProcessor pipeline**: 
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
- **GeneFamilyIntegrator**: 
  - Display all usage options: 
    - `PlantTribes/pipelines/GeneFamilyIntegrator`
  - Basic run using 22Gv1.1 scaffolds, orthomcl clustering method:
    - `GeneFamilyIntegrator --orthogroup_faa geneFamilyClassification_dir/orthogroups_fasta --scaffold 22Gv1.1  --method orthomcl`
- **GeneFamilyAligner pipeline**:  
  - Display all usage options: 
    - `PlantTribes/pipelines/GeneFamilyAligner`
  - Basic run using 22Gv1.1 scaffolds, orthomcl clustering method, and mafft alignment method:
    - `GeneFamilyAligner --orthogroup_faa integratedGeneFamilies_dir --alignment_method mafft`
- **GeneFamilyPhylogenyBuilder pipeline**:  
  - Display all usage options: 
    - `PlantTribes/pipelines/GeneFamilyPhylogenyBuilder`
  - Basic run using 22Gv1.1 scaffolds, orthomcl clustering method, and fastree Phylogenetic trees inference method:
    - `GeneFamilyPhylogenyBuilder --orthogroup_aln geneFamilyAlignments_dir/orthogroups_aln --tree_inference fasttree`     
- **KaKsAnalysis pipeline**
  - Display all usage options:
    - `PlantTribes/pipelines/KaKsAnalysis`
  - Basic run using for paralogous analysis:
    - `KaKsAnalysis --coding_sequences_species_1 species1.fna --proteins_species_1 species1.faa --comparison paralogs --num_threads 4`

Please consult the PlantTribes [manual](docs/PlantTribes.md) and [tutorial](docs/Tutorial.md) for a detailed description and usage of all options for the pipelines respectively.

## License
PlantTribes is distributed under the GNU GPL v3. For more information, see [license](LICENSE).
