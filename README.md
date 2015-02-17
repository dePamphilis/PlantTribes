# PlantTribes
## Overview
PlantTribes is a collection of automated modular sequence and gene family  analysis pipelines for plant evolutionary studies. It post-processes *de novo* assembly transcripts into putative coding sequences and their corresponding amino acid translations, estimates paralogous/orthologous pairwise synonymous/non-synonymous substitution rates for a set of gene sequences, classifies gene sequences into pre-computed orthologous plant gene family clusters, and builds gene family multiple sequence alignments and their corresponding phylogenies.

All questions and inquires should be addressed to our user email group: `PlantTribes-users@googlegroups.com`

In addition to this README file, you can consult the PlantTribes [manual](docs/PlantTribes_manual.md) more detailed information.

## Installation
PlantTribes pipeline scripts have many external dependencies that need to be installed before the pipelines can used. Executables of external dependencies should be set in the **_plantTribes.config_** file that is in the **_config_** subdirectory of the installation. 
#### Pipeline Dependencies
- **AssemblyPostProcesser pipeline**:  
[ESTScan (ESTScan 2.1)](http://estscan.sourceforge.net/), [TransDecoder (TransDecoder v2.0.1)](https://github.com/TransDecoder/TransDecoder/releases), and [GenomeTools (GenomeTools 1.5.4)](http://genometools.org/).
- **GeneFamilyClassifier pipeline**:  
[BLASTP (NCBI BLAST 2.2.29+)](http://blast.ncbi.nlm.nih.gov/Blast.cgi?PAGE_TYPE=BlastDocs&DOC_TYPE=Download), and [HMMScan (HMMER 3.1b1)](http://hmmer.janelia.org/).
- **PhylogenomicsAnalysis pipeline**:  
[MAFFT (MAFFT v7.215 )](http://mafft.cbrc.jp/alignment/software/), [PASTA](https://github.com/smirarab/pasta]), [trimAl (trimAl v1.4.rev8)](http://trimal.cgenomics.org/), [RAxML (RAxML version 8.1.16)](http://sco.h-its.org/exelixis/web/software/raxml/index.html), and [FastTreeMP (FastTree version 2.1.7 SSE3)](http://meta.microbesonline.org/fasttree/).
- **kaksAnalysis pipeline**:  
[BLASTP (NCBI BLAST 2.2.29+)](http://blast.ncbi.nlm.nih.gov/Blast.cgi?PAGE_TYPE=BlastDocs&DOC_TYPE=Download), [PAML (PALM version 4.8)](http://abacus.gene.ucl.ac.uk/software/paml.html#download), [EMMIX (version 1.01)](http://www.maths.uq.edu.au/~gjm/), and [mclust (mclust version 4)](http://www.stat.washington.edu/mclust/).

