# PlantTribes Tutorial
This tutorial uses the test data `assembly.fasta`, a small set of *de novo* transcriptome contigs, in the [test](../test) subdirectory of PlantTribes installation to show how to perform an analysis using the various pipelines of PlantTribes.

The following command will post processes `assembly.fasta` using ESTScan coding regions prediction method with aid of Arabidopsis thaliana  references matrices in strand specific mode, and remove similar (sub)sequences and sequences shorter than 200 bp.
