# PlantTribes Tutorial
This tutorial uses the test data `assembly.fasta`, a small set of *de novo* transcriptome contigs, located in the [test](../test) sub-directory of PlantTribes installation to show how to perform an analysis using the various pipelines of PlantTribes.

### AssemblyPostProcesser Pipeline
1). The following command will post processes `assembly.fasta` using ESTScan coding regions prediction method with aid of Arabidopsis thaliana  references matrices in strand specific mode, and removes similar (sub)sequences and sequences shorter than 200 bp.

`PlantTribes/pipelines/AssemblyPostProcesser  --transcripts assembly.fasta --prediction_method estscan --score_matrices /path/to/score/matrices//Arabidopsis_thaliana.smat --strand_specific --dereplicate --min_length 200`

2). The following command as in 1) above will post processes `assembly.fasta` using TransDecoder coding regions prediction method in strand specific mode, and remove similar (sub)sequences and sequences shorter than 200 bp.

`PlantTribes/pipelines/AssemblyPostProcesser --transcripts assembly.fasta --prediction_method transdecoder --strand_specific --dereplicate --min_length 200`

The commands in 1) and 2) will create an output directory `assemblyPostProcessing_dir` with the following fasta files:
```
transcripts.cds - primary output of predicted cds by the coding regions predictor
transcripts.pep - primary output of predicted peptide by the coding regions predictor
transcripts.cleaned.cds - cleaned and validated predicted cds with sequences shorter than 200 bp removed
transcripts.cleaned.cds - cleaned and validated predicted peptides with sequences shorter than 200 bp removed
transcripts.cleaned.nr.cds - cleaned and validated predicted cds with sequences shorter than 200 bp and similar (sub)sequences removed
transcripts.cleaned.nr.pep - cleaned and validated predicted peptides with sequences shorter than 200 bp and similar (sub)sequences removed
```
3). Running either of the commands in 1) and 2) togther with the targeted gene family options will additionally create a `targeted_gene_families` sub-directory within `assemblyPostProcessing_dir` output directory. The following command will post processes `assembly.fasta` using TransDecoder coding regions prediction method in strand specific mode, remove similar (sub)sequences and sequences shorter than 200 bp, and attempt to reassemble fragmented contigs assigned to targeted gene families into contiguous transcripts whenever possible.

`PlantTribes/pipelines/AssemblyPostProcesser  --transcripts assembly.fasta --prediction_method transdecoder --gene_family_search targetOrthos.ids --scaffold 22Gv1.1 --method orthomcl --strand_specific --dereplicate --min_length 200 --num_threads 10`

Within the `targeted_gene_families` direcorty are several sub-directories of gene families (orthogroups) listed in the `targetOrthos.ids` file located in the [test](../test) sub-directory of PlantTribes installation. In each of these sub-directories are the following output files (using orthogroup 213 of the OrthoMCL classification scaffold 22Gv1.1 as an example).
```
213.contigs.fasta - reassembled contigs for the gene family
213.contigs.fasta.cds - post processed predicted cds
213.contigs.fasta.pep - post processed predicted peptides
213.contigs.fasta.stats - summary coverage statistics for assembled sequences
```

### GeneFamilyClassifier Pipeline
1). Gene family classification of the post processed `assembly.fasta` *de novo* transcripts using **BLASTP** as a classifier - faster.

`GeneFamilyClassifier --proteins assemblyPostProcessing_dir/transcripts.cleaned.nr.pep --scaffold 22Gv1.1 --method orthomcl --classifier blastp --num_threads 10`
```
Output:
proteins.blastp.22Gv1.1
proteins.blastp.22Gv1.1.bestOrthos
proteins.blastp.22Gv1.1.bestOrthos.summary
```
2). Gene family classification of the post processed `assembly.fasta` *de novo* transcripts using **HMMScan** as a classifier - slower but more sensitive to remote homologs.

`GeneFamilyClassifier --proteins assemblyPostProcessing_dir/transcripts.cleaned.nr.pep --scaffold 22Gv1.1 --method orthomcl --classifier hmmscan --num_threads 10`
```
Output:
proteins.hmmscan.22Gv1.1
proteins.hmmscan.22Gv1.1.bestOrthos
proteins.hmmscan.22Gv1.1.bestOrthos.summary
```
3). Gene family classification of the post processed `assembly.fasta` *de novo* transcripts using both **BLASTP** and **HMMScan** as a classifiers - more exhaustive.

`GeneFamilyClassifier --proteins assemblyPostProcessing_dir/transcripts.cleaned.nr.pep --scaffold 22Gv1.1 --method orthomcl --classifier both --num_threads 10`
```
Output:

```
