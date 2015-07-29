Datasets
--------

MIGEC
^^^^^

A pipeline for processing of RepSeq data, focused on UMI-tagged 
reads. There are 5 steps of MIGEC pipeline:

-  **Checkout** De-multiplexing, UMI sequence extraction, 
   read re-orientation, adapter trimming
-  **Histogram** UMI coverage statistics
-  **Assemble** Assemble consensus sequences from reads
   tagged with the same UMI. Filters out low-coverage and
   erroneous UMIs.
-  **CdrBlast** V-(D)-J mapping and clonotype assembly
-  **FilterCdrBlastResults** Additional correction of 
   hot-spot errors.
   
**Latest binaries**: https://github.com/mikessh/migec/releases/latest
**Docs**: http://migec.readthedocs.org/en/latest/
   
MITCR
^^^^^

A software for fast and robust processing of TCR sequencing 
data. The software performs V-(D)-J mapping, clonotype assembly 
with frequency-based error correction and low-quality read 
rescue via re-mapping to assembled clonotypes.

**Latest binaries**: http://mitcr.milaboratory.com/downloads/
**Docs**: http://mitcr.milaboratory.com/documentation/

VDJtools
^^^^^^^^

A framework for post-analysis of immune repertoire sequencing 
data. Includes 20+ analysis modules: from simple routines such 
as spectratyping to diversity estimation and repertoire clustering
modules.

**Latest binaries**: https://github.com/mikessh/vdjtools/releases/latest
**Docs**: http://vdjtools-doc.readthedocs.org/en/latest/modules.html