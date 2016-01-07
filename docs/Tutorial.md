# PlantTribes Tutorial
This tutorial uses the test data `assembly.fasta`, a small set of *de novo* transcriptome contigs, in the [test](../test) sub-directory of PlantTribes installation to show how to perform an analysis using the various pipelines of PlantTribes.

### AssemblyPostProcesser Pipeline
1). The following command will post processes `assembly.fasta` using ESTScan coding regions prediction method with aid of Arabidopsis thaliana  references matrices in strand specific mode, and removes similar (sub)sequences and sequences shorter than 200 bp.

`PlantTribes/pipelines/AssemblyPostProcesser  --transcripts assembly.fasta --prediction_method estscan --score_matrices /path/to/score/matrices//Arabidopsis_thaliana.smat --strand_specific --dereplicate --min_length 200`

2). The following command as in 1) above will post processes `assembly.fasta` using TransDecoder coding regions prediction method in strand specific mode, and remove similar (sub)sequences and sequences shorter than 200 bp.

`PlantTribes/pipelines/AssemblyPostProcesser  --transcripts assembly.fasta --prediction_method transdecoder --strand_specific --dereplicate --min_length 200`

The commands in 1) and 2) will create an output directory `assemblyPostProcessing_dir` with the following fasta files:
```
transcripts.cds - primary output of predicted cds by the coding regions predictor
transcripts.pep - primary output of predicted peptide by the coding regions predictor
transcripts.cleaned.cds - cleaned and validated predicted cds with sequences shorter than 200 bp removed
transcripts.cleaned.cds - cleaned and validated predicted peptides with sequences shorter than 200 bp removed
transcripts.cleaned.nr.cds - cleaned and validated predicted cds with sequences shorter than 200 bp and similar (sub)sequences removed
transcripts.cleaned.nr.pep - cleaned and validated predicted peptides with sequences shorter than 200 bp and similar (sub)sequences removed
```
3). Running either of the commands in 1) and 2) togther with the the target gene family options will additionally create a `targeted_gene_families` directory within `assemblyPostProcessing_dir` containing several sub-directories of gene families listed in the  targetOrthos.ids file in the [test](../test).

`PlantTribes/pipelines/AssemblyPostProcesser  --transcripts assembly.fasta --prediction_method transdecoder --gene_family_search targetOrthos.ids --scaffold 22Gv1.1 --method orthomcl --strand_specific --dereplicate --min_length 200`

