# PlantTribes Tutorial
This tutorial uses the test data `assembly.fasta`, a small set of *de novo* transcriptome contigs, located in the [test](../test) sub-directory of PlantTribes installation to show how to perform an analysis using the various pipelines of PlantTribes.

### AssemblyPostProcesser Pipeline
1). The following command will post processes `assembly.fasta` using ESTScan coding regions prediction method with aid of Arabidopsis thaliana  references matrices in strand specific mode, and removes similar (sub)sequences and sequences shorter than 200 bp.

`PlantTribes/pipelines/AssemblyPostProcesser  --transcripts assembly.fasta --prediction_method estscan --score_matrices /path/to/score/matrices//Arabidopsis_thaliana.smat --strand_specific --dereplicate --min_length 200`

2). The following command as in 1) above will post processes `assembly.fasta` using TransDecoder coding regions prediction method in strand specific mode, and remove similar (sub)sequences and sequences shorter than 200 bp.

`PlantTribes/pipelines/AssemblyPostProcesser --transcripts assembly.fasta --prediction_method transdecoder --strand_specific --dereplicate --min_length 200`

```
Output:
assemblyPostProcessing_dir/transcripts.cds
assemblyPostProcessing_dir/transcripts.pep
assemblyPostProcessing_dir/transcripts.cleaned.cds
assemblyPostProcessing_dir/transcripts.cleaned.cds
assemblyPostProcessing_dir/transcripts.cleaned.nr.cds
assemblyPostProcessing_dir/transcripts.cleaned.nr.pep 
```
3). Including the targeted gene family options to the commands in 1) and 2) attempt to reassemble fragmented contigs assigned to targeted gene families (orthogroups) listed in the `targetOrthos.ids` file located in the [test](../test) sub-directory of PlantTribes installation into contiguous transcripts whenever possible.

`PlantTribes/pipelines/AssemblyPostProcesser  --transcripts assembly.fasta --prediction_method transdecoder --gene_family_search targetOrthos.ids --scaffold 22Gv1.1 --method orthomcl --strand_specific --dereplicate --min_length 200 --num_threads 10`

```
Output:
assemblyPostProcessing_dir/targeted_gene_families/213.contigs.fasta
assemblyPostProcessing_dir/targeted_gene_families/213.contigs.fasta.cds
assemblyPostProcessing_dir/targeted_gene_families/213.contigs.fasta.pep
assemblyPostProcessing_dir/targeted_gene_families/213.contigs.fasta.stats
```

### GeneFamilyClassifier Pipeline
1). Gene family classification of the post processed `assembly.fasta` *de novo* transcripts using **BLASTP** as a classifier - faster.

`PlantTribes/pipelines/GeneFamilyClassifier --proteins assemblyPostProcessing_dir/transcripts.cleaned.nr.pep --scaffold 22Gv1.1 --method orthomcl --classifier blastp --num_threads 10`
```
Output:
geneFamilyClassification_dir/proteins.blastp.22Gv1.1
geneFamilyClassification_dir/proteins.blastp.22Gv1.1.bestOrthos
geneFamilyClassification_dir/proteins.blastp.22Gv1.1.bestOrthos.summary
```
2). Gene family classification of the post processed `assembly.fasta` *de novo* transcripts using **HMMScan** as a classifier - slower but more sensitive to remote homologs.

`PlantTribes/pipelines/GeneFamilyClassifier --proteins assemblyPostProcessing_dir/transcripts.cleaned.nr.pep --scaffold 22Gv1.1 --method orthomcl --classifier hmmscan --num_threads 10`
```
Output:
geneFamilyClassification_dir/proteins.hmmscan.22Gv1.1
geneFamilyClassification_dir/proteins.hmmscan.22Gv1.1.bestOrthos
geneFamilyClassification_dir/proteins.hmmscan.22Gv1.1.bestOrthos.summary
```
3). Gene family classification of the post processed `assembly.fasta` *de novo* transcripts using both **BLASTP** and **HMMScan** as a classifiers - more exhaustive.

`PlantTribes/pipelines/GeneFamilyClassifier --proteins assemblyPostProcessing_dir/transcripts.cleaned.nr.pep --scaffold 22Gv1.1 --method orthomcl --classifier both --num_threads 10`
```
Output:
geneFamilyClassification_dir/proteins.blastp.22Gv1.1
geneFamilyClassification_dir/proteins.blastp.22Gv1.1.bestOrthos
geneFamilyClassification_dir/proteins.hmmscan.22Gv1.1
geneFamilyClassification_dir/proteins.hmmscan.22Gv1.1.bestOrthos
geneFamilyClassification_dir/proteins.both.22Gv1.1.bestOrthos
geneFamilyClassification_dir/proteins.both.22Gv1.1.bestOrthos.summary
```
4). Customizing the selection of single/low copy gene families by taxa. Example of a customized single/low copy selection configuration file, `22Gv1.1.singleCopy.config` is located in the [config](../config) sub-directory of PlantTribes installation.

`PlantTribes/pipelines/GeneFamilyClassifier --proteins assemblyPostProcessing_dir/transcripts.cleaned.nr.pep --scaffold 22Gv1.1 --method orthomcl --classifier both --single_copy_custom  --num_threads 10`

5). Alternative single/low copy gene families selection command

`PlantTribes/pipelines/GeneFamilyClassifier --proteins assemblyPostProcessing_dir/transcripts.cleaned.nr.pep --scaffold 22Gv1.1 --method orthomcl --classifier both --single_copy_taxa 20 --taxa_present 21 --num_threads 10`
```
Output:
geneFamilyClassification_dir/proteins.blastp.22Gv1.1
geneFamilyClassification_dir/proteins.blastp.22Gv1.1.bestOrthos
geneFamilyClassification_dir/proteins.hmmscan.22Gv1.1
geneFamilyClassification_dir/proteins.hmmscan.22Gv1.1.bestOrthos
geneFamilyClassification_dir/proteins.both.22Gv1.1.bestOrthos
geneFamilyClassification_dir/proteins.both.22Gv1.1.bestOrthos.summary
geneFamilyClassification_dir/proteins.both.22Gv1.1.bestOrthos.summary.singleCopy
```
6). Creating gene family fasta files (cds and their corresponding peptide) for the post processed  *de novo* transcriptome assembly. 

`PlantTribes/pipelines/GeneFamilyClassifier --proteins assemblyPostProcessing_dir/transcripts.cleaned.nr.pep --scaffold 22Gv1.1 --method orthomcl --classifier both --single_copy_taxa 20 --taxa_present 21 --num_threads 10 --orthogroup_fasta --coding_sequences assemblyPostProcessing_dir/transcripts.cleaned.nr.cds`
```
Output:
geneFamilyClassification_dir/proteins.blastp.22Gv1.1
geneFamilyClassification_dir/proteins.blastp.22Gv1.1.bestOrthos
geneFamilyClassification_dir/proteins.hmmscan.22Gv1.1
geneFamilyClassification_dir/proteins.hmmscan.22Gv1.1.bestOrthos
geneFamilyClassification_dir/proteins.both.22Gv1.1.bestOrthos
geneFamilyClassification_dir/proteins.both.22Gv1.1.bestOrthos.summary
geneFamilyClassification_dir/proteins.both.22Gv1.1.bestOrthos.summary.singleCopy
geneFamilyClassification_dir/orthogroups_fasta - transcriptome assembly orthogroup fasta directory
geneFamilyClassification_dir/single_copy_fasta - transcriptome assembly single/low copy orthogroup fasta directory
```

### PhylogenomicsAnalysis Pipeline
1).  Integrating post processed *de novo* transcriptome assembly sequence(s) with the scaffold gene family sequences 

`PlantTribes/pipelines/PhylogenomicsAnalysis --orthogroup_faa geneFamilyClassification_dir/orthogroups_fasta --scaffold 22Gv1.1  --method orthomcl --orthogroup_fna`
```
Output:
phylogenomicsAnalysis_dir/orthogroups_fasta/ - orthogroup fasta directory
```
2). Creating gene family multiple sequence alignments using MAFFT L-INS-i iterative refinement method 

`PlantTribes/pipelines/PhylogenomicsAnalysis --orthogroup_faa geneFamilyClassification_dir/orthogroups_fasta --scaffold 22Gv1.1  --method orthomcl --create_alignments`

3). Adding unaligned post processed *de novo* transcriptome assembly sequence(s) into precomputed scaffold gene family multiple sequence alignments - faster

`PlantTribes/pipelines/PhylogenomicsAnalysis --orthogroup_faa geneFamilyClassification_dir/orthogroups_fasta --scaffold 22Gv1.1  --method orthomcl --add_alignments`

4). Creating gene family multiple sequence alignments using PASTA (Practical Alignment using SATe and Transitivity) method - for larger data sets 

`PlantTribes/pipelines/PhylogenomicsAnalysis --orthogroup_faa geneFamilyClassification_dir/orthogroups_fasta --scaffold 22Gv1.1  --method orthomcl --pasta_alignments`
```
Output:
phylogenomicsAnalysis_dir/orthogroups_fasta/ - orthogroup fasta directory
phylogenomicsAnalysis_dir/orthogroups_aln/ - orthogroup multiple sequence alignments directory
```
5). Building maximum-likelihood gene family phylogenetic trees with RAxML

`PlantTribes/pipelines/PhylogenomicsAnalysis --orthogroup_faa geneFamilyClassification_dir/orthogroups_fasta --scaffold 22Gv1.1  --method orthomcl --pasta_alignments --tree_inference raxml`

6). Building approximately-maximum-likelihood gene family phylogenetic trees with FastTree - faster

`PlantTribes/pipelines/PhylogenomicsAnalysis --orthogroup_faa geneFamilyClassification_dir/orthogroups_fasta --scaffold 22Gv1.1  --method orthomcl --pasta_alignments --tree_inference fasttree`

```
Output:
phylogenomicsAnalysis_dir/orthogroups_fasta/ - orthogroup fasta directory
phylogenomicsAnalysis_dir/orthogroups_aln/ - orthogroup multiple sequence alignments directory
```

Additonal optimization option not used this tutorial are explained in the 




